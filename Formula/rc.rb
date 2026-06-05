# ReverseContact CLI formula.
#
# The monorepo (visum-run/reversecontact) is private, so release assets are
# fetched through the GitHub API with a token instead of the public download
# URL. Set HOMEBREW_GITHUB_API_TOKEN to a token that can read the repo:
#
#   export HOMEBREW_GITHUB_API_TOKEN="$(gh auth token)"
#   brew install visum-run/tap/rc
#
# Once releases move to a public repo, drop the download strategy and the
# `using:` arguments below.
class GitHubPrivateReleaseDownloadStrategy < CurlDownloadStrategy
  def initialize(url, name, version, **meta)
    super
    match = url.match(%r{https://github\.com/([^/]+)/([^/]+)/releases/download/(.+)/([^/]+)\z})
    raise CurlDownloadStrategyError, "Invalid GitHub release URL: #{url}" unless match

    @owner, @repo, @tag, @filename = match.captures
  end

  private

  def github_token
    token = ENV["HOMEBREW_GITHUB_API_TOKEN"].to_s
    raise CurlDownloadStrategyError, "HOMEBREW_GITHUB_API_TOKEN is required for private releases" if token.empty?

    token
  end

  def asset_id
    @asset_id ||= begin
      require "json"
      release_url = "https://api.github.com/repos/#{@owner}/#{@repo}/releases/tags/#{@tag}"
      output = Utils.popen_read("curl", "-sf", "-H", "Authorization: token #{github_token}", release_url)
      release = JSON.parse(output)
      asset = (release["assets"] || []).find { |a| a["name"] == @filename }
      raise CurlDownloadStrategyError, "Asset #{@filename} not found in release #{@tag}" unless asset

      asset["id"]
    end
  end

  def _fetch(url:, resolved_url:, timeout:)
    curl_download(
      "https://api.github.com/repos/#{@owner}/#{@repo}/releases/assets/#{asset_id}",
      "--header", "Authorization: token #{github_token}",
      "--header", "Accept: application/octet-stream",
      to: temporary_path, timeout: timeout
    )
  end
end

class Rc < Formula
  desc "ReverseContact CLI: enrich and search people and companies from your terminal"
  homepage "https://www.reversecontact.com"
  version "0.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/visum-run/reversecontact/releases/download/cli/v0.1.0/rc-darwin-arm64",
          using: GitHubPrivateReleaseDownloadStrategy
      sha256 "2236cbc19b9bd72f64891b49c1293105bebd710c30a87b97b1aeab1494d271cb"
    else
      url "https://github.com/visum-run/reversecontact/releases/download/cli/v0.1.0/rc-darwin-x64",
          using: GitHubPrivateReleaseDownloadStrategy
      sha256 "ed154d4540632bc5284d3a84b677b337e930437493871b8d1bc50a3c0d493fb2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/visum-run/reversecontact/releases/download/cli/v0.1.0/rc-linux-arm64",
          using: GitHubPrivateReleaseDownloadStrategy
      sha256 "8996902dba18f9bb5de22e52d5c13e327e36d8befc62eb60861c52eb9af7eff1"
    else
      url "https://github.com/visum-run/reversecontact/releases/download/cli/v0.1.0/rc-linux-x64",
          using: GitHubPrivateReleaseDownloadStrategy
      sha256 "12488d032d247eac75c4cd2d4d3f0611cf58fb930abfc88c977300fdeaf956d9"
    end
  end

  def install
    binary = Dir["rc-*"].first
    raise "rc binary not found in staging directory" unless binary

    bin.install binary => "rc"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rc --version")
  end
end

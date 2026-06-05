# ReverseContact CLI formula.
#
# Binaries are public archives served from app.reversecontact.com (backed by
# ReverseContact's storage CDN), so no token is needed:
#
#   brew install visum-run/tap/rc
#
# Release procedure: tag cli/vX.Y.Z on visum-run/reversecontact (the release
# workflow publishes the archives), then update `version`, the URLs, and the
# sha256 values below from https://app.reversecontact.com/cli/vX.Y.Z/SHA256SUMS.
class Rc < Formula
  desc "ReverseContact CLI: enrich and search people and companies from your terminal"
  homepage "https://www.reversecontact.com"
  version "0.1.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://app.reversecontact.com/cli/v0.1.2/rc-darwin-arm64.tar.gz"
      sha256 "26b8391c12c0ab8f7d383c27868f868fff21ea44329d9536dd776a072986c201"
    else
      url "https://app.reversecontact.com/cli/v0.1.2/rc-darwin-x64.tar.gz"
      sha256 "3756d9b1351afae317f02b8d0e8d0bee993dc6045063ac2d8bc10e5e6d224ceb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://app.reversecontact.com/cli/v0.1.2/rc-linux-arm64.tar.gz"
      sha256 "a4286d7f788ace6b3e30c4c8f61be6d54f0cf180cfbbb79d2cc095bf6aadfd48"
    else
      url "https://app.reversecontact.com/cli/v0.1.2/rc-linux-x64.tar.gz"
      sha256 "689881d5091989b783da80b8f58293e49c46160849b0cccac3d6b0a0dcecfe7a"
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

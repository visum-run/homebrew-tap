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
  version "0.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://app.reversecontact.com/cli/v0.2.0/rc-darwin-arm64.tar.gz"
      sha256 "a0fd2373b7246cf76bd6f5d11420787c137e54c3b7f5159787d96f296c367e16"
    else
      url "https://app.reversecontact.com/cli/v0.2.0/rc-darwin-x64.tar.gz"
      sha256 "7e55d9af43f59dac9c4534b1196c51f69fb78de38239ce3e0f414fc5e9edc882"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://app.reversecontact.com/cli/v0.2.0/rc-linux-arm64.tar.gz"
      sha256 "ea293ba624365c0e12fed85a3d872ee3b7fad04b57d4135b61ddaf82b60837bf"
    else
      url "https://app.reversecontact.com/cli/v0.2.0/rc-linux-x64.tar.gz"
      sha256 "f1a364b7ac9e3dee45fb8bf87be69309c6c2cb588b5a99de1f1ca81b62436736"
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

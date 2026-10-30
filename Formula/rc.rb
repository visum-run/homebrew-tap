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
  version "0.6.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://app.reversecontact.com/cli/v0.6.0/rc-darwin-arm64.tar.gz"
      sha256 "76de260a579e82d445f98bcc51550d2c6dcba457aeeb8153cfc7ff5ff40dfc3f"
    else
      url "https://app.reversecontact.com/cli/v0.6.0/rc-darwin-x64.tar.gz"
      sha256 "0f0343ab0d0f9b0ffc79dd289722ddb47ec37a7de17bf332ea6dbfcee87af88b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://app.reversecontact.com/cli/v0.6.0/rc-linux-arm64.tar.gz"
      sha256 "3dee7d37051f8a93171606090bb6c2d7ffc78c040d5239fc63a426a4cf853f19"
    else
      url "https://app.reversecontact.com/cli/v0.6.0/rc-linux-x64.tar.gz"
      sha256 "dbd2bf82cbd07f874da2095d9931d3f1931e9688c0d6df80c012dfcf1abdf366"
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

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
  version "0.5.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://app.reversecontact.com/cli/v0.5.0/rc-darwin-arm64.tar.gz"
      sha256 "5cba4b1455c53c6e876600edf7510ead43d54854a4def4a8465d2b6c3b64cf32"
    else
      url "https://app.reversecontact.com/cli/v0.5.0/rc-darwin-x64.tar.gz"
      sha256 "1326663ac58477b88e6686f61e5320c42e6a3e6d8122cdecb95a32107e21300e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://app.reversecontact.com/cli/v0.5.0/rc-linux-arm64.tar.gz"
      sha256 "075bcaa3901ff768c7ac4a233e0064f2e0177ff5fd688f438fb44dd45cd63c0f"
    else
      url "https://app.reversecontact.com/cli/v0.5.0/rc-linux-x64.tar.gz"
      sha256 "f2cce78981adc7c354e15f2cadadeb76b29937b84f9f84454c12b578ab38ab00"
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

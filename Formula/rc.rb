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
  version "0.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://app.reversecontact.com/cli/v0.4.0/rc-darwin-arm64.tar.gz"
      sha256 "1be96536dc2fdc8cbe1ccd37c4a28792cb480a813073fe28aecec3a35b4ad270"
    else
      url "https://app.reversecontact.com/cli/v0.4.0/rc-darwin-x64.tar.gz"
      sha256 "c594275743b3efa1909e1d41650758c825de1d32fb64a059fd770feba7dd0d5b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://app.reversecontact.com/cli/v0.4.0/rc-linux-arm64.tar.gz"
      sha256 "15588a4efb32b9358a3ae318dd47068d5f54446c3745634a0bdb4e9adc7c9b34"
    else
      url "https://app.reversecontact.com/cli/v0.4.0/rc-linux-x64.tar.gz"
      sha256 "babbc9235becb1c98d124fefa7a13975d8147b14a7ab68f416d58e22b72e5e56"
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

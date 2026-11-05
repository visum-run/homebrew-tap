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
  version "0.8.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://app.reversecontact.com/cli/v0.8.0/rc-darwin-arm64.tar.gz"
      sha256 "7b3d4fb3b9d2771fdbabef04ec90762ce50ea877bc0a0b4a3ad77f784ae97db0"
    else
      url "https://app.reversecontact.com/cli/v0.8.0/rc-darwin-x64.tar.gz"
      sha256 "0b71c799595bfebe62f982bab4351eb0ec371ae5744cf6970a9bebc516cb1055"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://app.reversecontact.com/cli/v0.8.0/rc-linux-arm64.tar.gz"
      sha256 "ad0a40f50055a1a45435535866a67ef18fc414e0a1eb792d903efe69dcfe8cfc"
    else
      url "https://app.reversecontact.com/cli/v0.8.0/rc-linux-x64.tar.gz"
      sha256 "8d3faa448d465a6cc8e7b9a8cee62107c5e12789351d4519e4892f91613141c6"
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

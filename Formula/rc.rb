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
  version "0.7.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://app.reversecontact.com/cli/v0.7.0/rc-darwin-arm64.tar.gz"
      sha256 "2e682f754ace0bd5d285683bcaa2eb60a52efac01161a8c1a0b4fdd0aea1ffa9"
    else
      url "https://app.reversecontact.com/cli/v0.7.0/rc-darwin-x64.tar.gz"
      sha256 "f882d7bc4e556ca631186e6e11909605d0521a361bea2d42e4df15f4bbd8dce3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://app.reversecontact.com/cli/v0.7.0/rc-linux-arm64.tar.gz"
      sha256 "589459a8cad88cba50cd351257727dbc6d1453d68ff698a38e742bd063d518e0"
    else
      url "https://app.reversecontact.com/cli/v0.7.0/rc-linux-x64.tar.gz"
      sha256 "23eba442f17fba586fd6b29baab5f91a4abbabf54d21269e5e24a231726d8b08"
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

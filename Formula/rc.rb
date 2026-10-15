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
  version "0.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://app.reversecontact.com/cli/v0.3.0/rc-darwin-arm64.tar.gz"
      sha256 "bcbe38c2938a164d6bee3937cf34c11ae78012eda6d8b38425c3c6ac05964d49"
    else
      url "https://app.reversecontact.com/cli/v0.3.0/rc-darwin-x64.tar.gz"
      sha256 "db7c6abcff82dd8cea732c1d3aa5d659da0bec00af11b8146b6fc6ecc302ca30"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://app.reversecontact.com/cli/v0.3.0/rc-linux-arm64.tar.gz"
      sha256 "e84a75339f6eb38f611689fc1d8d185b3ccbf22bb7465d330dfac3dc9cc34c06"
    else
      url "https://app.reversecontact.com/cli/v0.3.0/rc-linux-x64.tar.gz"
      sha256 "7d85b804b7485aa8b2da1ed318228e4af5db17cf06f0ea1deb6a099608485e14"
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

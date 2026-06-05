# ReverseContact CLI formula.
#
# Binaries are distributed as public archives on ReverseContact's storage
# bucket, so no token is needed:
#
#   brew install visum-run/tap/rc
#
# Release procedure: tag cli/vX.Y.Z on visum-run/reversecontact (the release
# workflow publishes the archives), then update `version`, the URLs, and the
# sha256 values below from <bucket>/vX.Y.Z/SHA256SUMS.
class Rc < Formula
  desc "ReverseContact CLI: enrich and search people and companies from your terminal"
  homepage "https://www.reversecontact.com"
  version "0.1.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://ighnalfpeslhsseflvxa.supabase.co/storage/v1/object/public/cli/v0.1.1/rc-darwin-arm64.tar.gz"
      sha256 "8da479033d59380649600f37e761285dd190efe0847a11902c24e7ce040c646c"
    else
      url "https://ighnalfpeslhsseflvxa.supabase.co/storage/v1/object/public/cli/v0.1.1/rc-darwin-x64.tar.gz"
      sha256 "929cbc7fbda914c151d07402cf78c62eb52db49d3c7a7946a5c5c80990c507f9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://ighnalfpeslhsseflvxa.supabase.co/storage/v1/object/public/cli/v0.1.1/rc-linux-arm64.tar.gz"
      sha256 "b7399729327d7d5a826428c471580ec942092f9858e77abfaa7f7bf4d8401535"
    else
      url "https://ighnalfpeslhsseflvxa.supabase.co/storage/v1/object/public/cli/v0.1.1/rc-linux-x64.tar.gz"
      sha256 "8993fddc790fd77ba88e8e5eec9342d3c85facef11822b66d6b061f07e1018f2"
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

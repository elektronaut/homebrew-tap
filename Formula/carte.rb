# frozen_string_literal: true

class Carte < Formula
  desc "Runs your apps' processes on demand behind *.test hostnames"
  homepage "https://github.com/elektronaut/carte"
  url "https://github.com/elektronaut/carte/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "549d0825ac05ac804e0ce123535996e2e9920282e9b918911db8d291153940fd"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on :macos

  resource "binary" do
    on_arm do
      url "https://github.com/elektronaut/carte/releases/download/v0.6.0/carte-0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "3010b7ec1431c88ca4bd8bc9f0345df31ad941d552243f0d35638f3d61d1dd14"
    end
    on_intel do
      url "https://github.com/elektronaut/carte/releases/download/v0.6.0/carte-0.6.0-x86_64-apple-darwin.tar.gz"
      sha256 "96e24c40ded1e20e2d8dbe5380dd46557ef5f29895ac176ffd2815b821791f27"
    end
  end

  def install
    resource("binary").stage { bin.install "carte" }
  end

  def caveats
    <<~EOS
      Run `carte setup` once to install the daemon, DNS resolver and local CA.
      It pins #{opt_bin}/carte, so upgrades keep working.
    EOS
  end

  test do
    assert_match "carte #{version}", shell_output("#{bin}/carte --version")
  end
end

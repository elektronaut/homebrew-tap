# frozen_string_literal: true

class Carte < Formula
  desc "Runs your apps' processes on demand behind *.test hostnames"
  homepage "https://github.com/elektronaut/carte"
  url "https://github.com/elektronaut/carte/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "181986251c188a6e506d337225783f9f5df341f3de23228829ec464dd8fef3d2"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on :macos

  resource "binary" do
    on_arm do
      url "https://github.com/elektronaut/carte/releases/download/v0.7.0/carte-0.7.0-aarch64-apple-darwin.tar.gz"
      sha256 "a20e45d52d36ed5e2c9f0eab1da577bbdea87285736739aac5e07ea6f4a09b03"
    end
    on_intel do
      url "https://github.com/elektronaut/carte/releases/download/v0.7.0/carte-0.7.0-x86_64-apple-darwin.tar.gz"
      sha256 "d7c984588b46b47fbe6c7c14f846df9f5ecf733db6e22198d526e1fca91c5eb5"
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

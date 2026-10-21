# frozen_string_literal: true

class Carte < Formula
  desc "Runs your apps' processes on demand behind *.test hostnames"
  homepage "https://github.com/elektronaut/carte"
  url "https://github.com/elektronaut/carte/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "ce270ea0873c64261a9cc092320037895b174fb64713aad08c508f974fe89d80"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on :macos

  resource "binary" do
    on_arm do
      url "https://github.com/elektronaut/carte/releases/download/v0.5.0/carte-0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "e4203e1cd1b41c44382758395b32531a862bc147a77efc16b9711f5cbaedb4c5"
    end
    on_intel do
      url "https://github.com/elektronaut/carte/releases/download/v0.5.0/carte-0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "4502d6639787753edd4947528b7e19c3a32aceb97ec679d41fa0fcbdc3865649"
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

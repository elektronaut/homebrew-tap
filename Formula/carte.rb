# frozen_string_literal: true

class Carte < Formula
  desc "Runs your apps' processes on demand behind *.test hostnames"
  homepage "https://github.com/elektronaut/carte"
  url "https://github.com/elektronaut/carte/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "a1290bfd8c8b70cf2a76de99813b54d49c21f45be9d29e5261ea6a68bd046885"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on :macos

  resource "binary" do
    on_arm do
      url "https://github.com/elektronaut/carte/releases/download/v0.4.0/carte-0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "4f61df53f002c892522c2ce47e7dfa35503f0218efc5c800f2a45a8648d95f26"
    end
    on_intel do
      url "https://github.com/elektronaut/carte/releases/download/v0.4.0/carte-0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "36f07fedcf7a1e57214be3e68e0846e32f9d387281f13b38f1fc42e271f7e20c"
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

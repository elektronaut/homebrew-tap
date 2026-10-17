# frozen_string_literal: true

class Carte < Formula
  desc "Runs your apps' processes on demand behind *.test hostnames"
  homepage "https://github.com/elektronaut/carte"
  version "0.1.0"
  license "MIT"

  on_arm do
    url "https://github.com/elektronaut/carte/releases/download/v0.1.0/carte-0.1.0-aarch64-apple-darwin.tar.gz"
    sha256 "2fd2b5a18ce1d0cb82bc2af2663aa9fe0806a2e6119bb0bbb3a7fad3c52b28d6"
  end

  on_intel do
    url "https://github.com/elektronaut/carte/releases/download/v0.1.0/carte-0.1.0-x86_64-apple-darwin.tar.gz"
    sha256 "c8f83aaaff396ea1903d20fb7dcf133e324b1bffaa764bef1f5f99e1cb09b97f"
  end

  depends_on :macos

  def install
    bin.install "carte"
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

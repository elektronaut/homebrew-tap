# frozen_string_literal: true

class Carte < Formula
  desc "Runs your apps' processes on demand behind *.test hostnames"
  homepage "https://github.com/elektronaut/carte"
  version "0.2.0"
  license "MIT"

  on_arm do
    url "https://github.com/elektronaut/carte/releases/download/v0.2.0/carte-0.2.0-aarch64-apple-darwin.tar.gz"
    sha256 "e6536b30e367c0485f16e4a0fa3269a7ffc7f13994023caae35b02f6537307f9"
  end

  on_intel do
    url "https://github.com/elektronaut/carte/releases/download/v0.2.0/carte-0.2.0-x86_64-apple-darwin.tar.gz"
    sha256 "9921ee241878c7b71fa911c6162c2f2141a2da5d22793750af19ee8d9591b481"
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

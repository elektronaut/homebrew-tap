# frozen_string_literal: true

class Carte < Formula
  desc "Runs your apps' processes on demand behind *.test hostnames"
  homepage "https://github.com/elektronaut/carte"
  version "0.3.0"
  license "MIT"

  on_arm do
    url "https://github.com/elektronaut/carte/releases/download/v0.3.0/carte-0.3.0-aarch64-apple-darwin.tar.gz"
    sha256 "8f6055464ad009336661088e40787300e02610dbe0037791d72593fe1a04b300"
  end

  on_intel do
    url "https://github.com/elektronaut/carte/releases/download/v0.3.0/carte-0.3.0-x86_64-apple-darwin.tar.gz"
    sha256 "fe18e7597bf5347d1e2306f3e947570db41a93f7b2d29c02aef0ba7c2d0754ed"
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

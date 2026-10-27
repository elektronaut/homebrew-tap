# frozen_string_literal: true

# The native badline, built from the `rake native:pack` tarball attached to
# each release. The release workflow copies this file into the tap with the
# release's url and sha256 filled in.
class Badline < Formula
  desc "Cycle-accurate Commodore 64 emulator"
  homepage "https://github.com/elektronaut/badline"
  url "https://github.com/elektronaut/badline/releases/download/v0.19.0/badline-0.19.0-spinel-01e999a0e.tar.gz"
  sha256 "d4ee02b0e01da1edf67a5e6b2777108017f3b2e55f52a87e4c4eb2112e552ec9"
  license "MIT"

  bottle do
    root_url "https://github.com/elektronaut/homebrew-tap/releases/download/badline-0.19.0"
    sha256 cellar: :any, arm64_sequoia: "5b79ff41af37df9189d92d01e347c4d27fd58b31fd4ca1466a0097ac452222f9"
    sha256 cellar: :any, x86_64_linux:  "8747cbc5c8faaca029fa0eef4f86fd9a3992b08acccd118c58279d5065142aa1"
  end

  depends_on "sdl2"

  uses_from_macos "libxcrypt"

  def install
    system "make"
    libexec.install "badline"
    pkgshare.install "roms"
    (bin / "badline").write_env_script libexec / "badline",
                                       BADLINE_ROM_PATH: "${BADLINE_ROM_PATH:-#{pkgshare}/roms}"
  end

  test do
    assert_match "badline #{version}", shell_output("#{bin}/badline --version")

    ENV["SDL_VIDEODRIVER"] = "dummy"
    ENV["SDL_RENDER_DRIVER"] = "software"
    ENV["SDL_AUDIODRIVER"] = "dummy"
    system bin / "badline", "--unpaced", "--no-sound", "--frames", "10", "--screenshot", testpath / "frame.bmp"
    assert_path_exists testpath / "frame.bmp"
  end
end

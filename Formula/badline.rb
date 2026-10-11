# frozen_string_literal: true

# The native badline, built from the `rake native:pack` tarball attached to
# each release. The release workflow copies this file into the tap with the
# release's url and sha256 filled in.
class Badline < Formula
  desc "Cycle-accurate Commodore 64 emulator"
  homepage "https://github.com/elektronaut/badline"
  url "https://github.com/elektronaut/badline/releases/download/v0.14.0/badline-0.14.0-spinel-442854c1d.tar.gz"
  sha256 "f3cb5bf94cfceea434805646cfac79ccb20ff934d01c64c3f2711ef86c528c4e"
  license "MIT"

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

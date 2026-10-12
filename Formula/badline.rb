# frozen_string_literal: true

# The native badline, built from the `rake native:pack` tarball attached to
# each release. The release workflow copies this file into the tap with the
# release's url and sha256 filled in.
class Badline < Formula
  desc "Cycle-accurate Commodore 64 emulator"
  homepage "https://github.com/elektronaut/badline"
  url "https://github.com/elektronaut/badline/releases/download/v0.15.1/badline-0.15.1-spinel-c5fb71a71.tar.gz"
  sha256 "738d3ec5a748e147c7b37a33898aa22cbdc5f25b480f5a5448a204ec65473b0b"
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

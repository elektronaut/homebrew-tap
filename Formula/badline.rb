# frozen_string_literal: true

# The native badline, built from the `rake native:pack` tarball attached to
# each release. The release workflow copies this file into the tap with the
# release's url and sha256 filled in.
class Badline < Formula
  desc "Cycle-accurate Commodore 64 emulator"
  homepage "https://github.com/elektronaut/badline"
  url "https://github.com/elektronaut/badline/releases/download/v0.18.0/badline-0.18.0-spinel-84c965208.tar.gz"
  sha256 "d5b63a0f389d9340607c65ff43526e4621ecf5217249edc07e1c723a056302ca"
  license "MIT"

  bottle do
    root_url "https://github.com/elektronaut/homebrew-tap/releases/download/badline-0.18.0"
    sha256 cellar: :any, arm64_sequoia: "98c2e3a7faaa85d264b78c5a45bd420955a1c5ac1643eabca05bd6364161fe08"
    sha256 cellar: :any, x86_64_linux:  "44dbc843884f8ffed881589204ae6868df7bb09313d96e8fdd2a0a0d0bafe10d"
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

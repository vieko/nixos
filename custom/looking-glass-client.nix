{ stdenv, fetchFromGitHub, fetchpatch
, cmake, pkgconfig, SDL2, SDL, SDL2_ttf, openssl, spice-protocol, fontconfig
, libX11, freefont_ttf, nettle, libconfig, wayland, libpthreadstubs, libXdmcp
, libXfixes, libbfd, libXi, libffi, expat, clang, binutils-unwrapped
}:

stdenv.mkDerivation rec {
  pname = "looking-glass-client";
  version = "B2";
  gcc = clang;
  binutils = binutils-unwrapped;
  NIX_CFLAGS_COMPILE = "-msse4.1";
  # hardeningDisable = [ "all" ];

  src = fetchFromGitHub {
    owner = "gnif";
    repo = "LookingGlass";
    rev = version;
    # sha256 = stdenv.lib.fakeSha256;
    sha256 = "sha256:100b5kzh8gr81kzw5fdqz2jsms25hv3815d31vy3qd6lrlm5gs3d";
    fetchSubmodules = true;
    leaveDotGit = false;
  };

  nativeBuildInputs = [ pkgconfig ];

  buildInputs = [
    SDL SDL2 SDL2_ttf openssl spice-protocol fontconfig
    libX11 freefont_ttf nettle libconfig wayland libpthreadstubs
    libXdmcp libXfixes libbfd libXi libffi expat cmake
  ];

  enableParallelBuilding = true;
  impureUseNativeOptimizations = false;

  sourceRoot = "source/client";

  installPhase = ''
    mkdir -p $out/bin
    mv looking-glass-client $out/bin
  '';

  meta = with stdenv.lib; {
    description = "A KVM Frame Relay (KVMFR) implementation";
    longDescription = ''
      Looking Glass is an open source application that allows the use of a KVM
      (Kernel-based Virtual Machine) configured for VGA PCI Pass-through
      without an attached physical monitor, keyboard or mouse. This is the final
      step required to move away from dual booting with other operating systems
      for legacy programs that require high performance graphics.
    '';
    homepage = "https://looking-glass.hostfission.com/";
    license = licenses.gpl2Plus;
    maintainers = [ maintainers.alexbakker ];
    platforms = [ "x86_64-linux" ];
  };
}

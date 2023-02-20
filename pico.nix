{ pkgs ? import <nixpkgs> {} }:
let fhs = pkgs.buildFHSUserEnv {
  name = "pico8";
  targetPkgs = pkgs: (with pkgs; [
    xorg.libX11
    xorg.libXext
    xorg.libXcursor
    xorg.libXinerama
    xorg.libXi
    xorg.libXrandr
    xorg.libXScrnSaver
    xorg.libXxf86vm
    xorg.libxcb
    xorg.libXrender
    xorg.libXfixes
    xorg.libXau
    xorg.libXdmcp
    alsa-lib
    udev
  ]);
  runScript = "bash -c ~/Applications/pico-8/pico8";
};
in pkgs.stdenv.mkDerivation {
  name = "pico8-shell";
  nativeBuildInputs = [ fhs ];
  shellHook = ''
     exec pico8
    '';
}

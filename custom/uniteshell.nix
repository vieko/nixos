{ stdenv, fetchFromGitHub, pkgs, ... }:

stdenv.mkDerivation rec {
  pname = "gnome-shell-extension-unite-shell";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "hardpixel";
    repo = "unite-shell";
    rev = "master";
    # sha256 = "0000000000000000000000000000000000000000000000000000";
    sha256 = "0nqc1q2yz4xa3fdfx45w6da1wijmdwzhdrch0mqwblgbpjr4fs9g";
  };

  # nativeBuildInputs = [ pkgs.xorg.xprop ];

  makeFlags = [ "INSTALLBASE=$(out)/share/gnome-shell/extensions" ];
}

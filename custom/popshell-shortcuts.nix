{ stdenv, fetchFromGitHub, cargo, rustc }:

stdenv.mkDerivation rec {
  pname = "gnome-shell-extension-popshell-shortcuts";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "shell-shortcuts";
    rev = "master_focal";
    sha256 = "08ljyr0gjka6fs05v6gnz39x8y099cargpp0cbb2qb944s0gbg1z";
  };

  nativeBuildInputs = [cargo rustc];

  makeFlags = [ "INSTALLBASE=$(out)/share/gnome-shell/extensions" ];
}

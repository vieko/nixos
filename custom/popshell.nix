{ stdenv, fetchFromGitHub, nodejs, nodePackages, glib }:

stdenv.mkDerivation rec {
  pname = "gnome-shell-extension-popshell";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "shell";
    rev = "master_focal";
    sha256 = "0wyx9yg6afxh7cqirarcbsqmqqdfhrxwqnafjdxxsn4aywajx5p8";
  };

  nativeBuildInputs = [ nodePackages.typescript glib ];

  makeFlags = [ "INSTALLBASE=$(out)/share/gnome-shell/extensions" ];
}

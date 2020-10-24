{ stdenv, fetchFromGitHub, nodejs, nodePackages, glib }:

stdenv.mkDerivation rec {
  pname = "gnome-shell-extension-popshell";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "vieko";
    repo = "shell";
    rev = "hint-tweaks";
    # sha256 = "0wyx9yg6afxh7cqirarcbsqmqqdfhrxwqnafjdxxsn4aywajx5p8";
    # sha256 = "0000000000000000000000000000000000000000000000000000";
    sha256 = "0mqpbbd9hsr827yiapyxny5k88ybzhc4p2g12mv1l1fj4flnh0dc";
  };

  nativeBuildInputs = [ nodePackages.typescript glib ];

  makeFlags = [ "INSTALLBASE=$(out)/share/gnome-shell/extensions" ];
}

{ stdenv, fetchurl, gtksourceview, libgee, libgnome-keyring, dpkg }:

stdenv.mkDerivation rec {
  pname = "tableplus";
  version = "0.1.64";

  src = fetchurl {
    url =
      "https://deb.tableplus.com/debian/pool/main/t/tableplus/tableplus_${version}_amd64.deb";
    sha256 = "b12b3dc9e804d2de390a4c8581c2d56fce9bc69390250b6fa39e7754cec4ccee";
  };

  nativeBuildInputs =
    [ dpkg ];

  buildInputs = [
    gtksourceview
    libgee
    libgnome-keyring
  ];

  dontBuild = true;
  dontConfigure = true;

  unpackPhase = "dpkg-deb -x $src .";

  installPhase = ''
    mkdir -p $out/share/tableplus $out/lib $out/bin

    mv opt/tableplus/* $out/share/tableplus

    ln -s $out/share/tableplus/tableplus $out/bin/tableplus
    sed -i 's|\/opt\/tableplus|'$out'/bin|g' $out/share/tableplus/tableplus.desktop
  '';

  meta = with stdenv.lib; {
    homepage = "https://tableplus.com";
    description = "Database management made easy";
    license = licenses.mit;
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ vieko ];
  };

}

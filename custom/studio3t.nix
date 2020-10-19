with import <nixpkgs> {};

stdenv.mkDerivation rec{
  name = "studio3t";
  src = fetchurl {
    url =
      "https://download.studio3t.com/studio-3t/linux/2020.9.0/studio-3t-linux-x64.tar.gz";
    sha256 = "01d3c3859dbc261a141a90433ffdd7f6d25bd8bcbc698792a0051a47ede01f85";
  };
  setSourceRoot = "sourceRoot=`pwd`";
  installPhase = ''
    mkdir -p $out/bin
    cp studio-3t-linux-x64.sh $out/bin/${name}
  '';
}

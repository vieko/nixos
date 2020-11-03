{stdenv,fetchurl,openssl,zlib,autoPatchelfHook,lib} :
  let 
    hostname = "binaries.prisma.sh";
    release = "2.1.x/latest/debian-openssl-1.1.x";
    baseUrl = "https://${hostname}/${release}/";
    hashes = {
      introspection-engine = "0b180c8f27853764e170489615bb04c872bec906c81405651e2220fc73b6fa1f";
      migration-engine = "cc7ea91d300a85b8e2759378e50fe8bf981a76196973f8cdbb60c6aa5db28833";
      prisma-fmt = "dc3c5caca2f6cc1b5a41d0f13a9f048834fb0b9511e6ad772090e24a8288688f";
      query-engine = "787ea0e646a2b897d6c5cd7989c0a20c21e5c1a4905001cf0a69a2d412262985";
    };
    files = lib.mapAttrs (name: sha256: fetchurl {
      url = "${baseUrl}${name}.gz";
      inherit sha256;
    }) hashes;
    unzipCommands = lib.mapAttrsToList (name: file: "gunzip -c ${file} > $out/bin/${name}") files;
  in
  stdenv.mkDerivation rec {
    pname = "prisma-bin";
    version = "2.1.x";
    nativeBuildInputs = [
      autoPatchelfHook
      zlib
      openssl
    ];
    phases = ["buildPhase" "postFixupHooks" ];
    buildPhase = ''
      mkdir -p $out/bin
      ${lib.concatStringsSep "\n" unzipCommands}
      chmod +x $out/bin/*
    '';
  }

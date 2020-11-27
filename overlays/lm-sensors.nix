self: super:

{
  lm-sensors = super.lm-sensors.overrideAttrs (
    old: rec {
      makeFlags = [
        "PREFIX=${placeholder "out"}"
        "ETCDIR=${placeholder "out"}/etc"
        "CC=${stdenv.cc.targetPrefix}cc"
        "AR=${stdenv.cc.targetPrefix}ar"
        "PROG_EXTRA=sensord"
      ];
    }
  );
}

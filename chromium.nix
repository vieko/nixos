{ ... }:

let
  ext = {
    dark-reader        = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
    toggl-track        = "oejgccbfbmkkpaidnkphaiaecficdnfn";
    picture-in-picture = "hkgfoiooedgoejojocmhlaklaeopbecg";
  };
in
  {
    programs.chromium = {
      enable     = true;
      extensions = builtins.attrValues ext;
    };
  }

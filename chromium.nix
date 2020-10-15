{ pkgs, ... }:

{
  programs.chromium = {
    enable     = true;
    extensions = builtins.attrValues {
      # TODO: finish adding extensions
      dark-reader        = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
      toggl-track        = "oejgccbfbmkkpaidnkphaiaecficdnfn";
      picture-in-picture = "hkgfoiooedgoejojocmhlaklaeopbecg";
    };
  };
}

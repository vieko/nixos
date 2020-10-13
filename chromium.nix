{ pkgs, ... }:

{
  programs.google-chrome = {
    enable     = true;
    extensions = {
      dark-reader        = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
      toggl-track        = "oejgccbfbmkkpaidnkphaiaecficdnfn";
      picture-in-picture = "hkgfoiooedgoejojocmhlaklaeopbecg";
    };
  };
}

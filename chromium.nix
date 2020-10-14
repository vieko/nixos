{ pkgs, ... }:

{
  programs.chromium = {
    enable     = true;
    extensions = builtins.attrValues {
      dark-reader        = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
      toggl-track        = "oejgccbfbmkkpaidnkphaiaecficdnfn";
      picture-in-picture = "hkgfoiooedgoejojocmhlaklaeopbecg";
    };
  };

  environment.systemPackages = with pkgs; [
    chromium
  ];
}

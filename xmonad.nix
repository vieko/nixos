{ confing, lib, pkgs, ... }:

{
  services = {
    gnome3.gnome-keyring.enable = true;
    upower.enable = true;

    dbus = {
      enable = true;
      packages = [ pkgs.gnome3.dconf ];
    };

    xserver = {
      enable = true;

      libinput = {
        enable = true;
        disableWhileTyping = true;
      };

      serverLayoutSection =  ''
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime"     "0"
      '';

      displayManager = {
        defaultSession = "none+xmonad";
      };
      
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };

      # xkbOptions = "caps:ctrl_modifier";
    };
  };

  # hardware.bluetooth.enable = true;
  # services.blueman.enable = true;

  systemd.services.upower.enable = true;
}

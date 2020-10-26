{ config, pkgs, ... }:

{
  services = {
    xserver =  {
      enable = true;
      layout = "us";
      displayManager = {
        gdm = {
          enable = true;
          wayland = false; 
          autoSuspend = false;
        };
        sessionCommands = ''
          # fixes issue with Looking Glass
          export SDL_VIDEO_X11_VISUALID=
        '';
      };
      desktopManager.gnome3.enable = true;
    };
    # dbus.packages = [ pkgs.gnome3.dconf ];
    # udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];
  };
  environment.systemPackages = with pkgs; [
    gnome3.gnome-shell-extensions
    gnome3.networkmanagerapplet
    gnome3.gnome-tweaks
    ant-dracula-theme
    gnomeExtensions.sound-output-device-chooser
    # gnomeExtensions.dash-to-panel # breaks things
  ];

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
}

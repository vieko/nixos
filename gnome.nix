{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
in {
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
      desktopManager.gnome.enable = true;
      videoDrivers = [ "nvidia" ];
    };
    # dbus.packages = [ pkgs.gnome3.dconf ];
    # udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];
  };
  environment.systemPackages = with pkgs; [
    pop-gtk-theme
    pop-icon-theme
    networkmanagerapplet
    gnome.gnome-shell-extensions
    gnome.dconf-editor
    unstable.dracula-theme
    gnomeExtensions.pop-shell
    # gnomeExtensions.unite
    gnomeExtensions.sound-output-device-chooser
    unstable.gnomeExtensions.just-perfection
    # unstable.gnomeExtensions.color-picker
    # gnomeExtensions.dash-to-panel # breaks things
  ];

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
}

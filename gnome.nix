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
    dbus.packages = [ pkgs.gnome3.dconf ];
    udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];
  };

  environment.systemPackages = with pkgs; [
    gnome3.networkmanagerapplet
    gnome3.gnome-tweaks
    ant-dracula-theme
  ];
}

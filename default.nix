{ config, lib, pkgs, ... }:

{
  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates     = "weekly";
      options   = "--delete-older-than 7d";
    };
    extraOptions = ''
      keep-outputs     = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';
    package = pkgs.nixFlakes;
  };

  imports = [ 
      <home-manager/nixos>

      ./hardware.nix
      ./virtualization.nix
      ./chromium.nix
    ];
  
  # Allow Slack, Firefox Developer Edition, etc.
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "pandemonium";
    networkmanager.enable = true;
    wireless.enable = false;
    useDHCP = false;
    bridges.br0 = {
      interfaces = [ "eno2" ];
    };
    interfaces = {
      br0.useDHCP = true;
      eno2.useDHCP = true;
      wlo1.useDHCP = true;
    };
  };

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  environment.systemPackages = with pkgs; [
    # defaults
    coreutils
    git
    bc
    killall
    unzip
    wget 
    neovim
    gnumake
    gnome3.gnome-tweak-tool
    # VGA Passthrough
    pciutils
    gnome3.networkmanagerapplet
    virt-manager
    hwloc
    # Looking Glass Dependencies
    # nix-shell -p gcc cmake gnumake pkg-config binutils freefont_ttf SDL2 SDL2_ttf spice-protocol fontconfig xorg.libX11 nettle
    # Apps
    google-chrome
    firefox-devedition-bin
    slack
    discord

    xst
  ];

  home-manager.users.vieko = { pkgs, ... }: {
    programs.neovim = {
      enable  = true;
      plugins = with pkgs.vimPlugins; [vim-nix];
    };
  };


  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable GNOME Desktop Environment.
  services = {
    xserver =  {
      enable = true;
      layout = "us";
      displayManager = {
        gdm.enable = true;
        gdm.wayland = false; 
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vieko = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "kvm" "libvirt" "plugdev" ]; # Enable ‘sudo’ for the user.
  };

  system.stateVersion = "20.09";

}


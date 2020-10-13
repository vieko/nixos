{ config, pkgs, ... }:

let
  hostName = "pandemonium";
in {
  imports = [ 
      <home-manager/nixos>

      ./hardware.nix

      ./calgary.nix
      ./config.nix
      ./gnome.nix

      ./virtualization.nix
      #./chromium.nix
    ];

  # +> BOOT
  boot = {
    cleanTmpDir = true;
    loader = {
      systemd-boot.enable      = true;
      efi.canTouchEfiVariables = true;
    };
    plymouth.enable = false;
  };

  # +> NETWORKING
  networking = {
    inherit hostName;
    networkmanager.enable = true;
    #wireless.networks = ./private-config/wifi.nix;
    firewall.enable = false;
    useDHCP = false;
    interfaces = {
    #  br0.useDHCP = true;
    #  eno2.useDHCP = true;
      wlo1.useDHCP = true;
    };
    #bridges.br0 = {
    #  interfaces = [ "eno2" ];
    #};
  };

  # +> SERVICES
  services.openssh.enable = true;
  
  environment.systemPackages = with pkgs; [
    # defaults
    coreutils
    bc
    killall
    unzip
    gnumake
    # VGA Passthrough
    pciutils
    virt-manager
    hwloc
    # Looking Glass Dependencies
    # nix-shell -p gcc cmake gnumake pkg-config binutils freefont_ttf SDL2 SDL2_ttf spice-protocol fontconfig xorg.libX11 nettle
    # Apps
    firefox-devedition-bin
    slack
    discord
  ];

  # +>  HOME MANAGER
  home-manager.users.vieko = (import ./home.nix {
    inherit pkgs config hostName;
    home.packages = [
      pkgs.google-chrome
    ];
    programs.neovim = {
      enable  = true;
      plugins = with pkgs.vimPlugins; [vim-nix dracula-vim];
      configure = {
        customRC = builtins.readFile ./config.vim;
      };
    };
    programs.google-chrome = {
      enable     = true;
      extensions = builtins.attrValues {
        dark-reader        = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
        toggl-track        = "oejgccbfbmkkpaidnkphaiaecficdnfn";
        picture-in-picture = "hkgfoiooedgoejojocmhlaklaeopbecg";
      };
    };
  });

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # +> USERS
  users.users.vieko = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "kvm" "libvirt" "plugdev" ]; # Enable ‘sudo’ for the user.
    #shell = pkgs.zsh;
    #openssh.authorizationKeys.keys = [
    #  (builtins.readFile ../private-config/ssh/id_rsa.pub)
    #];
  };

  system.stateVersion = "20.09";

}


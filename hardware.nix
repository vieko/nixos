{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ "${modulesPath}/installer/scan/not-detected.nix" ];

  # +> BOOT
  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" ];
      kernelModules = [];
    };
    loader = {
      systemd-boot.enable      = true;
      efi.canTouchEfiVariables = true;
    };
    cleanTmpDir = true;
    plymouth.enable = true;
  };

  # +> CPU
  nix.maxJobs = lib.mkDefault "auto";
  powerManagement.cpuFreqGovernor = "performance";
  hardware.video.hidpi.enable = lib.mkDefault true;

  # +> STORAGE
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
  };
  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];

  # +> DRIVERS
  hardware.openrazer.enable = true;

  # +> SOUND
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  # hardware.pulseaudio.support32Bit = true;

  # +>OPENGL
  hardware.opengl = {
  #   enable = true;
  #   driSupport32Bit = true;
    extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  };
}

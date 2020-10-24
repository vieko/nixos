{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ "${modulesPath}/installer/scan/not-detected.nix" ];

  # +> BOOT
  boot = {
    loader = {
      systemd-boot.enable      = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" ];
      kernelModules = [];
    };
    kernelModules = [ "kvm-intel" "vhost_net" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
    kernelParams = [ "intel_iommu=on" "vfio_pci.ids=10de:1ec7,10de:10f8,10de:1ad8,10de:1ad9" ];
    extraModulePackages = [];
    extraModprobeConfig = ''options kvm ignore_msrs=1'';
    blacklistedKernelModules = [ "nvidia" "nouveau" ];
    cleanTmpDir = true;
    plymouth.enable = true;
  };

  # +> CPU
  nix.maxJobs = lib.mkDefault "auto";
  powerManagement.cpuFreqGovernor = "performance";
  hardware.cpu.intel.updateMicrocode = true;
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
  hardware.pulseaudio.support32Bit = true;

  # +>OPENGL
  hardware.opengl.driSupport32Bit = true;
}

{ config, lib, pkgs, ... }:

{
  # +> BOOT
  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" ];
      kernelModules = [];
    };
    kernelModules = [ "kvm-intel" "vhost_net" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
    kernelParams = [ "intel_iommu=on" "vfio_pci.ids=10de:1ec7,10de:10f8,10de:1ad8,10de:1ad9" ];
    extraModulePackages = [];
    extraModprobeConfig = ''options kvm ignore_msrs=1'';
    blacklistedKernelModules = [ "nvidia" "nouveau" ];
  };

  # +> NETWORKING
  networking = {
    hostName = "pandemonium";
    interfaces = {
      br0.useDHCP = true;
      eno2.useDHCP = true;
      wlo1.useDHCP = true;
    };
    bridges.br0 = {
      interfaces = [ "eno2" ];
    };
  };
}

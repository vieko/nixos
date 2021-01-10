{ config, lib, pkgs, ... }:

# RTX2070 Super FE
# == kernelParams
# "vfio_pci.ids=10de:1ec7,10de:10f8,10de:1ad8,10de:1ad9"
# == postBootCommands
# DEVS="0000:0e:00.0 0000:0e:00.1 0000:0e:00.2 0000:0e:00.3"

let it87 = config.boot.kernelPackages.callPackage ./custom/it87.nix {};
in {
  # +> BOOT
  boot = {
    kernel.sysctl."kernel.shmmax" = 34359738368;      # 1/2 RAM * 1024
    
    kernel.sysctl."vm.hugetlb_shm_group" = 302; # getent group kvm
    kernel.sysctl."vm.min_free_kbytes" = 112640;   # hugeadm --explain
    kernelModules = [ 
      # +> SENSORS
      "k10temp"
      "it87"
      # +> VFIO
      "kvm-amd" 
      "vhost_net"
      "vfio_virqfd"
      "vfio_pci"
      "vfio_iommu_type1"
      "vfio"
    ];
    kernelParams = [ 
      "amd_iommu=on" 
      "amd_iommu=pt"
      "pcie_aspm=off" 
      "hugepages=16384" # 2 mb per page x 32GB of ram to be assigned
      # "acpi_enforce_resources=lax"
      "vfio_pci.ids=10de:2206,10de:1aef" # RTX3080 OC Gaming 
    ];
    extraModulePackages = [ it87 ];
    extraModprobeConfig = ''
      options kvm ignore_msrs=1
      options it87 ignore_resource_conflict=1
    '';
    blacklistedKernelModules = [ "nvidia" "nouveau" ];
    postBootCommands = ''
      DEVS="0000:0e:00.0 0000:0e:00.1"
      for DEV in $DEVS; do
        echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
      done
      modprobe -i vfio-pci
    '';
  };
  # +> HARDWARE
  environment.etc."sysconfig/lm_sensors".text = ''
    HWMON_MODULES="it87"
  '';
  environment.etc."sensors.d/gigabyte-x570.conf".text = ''
    chip "it8688-*"
      label fan1 "CPU_FAN"
      label fan2 "SYS_FAN1"
      label fan3 "SYS_FAN2"
      label fan4 "Chipset fan"
      label fan5 "CPU_OPT"

      label temp1 "SYS1 (rear)"
      label temp2 "SYS2 (front)"
      label temp3 "CPU"
      label temp4 "PCIe"
      label temp5 "VRM"
      label temp6 "Chipset"

    chip "it8688-*"
      label in0 "Vcore"

      label in1 "+3.3V"
      compute in1 1.65*@,@/1.65

      label in2 "+12V"
      compute in2  @ * (72/12), @ / (72/12)

      label in3 "+5V"
      compute in3 2.5*@,@/2.5

      label in4 "SoC"

      label in5 "VDDP"

      label in6 "DRAM A/B"
      compute in6 @-.03,@-.03
  '';

  # +> HUGEPAGES
  environment.etc.fstab.text = "hugetlbfs /dev/hugepages hugetlbfs mode=1770,gid=302 0 0";

  # +> PRINTING
  # services.printing ={
  #   enable = true;
  #   drivers = [ pkgs.brlaser pkgs.hll2390dw-cups ];
  # };

  # +> NETWORKING
  networking = {
    hostName = "chaos";
    interfaces = {
      enp6s0.useDHCP = true;
      enp7s0.useDHCP = true;
      wlp5s0.useDHCP = true;
    };
  };
}

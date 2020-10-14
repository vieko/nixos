{ pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    qemuOvmf = true;
    qemuRunAsRoot = false;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 vieko qemu-libvirtd -"
  ];

  environment.systemPackages = with pkgs; [
    pciutils
    virt-manager
    hwloc
  ];
}

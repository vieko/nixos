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
    # "f /dev/shm/scream 0660 vieko qemu-libvirtd -"
  ];

  # systemd.user.services.scream-alsa = {
  #   enable = true;
  #   description = "Scream ALSA";
  #   serviceConfig = {
  #     ExecStart = "${pkgs.scream-receivers}/bin/scream-alsa /dev/shm/scream";
  #     Restart = "always";
  #   };
  #   wantedBy = [ "multi-user.target" ];
  #   requires = [ "pulseaudio.service" ];
  # };

  environment.systemPackages = with pkgs; [
    pciutils
    virt-manager
    hwloc
    scream-receivers
  ];
}

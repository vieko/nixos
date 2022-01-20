{ pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
in {
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      ovmf = {
        enable = true;
      };
      runAsRoot = false;
    };
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
    xdotool
    usbutils
    pciutils
    hwloc
    virt-manager
    libhugetlbfs
    # scream-receivers
    unstable.looking-glass-client
  ];
}

{
  configLib,
  inputs,
  pkgs,
  ...
}: 
{
  imports = [
    # Hardware modules
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    (configLib.relativeToRoot "hosts/common/optional/amd.nix")

    # Include the results of the hardware scan.
    ./hardware.nix

    # Load the core.
    (configLib.relativeToRoot "hosts/common/core")

    # Load services.
    (configLib.relativeToRoot "hosts/common/optional/services/ai.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/audio.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/printing.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/ssh.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/zerotierone.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/bluetooth.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/rustdesk.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/media.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/vaultwarden.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/nas.nix")

    # Load the optionals.
    # (configLib.relativeToRoot "hosts/common/optional/desktops/dwm-env.nix")
    (configLib.relativeToRoot "hosts/common/optional/desktops/hyprland-env.nix")
    (configLib.relativeToRoot "hosts/common/optional/docker.nix")
    (configLib.relativeToRoot "hosts/common/optional/learning.nix")
    (configLib.relativeToRoot "hosts/common/optional/latex.nix")

    # Load apps.
    (configLib.relativeToRoot "hosts/common/optional/desktop-apps.nix")
    (configLib.relativeToRoot "hosts/common/optional/apps/gaming.nix")

    # Load miscellaneous configurations.
    (configLib.relativeToRoot "hosts/common/optional/virtualization.nix")

    # Load user configurations.
    (configLib.relativeToRoot "hosts/common/users/norpie.nix")

    # Device specific configuration.
    (configLib.relativeToRoot "hosts/jupiter/syncthing.nix")
    (configLib.relativeToRoot "hosts/jupiter/tailscale.nix")
    
    # Remote building server
    (configLib.relativeToRoot "hosts/common/optional/remote-building-server.nix")
  ];

  networking.hostName = "jupiter";

  programs.dconf.enable = true;

  services.input-remapper = {
      enable = true;
  };

  environment.variables = {
    GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/gsettings-desktop-schemas-47.1/glib-2.0/schemas";
  };

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    wonderdraft
    # surrealdb
    obs-studio
    lsof

    super-slicer-latest
    (pkgs.symlinkJoin {
      name = "cura-appimage-wrapped";
      paths = [ pkgs.cura-appimage ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/cura \
          --add-flags "-platformtheme gtk3"
      '';
    })
    openscad-unstable

    android-studio-full
    androidenv.androidPkgs.tools
    androidenv.androidPkgs.androidsdk
    androidenv.androidPkgs.ndk-bundle
    androidenv.androidPkgs.emulator
    androidenv.androidPkgs.platform-tools
  ];

  # Backup /mnt/data/pix to /mnt/media/pix automatically daily with rsync.
  systemd.timers."backup-pix" = {
    description = "Backup /mnt/data/pix to /mnt/media/pix";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      Unit = "backup-pix.service";
    };
  };

  systemd.services."backup-pix" = {
    description = "Backup /mnt/data/pix to /mnt/media/pix";
    script = ''
        set -eu
        ${pkgs.rsync}/bin/rsync -av --delete /mnt/data/pix/ /mnt/media/pix/
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "mediamanager";
    };
  };
}

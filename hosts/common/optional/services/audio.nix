{pkgs, ...}: {
  services.pulseaudio.enable = false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    pulse = {
      enable = true;
    };

    wireplumber = {
      enable = true;
      configPackages = [
        (pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
          bluez_monitor.properties = {
                  ["bluez5.enable-sbc-xq"] = true,
                  ["bluez5.enable-msbc"] = true,
                  ["bluez5.codecs"] = "[ sbc_xq ]",
                  ["bluez5.roles"] = "[ a2dp_sink ]",
                  ["bluez5.hfphsp-backend"] = "none"
          }
        '')
      ];
    };
  };
  environment.systemPackages = with pkgs; [
    pulseaudio
    pamixer
    pavucontrol
  ];
}

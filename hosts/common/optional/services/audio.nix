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
      extraConfig = {
      #   "10-bluez" = {
      #     "monitor.bluez.properties" = {
      #       "bluez5.enable-sbc-xq" = true;
      #       "bluez5.enable-msbc" = true;
      #       "bluez5.enable-hw-volume" = true;
      #       "bluez5.roles" = [
      #         "hsp_hs"
      #         "hsp_ag"
      #         "hfp_hf"
      #         "hfp_ag"
      #       ];
      #     };
      #   };
      #   "11-bluetooth-policy" = {
      #     "wireplumber.settings" = {
      #       "bluetooth.autoswitch-to-headset-profile" = false;
      #     };
      #   };
      };
    };
  };
  environment.systemPackages = with pkgs; [
    pulseaudio
    pamixer
    pavucontrol
  ];
}

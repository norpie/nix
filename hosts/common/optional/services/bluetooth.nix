{...}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        ControllerMode = "dual";
        JustWorksRepairing = true;
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };
  services.blueman.enable = true;
}

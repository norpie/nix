{...}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        ControllerMode = "dual";
        JustWorksRepairing = true;
      };
    };
  };
  services.blueman.enable = true;
}

{
  configLib,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    # ./hardware-configuration.nix
    (configLib.relativeToRoot "hosts/vm/hardware-configuration.nix")

    # Load the core.
    (configLib.relativeToRoot "hosts/common/core")

    # Load services.
    (configLib.relativeToRoot "hosts/common/optional/services/sync.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/ssh.nix")

    # Load the optionals.
    (configLib.relativeToRoot "hosts/common/optional/dwm-env.nix")

    # Load user configurations.
    (configLib.relativeToRoot "hosts/common/users/norpie.nix")
  ];

  networking.hostName = "vm";
}

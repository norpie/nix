{ pkgs, ... }:
{
  # Udev rules for HyperX Cloud Alpha Wireless headset
  # This allows the current logged-in user to access the USB receiver
  # Required for battery monitoring scripts to work without sudo

  services.udev.extraRules = ''
    # HyperX Cloud Alpha Wireless (HP)
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="03f0", ATTRS{idProduct}=="098d", MODE="0660", GROUP="plugdev", TAG+="uaccess"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="03f0", ATTRS{idProduct}=="098d", MODE="0660", GROUP="plugdev", TAG+="uaccess"
  '';

  # Add plugdev group and add user to it for USB device access
  users.groups.plugdev = {};
  users.users.norpie.extraGroups = [ "plugdev" ];

  # HID communication tool for battery monitoring
  environment.systemPackages = with pkgs; [
    hidapitester
  ];
}

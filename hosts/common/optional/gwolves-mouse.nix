{ pkgs, ... }:
{
  # Udev rules for G-Wolves mouse web-based configuration software
  # This allows the current logged-in user to access the USB receiver
  # Required for mouse.xyz web interface to work on Linux

  services.udev.extraRules = ''
    # G-Wolves HSK Pro 8K Receiver (Product ID: 5817)
    # Allows Web HID access for mouse.xyz configuration interface
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="33e4", ATTRS{idProduct}=="5817", MODE="0660", GROUP="plugdev", TAG+="uaccess"

    # G-Wolves HSK Pro Mouse - Wired mode (Product ID: 5808)
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="33e4", ATTRS{idProduct}=="5808", MODE="0660", GROUP="plugdev", TAG+="uaccess"

    # HID interface permissions for wireless receiver
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="33e4", ATTRS{idProduct}=="5817", MODE="0660", GROUP="plugdev", TAG+="uaccess"

    # HID interface permissions for wired mouse
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="33e4", ATTRS{idProduct}=="5808", MODE="0660", GROUP="plugdev", TAG+="uaccess"
  '';

  # Add plugdev group and add user to it for USB device access
  users.groups.plugdev = {};
  users.users.norpie.extraGroups = [ "plugdev" ];

  # Note: The web-based software (mouse.xyz) requires a Chromium-based browser
  # Supported browsers: Chrome, Edge, Chromium
  # Not supported: Vivaldi (despite being Chromium-based)

  # Additional packages that might be helpful for mouse configuration
  environment.systemPackages = with pkgs; [
    # Google Chrome is already in desktop-apps.nix
    # Chromium could be added as an alternative
    # chromium
  ];
}

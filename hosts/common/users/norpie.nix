{pkgs, ...}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.norpie = {
    isNormalUser = true;
    description = "Konsta Kuosmanen";
    extraGroups = ["cups" "networkmanager" "wheel"];
    hashedPassword = "$6$yrmuKldtP/mKYReB$9w8pTeEmK/oY2xnY2mG5Wwj6N72qoeoYp.zIHpPS7/inQrR70LU0dNvjUFc0hTFvS9BcwUV9XY2.girsF8JyN.";
  };

  security.sudo.wheelNeedsPassword = false;
}

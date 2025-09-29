{pkgs, ...}: {
  nixpkgs.config.joypixels.acceptLicense = true;
  fonts = {
    packages = with pkgs; [
      font-awesome
      material-icons
      material-design-icons
      roboto
      work-sans
      comic-neue
      source-sans
      twemoji-color-font
      comfortaa
      inter
      lato
      lexend
      jost
      dejavu_fonts
      iosevka-bin
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      jetbrains-mono
      source-sans-pro
      jetbrains-mono
      ubuntu_font_family
      nerd-fonts.jetbrains-mono
      nerd-fonts.droid-sans-mono
      joypixels
      lmodern
      lmmath
    ];

    fontconfig = {
      defaultFonts = {
        emoji = [ "Twitter Color Emoji" "Noto Color Emoji" "JoyPixels" ];
        monospace = [ "JetBrainsMonoNL Nerd Font" "JetBrains Mono" ];
      };
    };
  };
}

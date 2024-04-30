{...}: {
  services = {
    syncthing = {
      guiAddress = "0.0.0.0:8384";
      enable = true;
      user = "norpie";
      dataDir = "/home/norpie"; # Default folder for new synced folders
      configDir = "/home/norpie/.config/syncthing"; # Folder for Syncthing's settings and keys
      settings = {
        gui = {
          address = "0.0.0.0:8384";
          theme = "dark";
          password = "password";
        };
      };
    };
  };
}

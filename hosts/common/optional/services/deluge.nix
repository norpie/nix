{...}: {
    services.deluge = {
        enable = true;
        user = "norpie";
        group = "mediamanager";
        dataDir = "/home/norpie/.config/deluge"; # Directory for Deluge's configuration and state
        web = {
            enable = true;
            port = 9999; # Default Deluge Web UI port
        };
    };
}

{...}: {
    services.deluge = {
        enable = true;
        user = "norpie";
        group = "media";
        dataDir = "/mnt/data/data/deluge";
        web = {
            enable = true;
            port = 9999;
        };
    };
}

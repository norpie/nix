{...}: {
    services.vaultwarden = {
        enable = true;
        backupDir = "/mnt/data/data/vaultwarden";
        config = {
            ROCKET_ADDRESS = "0.0.0.0";
            ROCKET_PORT = 8222;
        };
    };
}

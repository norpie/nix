{ config, ... }: {
    services.vaultwarden = {
        enable = true;
        backupDir = "/mnt/data/data/vaultwarden";
        environmentFile = "/var/lib/vaultwarden/vaultwarden.env";
        config = {
            DOMAIN = "https://jupiter.tail9cc75d.ts.net";
            SIGNUPS_ALLOWED = false;

            ROCKET_ADDRESS = "127.0.0.1";
            ROCKET_PORT = 8222;
            ROCKET_LOG = "critical";
        };
    };

    # Request Tailscale certificate for the magic DNS hostname
    systemd.services."tailscale-cert-vaultwarden" = {
        description = "Request Tailscale certificate for Vaultwarden";
        wantedBy = [ "multi-user.target" ];
        after = [ "tailscale.service" ];
        serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            User = "root";
        };
        script = ''
            /run/current-system/sw/bin/tailscale cert jupiter.tail9cc75d.ts.net
            chmod 755 /var/lib/tailscale /var/lib/tailscale/certs
            chmod 644 /var/lib/tailscale/certs/jupiter.tail9cc75d.ts.net.*
        '';
    };

    systemd.services.nginx.after = [ "tailscale-cert-vaultwarden.service" ];

    services.nginx = {
        enable = true;
        virtualHosts."jupiter.tail9cc75d.ts.net" = {
            enableACME = false;
            forceSSL = true;
            sslCertificate = "/var/lib/tailscale/certs/jupiter.tail9cc75d.ts.net.crt";
            sslCertificateKey = "/var/lib/tailscale/certs/jupiter.tail9cc75d.ts.net.key";
            locations."/" = {
                proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
                proxyWebsockets = true;
            };
        };
    };

    networking.firewall.allowedTCPPorts = [ 443 ];
}

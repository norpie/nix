{...}: {
    services = {
        ollama = {
            enable = true;
            host = "0.0.0.0";
            home = "/home/norpie/persist/ai/ollama-state";
        };
        open-webui = {
            enable = true;
            host = "0.0.0.0";
            port = 3000;
            stateDir = "/home/norpie/persist/ai/open-webui-state";
        };
    };
}

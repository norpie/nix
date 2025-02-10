{pkgs, ...}: {
  services = {
    ollama = {
      enable = false;
      package = pkgs.ollama-rocm;
      host = "0.0.0.0";
      home = "/home/norpie/persist/ai/ollama-state";
      acceleration = false;
    };
    open-webui = {
      enable = false;
      host = "0.0.0.0";
      port = 3000;
      stateDir = "/home/norpie/persist/ai/open-webui-state";
    };
  };
}

{...}: {
  #  services.websurfx = {
  #   enable = true;
  #   openFirewall = false;
  #   settings = {
  #     port = 4567;
  #     binding_ip = "127.0.0.1";
  #     proxy = "";
  #     http_cache_expiry_time = 60;
  #     upstream_search_engines = {
  #       DuckDuckGo = true;
  #       Searx = false;
  #       Brave = true;
  #       Startpage = true;
  #       Wikipedia = true;
  #     };
  #   };
  # };
  services.searx = {
    enable = true;
    settings = {
      server = {
        bind_address = "0.0.0.0";
        port = 8080;
        secret_key = "notthedefaultsecretkey";
      };
      search = {
        formats = ["html" "json"];
      };
    };
  };
}

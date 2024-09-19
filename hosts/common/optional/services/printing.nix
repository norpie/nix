{pkgs, ...}: {
  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [
      pkgs.cnijfilter2
    ];
  };
  hardware.printers = {
    ensurePrinters = [
      {
        name = "CanonTS5000";
        location = "Home";
        deviceUri = "http://192.168.129.87:631/ipp/print";
        model = "canonts5000.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
    ensureDefaultPrinter = "CanonTS5000";
  };
  environment.systemPackages = with pkgs; [
    gtklp
  ];
}

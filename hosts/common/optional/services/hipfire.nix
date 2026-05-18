{ pkgs, ... }: {
    # services.hipfire = {
    #   enable = true;
    #   userService = true;
    #   gpuTargets = [ "gfx1100" ];
    # };
    environment.systemPackages = with pkgs; [
        hipfire
    ];
}

{ ... }: {
    services.hipfire.enable = true;
    services.hipfire.gpuTargets = [ "gfx1100" ];
}

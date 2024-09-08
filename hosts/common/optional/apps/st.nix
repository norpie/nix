{pkgs, inputs, ...}: {
  environment.systemPackages = with pkgs; [
    # (st.overrideAttrs (oldAttrs: {
    #   src = fetchgit {
    #     name = "st";
    #     url = "https://github.com/norpie/st";
    #     rev = "9b26748ae8de3713fad369b6f1918ba722b2f27c";
    #     sha256 = "sha256-/Bb8FWAxqc6FlZPBklwbfrfyqgAKtKE5I8yYUKGpUjo=";
    #   };
    # }))
    inputs.st.packages.x86_64-linux.st-norpie
    ueberzugpp
  ];
}

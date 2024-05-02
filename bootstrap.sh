# nix-shell -p git --command "nix run --experimental-features 'nix-command flakes' github:norpie/nix"
# we need to echo the command above into install.sh

# ASCII art that says to "run ./install.sh"
ascii="
                          _ __   _   _   _ __
                         | '__| | | | | | '_ \
                         | |    | |_| | | | | |
                         |_|     \__,_| |_| |_|

         __  _                 _             _   _             _
        / / (_)  _ __    ___  | |_    __ _  | | | |      ___  | |__
       / /  | | | '_ \  / __| | __|  / _\` | | | | |     / __| | '_ \
  _   / /   | | | | | | \__ \ | |_  | (_| | | | | |  _  \__ \ | | | |
 (_) /_/    |_| |_| |_| |___/  \__|  \__,_| |_| |_| (_) |___/ |_| |_|

run ./install.sh
"
echo "nix-shell -p git --command \"nix run --experimental-features 'nix-command flakes' github:norpie/nix\"" >install.sh &&
    chmod +x install.sh &&
    echo $ascii

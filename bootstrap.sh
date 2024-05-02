# nix-shell -p git --command "nix run --experimental-features 'nix-command flakes' github:norpie/nix"
# we need to echo the command above into install.sh

# ASCII art that says to "run ./install.sh"
ascii="
                          _ __   _   _   _ __                           \n
                         | '__| | | | | | '_ \                          \n
                         | |    | |_| | | | | |                         \n
                         |_|     \__,_| |_| |_|                         \n

         __  _                 _             _   _             _        \n
        / / (_)  _ __    ___  | |_    __ _  | | | |      ___  | |__     \n
       / /  | | | '_ \  / __| | __|  / _\` | | | | |     / __| | '_ \   \n
  _   / /   | | | | | | \__ \ | |_  | (_| | | | | |  _  \__ \ | | | |   \n
 (_) /_/    |_| |_| |_| |___/  \__|  \__,_| |_| |_| (_) |___/ |_| |_|   \n

run ./install.sh
"
echo "nix-shell -p git --command \"nix run --experimental-features 'nix-command flakes' github:norpie/nix\"" >install.sh &&
    chmod +x install.sh &&
    echo $ascii

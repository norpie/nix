# Autoinstall NixOS based on this flake

# terminal output coloring
function normal() {
    echo -e "\x1B[32m[+] $1 \x1B[0m"
    if [ -n "${2}" ]; then
        echo -e "\x1B[32m[+] $($2) \x1B[0m"
    fi
}

function warning() {
    echo -e "\x1B[33m[*] $1 \x1B[0m"
    if [ -n "${2}" ]; then
        echo -e "\x1B[33m[*] $($2) \x1B[0m"
    fi
}

function error() {
    echo -e "\x1B[31m[!] $1 \x1B[0m"
    if [ -n "${2}" ]; then
        echo -e "\x1B[31m[!] $($2) \x1B[0m"
    fi
}

# confirmation helper
function yes_or_no {
    while true; do
        read -rp "$* [y/n]: " yn
        case $yn in
        [Yy]*) return 0 ;;
        [Nn]*) return 1 ;;
        esac
    done
}

function prompt() {
    read -rp "$1" $2
}

# used for password prompts
function hidden_prompt() {
    read -rsp "$1" $2
    echo ""
}

# check if the script is running as root
if [ "$(id -u)" -ne 0 ]; then
    error "This script must be run as root"
    exit 1
fi

# check if the script is running on NixOS
if [ ! -f /etc/NIXOS ]; then
    error "This script must be run on NixOS"
    exit 1
fi

# check if the script is running on a UEFI system
if [ ! -d /sys/firmware/efi ]; then
    error "This script must be run on a UEFI system"
    exit 1
fi

git clone https://github.com/norpie/nix.git

hostnames=$(nix eval --raw 'with import ./. {}; lib.attrNames (inputs.nixosConfigurations)')

# prompt for needed information
prompt "Enter the hostname: " hostname
lsblk
prompt "Enter the disk to install NixOS on (e.g. /dev/sda): " disk
if [ ! -b "$disk" ]; then
    error "$disk is not a block device"
    exit 1
fi
if ! yes_or_no "Are you sure you want to install NixOS on $disk?"; then
    exit 1
fi
hidden_prompt "Enter the password for the user (norpie) and root: " password

echo "hostname: $hostname"

# partition

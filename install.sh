# Autoinstall NixOS based on this flake
#.
# ├── flake.lock
# ├── flake.nix
# ├── hosts
# │   ├── common
# │   │   ├── core
# │   │   │   ├── boot.nix
# │   │   │   ├── default.nix
# │   │   │   ├── locale.nix
# │   │   │   ├── network.nix
# │   │   │   ├── nix.nix
# │   │   │   ├── packages.nix
# │   │   │   └── shell.nix
# │   │   ├── optional
# │   │   │   ├── apps
# │   │   │   │   ├── dmenu.nix
# │   │   │   │   ├── spotify.nix
# │   │   │   │   └── st.nix
# │   │   │   ├── desktop-apps.nix
# │   │   │   ├── desktop.nix
# │   │   │   ├── dwm-env.nix
# │   │   │   ├── fonts.nix
# │   │   │   ├── nvidia.nix
# │   │   │   ├── services
# │   │   │   │   ├── audio.nix
# │   │   │   │   ├── bluetooth.nix
# │   │   │   │   ├── plex.nix
# │   │   │   │   ├── printing.nix
# │   │   │   │   ├── ssh.nix
# │   │   │   │   └── sync.nix
# │   │   │   └── touchpad.nix
# │   │   └── users
# │   │       └── norpie.nix
# │   ├── desktop
# │   │   └── configuration.nix
# │   ├── laptop
# │   │   └── configuration.nix
# │   └── vm
# │       ├── configuration.nix
# │       └── hardware-configuration.nix
# ├── install.sh
# └── lib
#     └── default.nix

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

function accent() {
    echo -e "\x1B[35m$1 \x1B[0m"
    if [ -n "${2}" ]; then
        echo -e "\x1B[35m$($2) \x1B[0m"
    fi
}

# confirmation helper
function yes_or_no {
    while true; do
        read -rp "$(echo -e "\x1B[36m$*\x1B[0m") [y/n]: " yn
        case $yn in
        [Yy]*) return 0 ;;
        [Nn]*) return 1 ;;
        esac
    done
}

function prompt() {
    read -rp "$(echo -e "\x1B[36m$1: \x1B[0m")" $2
}

function prompt_default() {
    read -rp "$(echo -e "\x1B[36m$1 [$3]: \x1B[0m")" $2
    eval "$2=\${$2:-$3}"
}

# used for password prompts
function hidden_prompt() {
    read -rsp "$(echo -e "\x1B[36m$1: \x1B[0m")" $2
    echo ""
}

function cleanup() {
    if [ -d /mnt ]; then
        umount -R /mnt
    fi
    swapoff "${disk}2"
    # nix-store --gc
}
# trap cleanup EXIT

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

# clone repo and cd into it
if [ ! -d $HOME/nix-config ]; then
    git clone https://github.com/norpie/nix $HOME/nix-config
fi
cd $HOME/nix-config
git reset --hard
git pull

prompt_default "Enter the hostname" hostname $(hostname)
result=$(nix flake show --experimental-features 'nix-command flakes' . --json | jq --arg host "$hostname" '.nixosConfigurations | has($host)')
if [ "$result" = "false" ]; then
    error "No NixOS configuration found for $hostname"
    exit 1
fi

lsblk
prompt "Enter the disk to install NixOS on (e.g. /dev/sda)" disk
if [ ! -b "$disk" ]; then
    error "$disk is not a block device"
    exit 1
fi

accent "# Config:"
accent "Hostname: $hostname"
accent "Disk: $disk"
yes_or_no "Is this correct?"
if [ $? -ne 0 ]; then
    error "Aborted"
    exit 1
fi

# Partition the drive
# EFI  | /boot | 512M
# swap | swap  | 8G
# ext4 | /     | 100% remaining
normal "Partitioning the disk: $disk"
parted --script "$disk" mklabel gpt \
    mkpart primary fat32 1MiB 513MiB \
    set 1 esp on \
    mkpart primary linux-swap 513MiB 8.5GiB \
    mkpart primary ext4 8.5GiB 100%

if [ $? -ne 0 ]; then
    error "Failed to partition the disk"
    exit 1
fi

# Format the partitions (If drive is nvme use p1p2p3 instead of p)
if [ -b "${disk}p1" ]; then
    disk="${disk}p"
fi
normal "Formatting the partitions"
mkfs.fat -F32 "${disk}1"
if [ $? -ne 0 ]; then
    error "Failed to format the EFI partition"
    exit 1
fi
mkswap "${disk}2"
if [ $? -ne 0 ]; then
    error "Failed to format the swap partition"
    exit 1
fi
swapon "${disk}2"
if [ $? -ne 0 ]; then
    error "Failed to enable the swap partition"
    exit 1
fi
mkfs.ext4 -F "${disk}3"
if [ $? -ne 0 ]; then
    error "Failed to format the root partition"
    exit 1
fi

# Mount the partitions
normal "Mounting the partitions"
mount "${disk}3" /mnt
if [ $? -ne 0 ]; then
    error "Failed to mount the root partition"
    exit 1
fi
mkdir /mnt/boot
if [ $? -ne 0 ]; then
    error "Failed to create the boot directory"
    exit 1
fi
mount "${disk}1" /mnt/boot
if [ $? -ne 0 ]; then
    error "Failed to mount the EFI partition"
    exit 1
fi

# Hardware configuration
normal "Generating hardware configuration"
pwd
nixos-generate-config --root /mnt --show-hardware-config > "./hosts/$hostname/hardware-configuration.nix"
if [ $? -ne 0 ]; then
    error "Failed to generate the hardware configuration"
    exit 1
fi

# Install NixOS
normal "Installing NixOS"
nixos-install --impure --flake ".#$hostname" --root /mnt
if [ $? -ne 0 ]; then
    error "Failed to install NixOS"
    exit 1
fi

normal "Setting up home directory"
# Home directory
git clone https://github.com/norpie/dots /mnt/home/norpie --recurse-submodules
# merge overriding files
# rsync -a /mnt/home/dots/ /mnt/home/norpie/
# merge, overriding, dots into home directory
# mv /mnt/home/norpie/.git /mnt/home/norpie/.dots
# chown -R 1000 /mnt/home/norpie

# cp this flake into .config/nix-config
# mkdir -p /mnt/home/norpie/.config/nix-config
# cp -r . /mnt/home/norpie/.config/nix-config
# chown -R 1000 /mnt/home/norpie/.config/nix-config

# Reboot
# normal "Installation complete"
# warning "Rebooting in 5 seconds"
# sleep 5
# reboot

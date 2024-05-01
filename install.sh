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
        normal "Unmounting /mnt"
        umount -R /mnt
    fi
    normal "Disabling swap"
    swapoff "$(get_disk_partition_by_number $disk1 2)"
    normal "Cleaning up the Nix store"
    # don't spam the output with this v
    nix-store --gc >/dev/null 2>&1
}
trap cleanup EXIT

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

hostname=""
multi_disk=false
disk1=""
disk2=""
need_format=false
# map of partitions to mount points e.g. /dev/sda1 -> /mnt/boot
other_mounts=""

prompt_default "Enter the hostname" hostname $(hostname)
result=$(nix flake show --experimental-features 'nix-command flakes' . --json | jq --arg host "$hostname" '.nixosConfigurations | has($host)')
if [ "$result" = "false" ]; then
    error "No NixOS configuration found for $hostname"
    exit 1
fi

yes_or_no "Is this a multi-disk system? (Drive 1 system, Drive 2 home)"
if [ $? -eq 0 ]; then
    multi_disk=true
else
    multi_disk=false
fi

lsblk
if [ "$multi_disk" = true ]; then
    prompt "Enter the disk to install NixOS on (e.g. /dev/sda)" disk1
    if [ ! -b "$disk1" ]; then
        error "$disk1 is not a block device"
        exit 1
    fi
    prompt "Enter the disk whose first partition to install as NixOS home on (e.g. /dev/sdb)" disk2
    if [ ! -b "$disk2" ]; then
        error "$disk2 is not a block device"
        exit 1
    fi
    yes_or_no "Does $disk2 need to be formatted?"
    if [ $? -eq 0 ]; then
        need_format=true
    fi
else
    prompt "Enter the disk to install NixOS on (e.g. /dev/sda)" disk1
    if [ ! -b "$disk1" ]; then
        error "$disk1 is not a block device"
        exit 1
    fi
fi

# Loop while the user is prompted for the partitions and mount points
while true; do
    yes_or_no "Add another partition?"
    if [ $? -ne 0 ]; then
        break
    fi
    lsblk
    echo "Other mounts:"
    prompt "Enter the partition to mount (e.g. /dev/sdb1)" partition
    if [ ! -b "$partition" ]; then
        error "$partition is not a block device"
        exit 1
    fi
    prompt "Enter the mount point for $partition (e.g. /mnt/data)" mount_point
    other_mounts="$other_mounts $partition:$mount_point"
done

accent "# Config:"
accent "Hostname: $hostname"
accent "Multi-disk: $multi_disk"
accent "Disk 1: $disk1"
if [ "$multi_disk" = true ]; then
    accent "Disk 2: $disk2"
fi
accent "Other mounts: $other_mounts"
yes_or_no "Is this correct?"
if [ $? -ne 0 ]; then
    error "Aborted"
    exit 1
fi

# e.g. get_disk_partition_by_number /dev/sda 1 -> /dev/sda1, get_disk_partition_by_number /dev/nvme0n1 1 -> /dev/nvme0n1p1
function get_disk_partition_by_number() {
    if [[ "$1" == *nvme* ]]; then
        echo "${1}p$2"
    else
        echo "${1}$2"
    fi
}

# Partition the drive(s)
# EFI  | /boot | 512M
# swap | swap  | 8G
# ext4 | /     | 100% remaining
normal "Partitioning disk: $disk1"
parted --script "$disk1" mklabel gpt \
    mkpart primary fat32 1MiB 513MiB \
    set 1 esp on \
    mkpart primary linux-swap 513MiB 8.5GiB \
    mkpart primary ext4 8.5GiB 100%
if [ $? -ne 0 ]; then
    error "Failed to partition the disk"
    exit 1
fi
normal "Formatting the partitions"
mkfs.fat -F32 "$(get_disk_partition_by_number $disk1 1)"
if [ $? -ne 0 ]; then
    error "Failed to format the EFI partition"
    exit 1
fi
mkswap "$(get_disk_partition_by_number $disk1 2)"
if [ $? -ne 0 ]; then
    error "Failed to format the swap partition"
    exit 1
fi
swapon "$(get_disk_partition_by_number $disk1 2)"
if [ $? -ne 0 ]; then
    error "Failed to enable the swap partition"
    exit 1
fi
mkfs.ext4 -F "$(get_disk_partition_by_number $disk1 3)"
if [ $? -ne 0 ]; then
    error "Failed to format the root partition"
    exit 1
fi

# multi_disk true and need_format true means we need to format the second disk
if [ "$multi_disk" = true ] && [ "$need_format" = true ]; then
    normal "Formatting the second disk"
    parted --script "$disk2" mklabel gpt \
        mkpart primary ext4 1MiB 100%
fi

# Mount the partitions
normal "Mounting the partitions"
normal "Mounting the root partition"
mount "$(get_disk_partition_by_number $disk1 3)" /mnt
if [ $? -ne 0 ]; then
    error "Failed to mount the root partition"
    exit 1
fi
normal "Mounting the EFI partition"
mkdir /mnt/boot
if [ $? -ne 0 ]; then
    error "Failed to create the boot directory"
    exit 1
fi
mount "$(get_disk_partition_by_number $disk1 1)" /mnt/boot
if [ $? -ne 0 ]; then
    error "Failed to mount the EFI partition"
    exit 1
fi

if [ "$multi_disk" = true ]; then
    normal "Mounting the home partition"
    mkdir -p /mnt/home
    mount "$(get_disk_partition_by_number $disk2 1)" /mnt/home
    if [ $? -ne 0 ]; then
        error "Failed to mount the home partition"
        exit 1
    fi
fi

for mount in $other_mounts; do
    partition=$(echo $mount | cut -d: -f1)
    mount_point=$(echo $mount | cut -d: -f2)
    normal "Mounting $partition to $mount_point"
    mkdir -p /mnt$mount_point
    if [ $? -ne 0 ]; then
        error "Failed to create the $mount_point directory"
        exit 1
    fi
    mount $partition /mnt$mount_point
    if [ $? -ne 0 ]; then
        error "Failed to mount $partition to $mount_point"
        exit 1
    fi
done

# Hardware configuration
normal "Generating hardware configuration"
nixos-generate-config --root /mnt --show-hardware-config >"./hosts/$hostname/hardware-configuration.nix"
if [ $? -ne 0 ]; then
    error "Failed to generate the hardware configuration"
    exit 1
fi

# Install NixOS
normal "Installing NixOS"
nixos-install --impure --flake ".#$hostname" --root /mnt --no-root-passwd
if [ $? -ne 0 ]; then
    error "Failed to install NixOS"
    exit 1
fi

# Post-installation, if we had to format the home partition we need to clone the dots repo
if [ "$need_format" = true ]; then
    normal "Setting up home"
    git clone https://github.com/norpie/dots /mnt/home/norpie
    mv /mnt/home/norpie/.git /mnt/home/norpie/.dots
    chown -R 1000 /mnt/home/norpie
else
    normal "Home was not formatted, skipping setup"
fi

# cp this flake into /etc/nixos so we can use it later
normal "Copying the flake to /etc/nixos"
cp -r . /etc/nixos

# Reboot
normal "Installation complete"
warning "Rebooting in 5 seconds"
sleep 5
reboot

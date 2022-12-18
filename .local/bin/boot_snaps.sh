#!/usr/bin/env bash

# Lets start with creating a new btrfs snapshot
btrbk -c /etc/btrbk/btrbk.conf run

# Useful variables
VERSION=$(find /boot -name 'vmlinuz*' | cut -d'-' -f2)
boot="/boot/efi"
binaries="$boot/efi/Linux"
snapshot_dir="/.snapshots"
number_of_snapshots=5
source /etc/default/efibootmgr-kernel-hook

[ -d "$binaries" ] || mkdir -p "$binaries"

# To make life easy, just remove all snapshot efi entries first
efi=$(efibootmgr | grep "ROOT" | cut -c 5-8)
for e in $efi; do
    efibootmgr -q -b "$e" -B
done

prune() {
    diff=$(("$1" - number_of_snapshots))
    to_delete=$(find "$2" -name 'ROOT*' -printf "%T@ %p\n" | sort -n | cut -d' ' -f2- | head -$diff)

    for d in $to_delete; do
        rm -f "$d" && echo "$(basename "$d")" deleted.
    done
}

snapshots=$(find "$snapshot_dir" -maxdepth 1 -exec basename {} ';' | tail -$number_of_snapshots)
for s in $snapshots; do
    new_options=${OPTIONS//rw rootflags=subvol=@/ro rootflags=subvol=@snapshots/$s}
    # Generate and sign new bundle
    sbctl bundle -c <(echo "$new_options") -p "$boot" -e /usr/lib/gummiboot/linuxx64.efi.stub -f /boot/initramfs-"$VERSION".img -k /boot/vmlinuz-"$VERSION" -o /etc/os-release "$binaries/$s".efi
    sbctl sign "$binaries/$s".efi

    efibootmgr -q --create --disk /dev/nvme0n1 --part 1 --label "$s" --loader "EFI\Linux\\$s.efi"
done

# Cleanup any extra binaries
num_binaries=$(find "$binaries" -name 'ROOT*' | wc -l)
[ "$num_binaries" -ge "$number_of_snapshots" ] && prune "$num_binaries" "$binaries"

# "Intelligently" figure out order
# attempts to start sorting based on name of snapshot instead of efibootmgr ID
snaps="$(efibootmgr | grep 'ROOT' | sed 's/Boot//g' | tr -d '*' | sort -k2.1 -r | cut -d' ' -f1)"
main=$(efibootmgr | grep 'Void' | sed 's/Boot//g' | tr -d '*' | cut -d' ' -f1)

for s in $snaps; do
    snap_order+="$s,"
done
# Remove last extra comma
snap_order=${snap_order::-1}
efibootmgr -q -o "$main,$snap_order"

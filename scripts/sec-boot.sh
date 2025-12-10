WIN_BOOT=$(lsblk | grep 99M | grep -oP '(?<=─)[a-zA-Z0-9]+')
mkdir -p /mnt/windows-efi/
mount /dev/$WIN_BOOT /mnt/windows-efi/
cp -r EFI/Microsoft /boot/EFI/

sbctl create-keys
sbctl enroll-keys --microsoft
#cachy os specific
sbctl-batch-sign
sbctl sign -s -o \
  /usr/lib/systemd/boot/efi/systemd-bootx64.efi.signed \
  /usr/lib/systemd/boot/efi/systemd-bootx64.efi

paru -R mkinitcpio
cat << EOF | tee /etc/dracut.conf/myflags.conf
add_dracutmodules+=" plymouth "
EOF

cat << EOF | tee /etc/pacman.d/hooks/80-secureboot.hook
[Trigger]
Operation = Install
Operation = Upgrade
Type = Path
Target = usr/lib/systemd/boot/efi/systemd-boot*.efi

[Action]
Description = Signing systemd-boot EFI binary for Secure Boot
When = PostTransaction
Exec = /bin/sh -c 'while read -r f; do /usr/lib/systemd/systemd-sbsign sign --private-key /path/to/keyfile.key --certificate /path/to/certificate.crt --output "${f}.signed" "$f"; done;'
Depends = sh
NeedsTargets

EOF


dracut -f --regenerate-all
racut -f --add-confdir rescue /boot/initramfs-linux-fallback.img

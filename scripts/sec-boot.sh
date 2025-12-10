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

dracut -f --regenerate-all
racut -f --add-confdir rescue /boot/initramfs-linux-fallback.img

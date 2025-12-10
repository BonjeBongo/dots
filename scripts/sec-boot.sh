WIN_BOOT=$(lsblk | grep 99M | grep -oP '(?<=─)[a-zA-Z0-9]+')
mkdir -p /mnt/windows-efi/
mount /dev/$WIN_BOOT /mnt/windows-efi/
cp -r EFI/Microsoft /boot/EFI/

sbctl create-keys
sbctl enroll-keys --microsoft
#cachy os specific
sbctl-batch-sign
#
sbctl sign -s -o \
  /usr/lib/systemd/boot/efi/systemd-bootx64.efi.signed \
  /usr/lib/systemd/boot/efi/systemd-bootx64.efi

cat << EOF | tee /etc/dracut.conf.d/myflags.conf
add_dracutmodules+=" plymouth "
EOF

reinstall-kernels

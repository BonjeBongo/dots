cp /usr/share/edk2-shell/x64/Shell.efi /boot/shellx64.efi
cat << EOF | tee -a /boot/loader/loader.conf
console-mode max
EOF

# new systems:
# grab windows PARTUUID:
# sudo blkid /dev/nvme1n1p3
# boot to edk2-shell
# find uuid
# copy FS ALIAS
# mkdir -p /boot/loader/entries
# cat << EOF | tee /boot/loader/entries/windows.conf
# title   Windows
# efi     /shellx64.efi
# options -nointerrupt -nomap -noversion <REPLACEME>:EFI\Microsoft\Boot\Bootmgfw.efi
# EOF

sbctl create-keys
sbctl enroll-keys --microsoft

cat << EOF | tee /etc/dracut.conf.d/myflags.conf
add_dracutmodules+=" plymouth "
force_drivers+=" amdgpu "
EOF
sbctl verify | sed -E 's|^.* (/.+) is not signed$|sbctl sign -s "\1"|e'
dracut-ukify -a

#cachy os specific
sbctl-batch-sign
#
sbctl sign -s -o \
  /usr/lib/systemd/boot/efi/systemd-bootx64.efi.signed \
  /usr/lib/systemd/boot/efi/systemd-bootx64.efi

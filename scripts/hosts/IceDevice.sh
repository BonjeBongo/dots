mkdir -p /boot/loader/entries
cat << EOF | tee /boot/loader/entries/windows.conf
title   Windows
efi     /shellx64.efi
options -nointerrupt -nomap -noversion HD1d:EFI\Microsoft\Boot\Bootmgfw.efi
EOF



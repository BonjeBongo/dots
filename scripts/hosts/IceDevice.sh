mkdir -p /boot/loader/entries
cat << EOF | tee /boot/loader/entries/windows.conf
title   Windows
efi     /shellx64.efi
options -nointerrupt -nomap -noversion HD1d:EFI\Microsoft\Boot\Bootmgfw.efi
EOF

ACTUAL_USER="${SUDO_USER:-$USER}"
ACTUAL_HOME=$(sudo -i -u $ACTUAL_USER echo "\$HOME")
DCLI_DOTS='.config/arch-config/dots'

ln -s "$ACTUAL_HOME/$DCLI_DOTS/hosts/IceDevice/wireplumber" "$ACTUAL_HOME/.config/wireplumber"
systemctl --user restart wireplumber.service

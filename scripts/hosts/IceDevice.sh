mkdir -p /boot/loader/entries
cat << EOF | tee /boot/loader/entries/windows.conf
title   Windows
efi     /shellx64.efi
options -nointerrupt -nomap -noversion HD1d:EFI\Microsoft\Boot\Bootmgfw.efi
EOF

# sbctl hook crashes with versioned ukify kernel images so this hook should
# happen before the one shipped with aur and clean up old versions
cat << EOF | tee /usr/lib/kernel/install.d/91-pre-sbctl.install
# remove invalid signs
sbctl verify | sed -E 's|^.* (/.+): open |sbctl remove-file "\1"|e'
# sign again
sbctl verify | sed -E 's|^.* (/.+) is not signed$|sbctl sign -s "\1"|e'
EOF

cat << EOF | tee -a /etc/sddm.conf
[General]
DisplayServer=x11

[X11]
EnableHiDPI=true
DisplayCommand=/usr/share/sddm/scripts/Xsetup
DisplayStopCommand=/usr/share/sddm/scripts/Xstop
EOF

# i want only one display to show login screen, fight me
cat << EOF | tee -a /usr/share/sddm/scripts/Xsetup
xrandr --output HDMI-A-1 --off
xrandr --output HDMI-A-0 --off
EOF
# idk if this works uwsm is kinda ass
# but it shipped with cachy so here we are
cat << EOF | tee -a /usr/share/sddm/scripts/Xstop
systemctl restart sddm.service
EOF


ACTUAL_USER="${SUDO_USER:-$USER}"
ACTUAL_HOME=$(sudo -i -u $ACTUAL_USER echo "\$HOME")
DCLI_DOTS='.config/arch-config/dots'

ln -s "$ACTUAL_HOME/$DCLI_DOTS/hosts/IceDevice/wireplumber" \
  "$ACTUAL_HOME/.config/wireplumber"
systemctl --user restart wireplumber.service

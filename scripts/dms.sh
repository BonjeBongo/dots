ACTUAL_USER="${SUDO_USER:-$USER}"
ACTUAL_HOME=$(sudo -i -u $ACTUAL_USER echo "\$HOME")
DCLI_DOTS='.config/arch-config/dots'
DMS_DOTS='.config/DankMaterialShell'
HYPR_DOTS='.config/hypr'


rm -rf "$ACTUAL_HOME/$HYPR_DOTS"
ln -s "$ACTUAL_HOME/$DCLI_DOTS/hypr" "$ACTUAL_HOME/$HYPR_DOTS"
rm -rf "$ACTUAL_HOME/$DMS_DOTS"
ln -s "$ACTUAL_HOME/$DCLI_DOTS/DankMaterialShell" "$ACTUAL_HOME/$DMS_DOTS"

sudo systemctl enable --now dms

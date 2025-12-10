ACTUAL_USER="${SUDO_USER:-$USER}"
ACTUAL_HOME=$(sudo -i -u $ACTUAL_USER echo "\$HOME")

curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh | LV_BRANCH='release-1.4/neovim-0.9' sudo -i -u $ACTUAL_USER bash

chmod +x "$ACTUAL_HOME/.local/bin/lvim"
chown $ACTUAL_USER:$ACTUAL_USER "$ACTUAL_HOME/.local/bin/lvim"

sudo -i -u $ACTUAL_USER mkdir -p $ACTUAL_HOME/.config/fish/conf.d/
cat << EOF | sudo -i -u $ACTUAL_USER tee $ACTUAL_HOME/.config/fish/conf.d/lunarvim.fish
alias lv $ACTUAL_HOME/.local/bin/lvim
alias lvim $ACTUAL_HOME/.local/bin/lvim
EOF

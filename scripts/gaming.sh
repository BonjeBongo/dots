curl -fsSL https://www.maccel.org/install.sh | sudo sh
usermod -aG maccel $SUDO_USER

sudo -i -u $SUDO_USER sh -c "$(curl -fsSL https://raw.githubusercontent.com/Blooym/xlm/main/setup/install-native.sh)"
sudo systemctl enable --now lactd.service
sudo systemctl enable --now coolercontrold.service

sudo git clone -b master --depth 1 \
  https://github.com/keyitdev/sddm-astronaut-theme.git \
  /usr/share/sddm/themes/sddm-astronaut-theme
sudo cp -r /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/

cat << EOF | tee /etc/sddm.conf
[Theme]
Current=sddm-astronaut-theme
EOF

sudo mkdir -p /etc/sddm.conf.d
cat << EOF | tee/etc/sddm.conf.d/virtualkbd.conf
[General]
InputMethod=qtvirtualkeyboard
EOF

ACTUAL_USER="${SUDO_USER:-$USER}"
ACTUAL_HOME=$(sudo -i -u $ACTUAL_USER echo "\$HOME")

sudo -i -u $ACTUAL_USER mkdir -p $ACTUAL_HOME/.config/fish/conf.d/
cat << 'EOF' | sudo -i -u $ACTUAL_USER tee $ACTUAL_HOME/.config/fish/conf.d/yt-dlp.fish
function ytdl-mp3 -a fpath link
  yt-dlp -x \
  --audio-format mp3 \
  -o "$fpath/%(title)s.%(ext)s"\
  --embed-thumbnail \
  --convert-thumbnail png \
  --ppa "ThumbnailsConvertor:-vf crop=\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\"" \
  $link
end

function ytdl-mp3-playlist -a fpath link
  yt-dlp -x \
  --audio-format mp3 \
  -o "$fpath/%(title)s.%(ext)s"\
  --yes-playlist \
  --sleep-interval 10 \
  --embed-thumbnail \
  --convert-thumbnail png \
  --ppa "ThumbnailsConvertor:-vf crop=\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\"" \
  $link
end
EOF

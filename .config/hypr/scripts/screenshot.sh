#!/bin/sh

FILENAME="$(xdg-user-dir PICTURES)/Screenshots/$(date +'%s_screenshot.png')"

copy_area() {
  grim -g "$(slurp)" "$FILENAME"
  wl-copy < "$FILENAME"
  notify_user
}

copy_screen() {
  grim -g "$(slurp -o)" "$FILENAME"
  wl-copy < "$FILENAME"
  notify_user
}

notify_user() {
  notify-send "Screenshot taken" "Saved to drive and copied to clipboard" -i "$FILENAME"
}

case $1 in
  "area")   copy_area   ;;
  "screen") copy_screen ;;
esac

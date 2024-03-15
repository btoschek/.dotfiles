#!/bin/sh

FILENAME="$(xdg-user-dir PICTURES)/Screenshots/$(date +'%s_screenshot.png')"

copy_area() {
  grim -g "$(slurp)" "$FILENAME"
  if [ -f "$FILENAME" ]; then
    wl-copy < "$FILENAME"
    notify_user
  fi
}

copy_screen() {
  grim -g "$(slurp -o)" "$FILENAME"
  if [ -f "$FILENAME" ]; then
    wl-copy < "$FILENAME"
    notify_user
  fi
}

notify_user() {
  notify-send "Screenshot taken" "Saved to drive and copied to clipboard" -i "$FILENAME"
}

case $1 in
  "area")   copy_area   ;;
  "screen") copy_screen ;;
esac

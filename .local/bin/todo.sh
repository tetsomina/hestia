#!/bin/sh

WINDOW=0
FLAGS=""
# SELECTION="$(todo --color never |
#   awk -F! '{print NF,$0}' |
#   sort -nr | cut -d' ' -f4- |
#   rofi -dmenu -i -p "Todos")"
SELECTION=$(todo --porcelain |
  jq -r 'sort_by( -.priority, -(.due//0) )[] | [ .id, .summary, (.due//0|strflocaltime("%m/%d/%y at %I:%M %p")), (.categories|join(", ")) ] | @sh' |
  xargs -L 1 printf '%s: %s (%s) [%s]\n' |
  sed -e 's/ at 12:00 AM//' -e 's/12\/31\/69 at 07:00 PM/no due date/' -e 's/\[\]//'|
  rofi -dmenu -i -p "Todos")

[ -z "$SELECTION" ] && exit

ID=$(printf '%s' "$SELECTION" | grep -o '^[0-9]\+')

# The cleverest, POSIX compliant way to check for integers
if [ "$ID" -eq "$ID" ]; then
  ACTION=$(printf "cancel\ndelete\ndone\nedit\nflush" | rofi -dmenu -i -p "Action")
  [ -z "$ACTION" ] && exit
  case "$ACTION" in
  delete)
    FLAGS="--yes"
    ;;
  edit)
    WINDOW=1
    FLAGS="-i"
    ;;
  flush)
    FLAGS="--yes"
    ;;
  esac
else
  ACTION="new"
  ID="$SELECTION"
  WINDOW=1
  FLAGS="-i"
fi

if [ $WINDOW -eq 1 ]; then
  "$TERMINAL" -name todo -e todo $ACTION $FLAGS "$ID"
else
  todo $ACTION $FLAGS "$ID"
fi

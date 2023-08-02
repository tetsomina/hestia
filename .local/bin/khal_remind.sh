#!/bin/sh

# notify a khal user via rofi about upcoming events
#
# dependencies: ·khal
#               ·rofi >= 1.7.0 (-timeout-delay 60 -timeout-action "kb-cancel")
#               ·column (eye candy only. can be removed without problems)
#
# usage: put it into a cronjob and let it run every 15 min or so
# -only events with reminders will trigger an alarm (shown in khal as: (A))
# -snoozed events will show up again on the next run
# -dismissed events will not trigger an alarm again
# -no alarm will be triggered if the script did never run
#  for the duration of an event or in TIMESPAN beforehand
#
# rofi: -Shift+Return toggles item selection
#       -if any item is selected, "cursor" position has no effect
#       -timeout after 60 seconds; this snoozes all events
####################

# adjust cache file location to your liking
cache_file="${XDG_CACHE_HOME:-$HOME/.cache}/khal-events"
# events starting in the next TIMESPAN will trigger an alarm
timespan='60min'
####################

# this is needed for cronjobs and Xorg
export DISPLAY=":0"
snooze_string='Snooze all.'
dismiss_string='Dismiss all.'
# only show events with (A) symbol (=has alarm set)
# remove arrows for all-day events to only have one notification
# remove (A) symbol because it is obvious
events="$(khal list --format \
  '{calendar}: {cancelled}{start-style}{to-style}{end-style} {title}{description-separator}{description}{location}{repeat-symbol}{alarm-symbol}' \
  now "${timespan}" |
  sed -ne '/(A)/ p' |
  sed -e 's/(A)//g' -e 's/\(|->\|<->\|<-|\)[^[:blank:]]*/all-day/g' |
  column -tl 3)"

# get events that are new compared to cache file
new_events="$(
  diff -NwU 0 "${cache_file}" - <<EOF | sed -ne '/^\+[^+]/ p' |
${events}
EOF
    sed -ne 's/^\+\([[:print:]].*\)$/\1/p'
)"

[ -z "${new_events}" ] && exit 0

input="$(printf '%s\n%s\n%s' "${snooze_string}" \
  "${dismiss_string}" "${new_events}" |
  rofi -timeout-delay 60 -timeout-action "kb-cancel" \
    -dmenu -i -u 2: -no-custom -multi-select \
    -theme-str 'entry {placeholder: "Snooze or dismiss...";}' \
    -p 'Khal Alarm!')"

case "${input}" in
"${snooze_string}") ;;
"${dismiss_string}")
  printf '%s' "${events}" >"${cache_file}"
  ;;
*)
  printf '%s' "${events}" | grep -Fve "${input}" >"${cache_file}"
  ;;
esac

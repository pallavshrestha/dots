declare -a STATES=(1 0)
DEVICE=$(xinput list --name-only | grep Touchpad)
STATE=$(xinput list-props "$DEVICE" | grep 'Device Enabled' | sed 's/^.*:[ \t]*//')
if [[ "$STATE" == 1 ]]; then
    notify-send "Touchpad off"
else
    notify-send "Touchpad on"
fi
xinput set-prop "$DEVICE" 'Device Enabled' ${STATES[$STATE]}

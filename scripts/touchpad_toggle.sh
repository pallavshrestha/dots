declare -a STATES=(1 0)

#DEVICE=$(xinput list --name-only | grep Touchpad)
# 09.04.2024 when disabled, device name starts with ~

DEVICE=$(xinput list | grep Touchpad | sed 's/.*id=\([0-9]*\).*/\1/')
STATE=$(xinput list-props "$DEVICE" | grep 'Device Enabled' | sed 's/^.*:[ \t]*//')
if [[ "$STATE" == 1 ]]; then
    notify-send "Touchpad off"
else
    notify-send "Touchpad on"
fi
xinput set-prop "$DEVICE" 'Device Enabled' ${STATES[$STATE]}

declare -a STATES=(1 0)
DEVICE=$(xinput list --name-only | grep TouchaPad)
STATE=$(xinput list-props "$DEVICE" | grep 'Device Enabled' | sed 's/^.*:[ \t]*//')
xinput set-prop "$DEVICE" 'Device Enabled' ${STATES[$STATE]}

killall swaybg

count=1
while read -r line; do
  output_name=$(echo "$line" | awk -F '[()]' '{print $2}')
  eval "var$count=\"$output_name\""
  ((count++))
done < <(niri msg outputs | grep "Output")

for ((i=1; i<count; i++)); do
    varname="var$i"
    echo ${!varname}
    swaybg -o "${!varname}" -i "$(find ~/.config/wallpaper/ -type f | shuf -n 1)" &
done

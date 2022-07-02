#/bin/bash
echo -n "Input device ip: "
read device_ip 
printf "Connecting to $device_ip ... \n"
printf "$(echo -n $(adb connect $device_ip))\n"

search_dir=data
for path in "$search_dir"/*
do
  new_path=${path//[ ]/-}
  mv "$path" "$new_path"
  printf "Copying $new_path... \n"
  printf "$(echo -n $(adb push $new_path ./storage/emulated/0/))\n"
done

printf "$(echo -n $(adb kill-server))\n" 
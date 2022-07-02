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
  file_extension=${new_path##*.}

  if [[ $file_extension == 'apk' ]]; then
    printf "installing $new_path"
    printf "$(echo -n $(adb install $new_path))\n"
  else
    printf "Copying $new_path... \n"
    printf "$(echo -n $(adb push $new_path ./storage/emulated/0/))\n"
  fi
done

printf "$(echo -n $(adb kill-server))\n" 
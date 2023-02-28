#!/bin/bash

# Download gambar
function download() {
  hour=$(date +"%H")
  num_download=$hour

  if [ $hour -eq 0 ]; then
    num_download=1
  fi

  folder_name="kumpulan_$((num_download/10+1))"
  file_name="perjalanan_$num_download"
  url="https://picsum.photos/1920/1080/?indonesia"

  mkdir -p "$folder_name"
  cd "$folder_name"

  for (( i=1; i<=$num_download; i++ ))
  do
    wget -q -O "$file_name" "$url"
    file_name="perjalanan_$((i+1))"
  done
}

# Zip folder
function zip_folder() {
  folder_name="kumpulan_$(( $(ls -1 | grep -c "kumpulan_") + 1 ))"
  zip_name="devil_$(( $(ls -1 | grep -c "devil_") + 1 )).ZIP"

  mkdir -p "$folder_name"
  cp -r "kumpulan_"* "$folder_name"

  zip -r "$zip_name" "$folder_name"

  rm -rf "$folder_name"
}

# Check parameter
if [ "$1" = "download" ]; then
  download
elif [ "$1" = "zip" ]; then
  zip_folder
else
  echo "Invalid parameter"
fi

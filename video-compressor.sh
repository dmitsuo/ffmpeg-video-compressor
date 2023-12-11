#!/bin/bash

# This script will compress all video files in a source folder
# and save them as mp4 files in a destination folder
# using ffmpeg tool


if pgrep "ffmpeg" >/dev/null; then
    echo "FFmepg is already running."
    read -p "Press any key to exit..."
    exit 1
fi


echo
echo "  ##################################################################"
echo "  ##                                                              ##"
echo "  ##                  FFMPEG VIDEO COMPRESSOR                     ##"
echo "  ##                                                              ##"
echo "  ##################################################################"
echo

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

# Check if ffmpeg command exists on current dir
if ! command -v "$SCRIPT_DIR/ffmpeg" &> /dev/null; then
    echo "The FFmpeg command line tool is missing. Please download it and copy it to the same folder of this script, then try again."
    read -p "Press any key to exit..."
    exit 1
fi

if [ $# -eq 0 ]; then    
    # Prompt the user for the source folder
    read -p "Videos source folder: " source_dir
else
    # Se um argumento foi passado, usa o primeiro argumento fornecido
    source_dir="$1"
fi


# Check if the source directory exists
if [ ! -d "$source_dir" ]; then
  echo "Source directory does not exist."
  read -p "Press any key to exit..."
  exit 1
fi

source_dir=$(echo "$source_dir" | sed 's:/*$::')

### Parameters that you can change to fit your needs - BEGIN
SOURCE_EXTENSIONS=("ts" "avi" "mkv" "mov" "webm" "mp4")
CPU_USED="12"
VIDEO_CONSTANT_RATE_FACTOR="26"
AUDIO_BITRATE="32k"
AUDIO_SAMPLING_RATE="32000"
AUDIO_CHANNELS="1"
### Parameters that you can change to fit your needs - END

# Create a folder called "converted_videos" inside the source directory
dest_dir="$source_dir/converted_videos"
mkdir -p "$dest_dir"
# extension="ts"


# Loop através de cada extensão na lista
for ext in "${SOURCE_EXTENSIONS[@]}"; do
  # Loop através de todos os arquivos com a extensão atual
  for file in "$source_dir"/*."$ext"; do
    # Verifica se há arquivos correspondentes à extensão atual
    if [ -e "$file" ]; then
      # Restante do seu código para converter o arquivo, mantendo a estrutura existente
      filename=$(basename -- "$file")
      filename="${filename%.*}"
      output_file="$dest_dir/$filename.mp4"
      
      echo "Compressing \"$filename.$ext\" ..."
      $SCRIPT_DIR/ffmpeg -n -hide_banner -loglevel error -stats -i "$file" -cpu-used $CPU_USED -c:v libx264 \
                         -preset fast -crf $VIDEO_CONSTANT_RATE_FACTOR -c:a aac -b:a $AUDIO_BITRATE \
                         -ar $AUDIO_SAMPLING_RATE -ac $AUDIO_CHANNELS "$output_file"
    fi
  done
done

echo "All files converted successfully."


if [[ "$2" != 'NOT_PAUSE' ]] ; then
  read -p "Press any key to exit..."
fi
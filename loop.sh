#!/bin/bash

if pgrep "ffmpeg" >/dev/null; then
    echo "FFmepg is already running."
    read -p "Press any key to exit..."
    exit 1
fi

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


while true; do
  # Chama o script de conversão de vídeo
  "$SCRIPT_DIR/video-compressor.sh" "$source_dir" "NOT_PAUSE"

  echo Waiting 5 seconds... 
  sleep 5  
done
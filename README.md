# FFmpeg video compressor
Simple command line tool to compress videos from a local folder using FFmpeg.

## Instructions
<h3>Step 1 - Clone this repository to your local machine</h3>

```bash
git clone https://github.com/dmitsuo/ffmpeg-video-compressor.git
```
<h3>Step 2 - Download FFmpeg</h3>
You have to manually download FFmpeg command line tool from one of the sources below, depending on your system, and place its "ffmpeg" (Linux) or "ffmpeg.exe" (Windows) binary file inside the same folder where you clone this repository on your local filesystem<br/>
<li><b>Microsoft Windows 10/11</b>: https://www.gyan.dev/ffmpeg/builds
<li><b>Linux</b>: https://johnvansickle.com/ffmpeg
<li><b>Other platforms</b>: https://www.ffmpeg.org/download.html

<h3>Step 3 - (OPTIONAL) Adjust <code>video-compressor.[sh|bat]</code> script if needed</h3>

Optionnaly, you can change the conversion parameters of FFmpeg inside [video-compressor.sh](./video-compressor.sh) file (Linux) or [video-compressor.bat](video-compressor.bat) file (Windows) to fit your needs or just accept the default values. 

<b>We recommend that you stay with the default parameter values and only change them if the results are not acceptable.</b>

Those parameters are shown below:

- Linux: around line 50 of [video-compressor.sh](./video-compressor.sh) file
```bash
## ... rest of the code ommited

### Parameters that you can change to fit your needs - BEGIN
SOURCE_EXTENSIONS=("ts" "avi" "mkv" "mov" "webm" "mp4")
CPU_USED="12"
VIDEO_CONSTANT_RATE_FACTOR="26"
AUDIO_BITRATE="32k"
AUDIO_SAMPLING_RATE="32000"
AUDIO_CHANNELS="1"
### Parameters that you can change to fit your needs - END

## ... rest of the code ommited
```
<br/>

- Windows: around line 51 of [video-compressor.bat](./video-compressor.bat) file
```powershel
REM ... rest of the code ommited

REM Parameters that you can change to fit your needs - BEGIN
set "SOURCE_EXTENSIONS=webm ts mp4 mkv avi mov"
set "CPU_USED=12"
set "VIDEO_CONSTANT_RATE_FACTOR=26"
set "AUDIO_BITRATE=32k"
set "AUDIO_SAMPLING_RATE=32000"
set "AUDIO_CHANNELS=1"
REM Parameters that you can change to fit your needs - END

REM ... rest of the code ommited
```

To get more details about FFmpeg parameters, please go to its documentation website: https://ffmpeg.org/ffmpeg.html

<h3>Step 4 - Call <code>video-compressor.[sh|bat]</code> script</h3>

To compress all video files in a given local folder, call the [video-compressor.sh](./video-compressor.sh) script (Linux) or the [video-compressor.bat](video-compressor.bat) file (Windows) via the command line, passing the full path to the videos folder you want to compress, for example:

- Linux
```bash
./video-compressor.sh "/path/to/my/videos/folder"
```
<br/>

- Windows
```powershel
video-compressor.bat "C:\Users\myusername\Videos"
```
These scripts can be called without arguments, in which case they will prompt the user for the full path of the videos folder.

The compressed video files will be saved in a folder called “**converted_videos**”, which will be created in the same source folder as the video files.

<h3>Step 5 - (OPTIONAL) Call <code>loop.[sh|bat]</code> script if you need to compress video files continuously</h3>

If you need this tool to compress video files uninterruptedly, as the files are created/copied in the source folder, run the [loop.sh](./loop.sh) script (Linux) or the [loop.bat](loop.bat) file (Windows), as shown in the example below:

- Linux
```bash
./loop.sh "/path/to/my/videos/folder"
```
<br/>

- Windows
```powershel
loop.bat "C:\Users\myusername\Videos"
```

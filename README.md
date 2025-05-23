# gif
Easily create gifs from video files

## Prerequisites
- [ffmpeg](https://ffmpeg.org/) must be installed on your system

## Usage
```bash
gif <input_file> [-o output_file] [-s start_time] [-e end_time]
```

### Options
- `-o output_file`: Specify the output GIF filename (optional)
- `-s start_time`: Set the start time (e.g., 00:00:03.5 or 3.5)
- `-e end_time`: Set the end time (e.g., 00:00:08.0 or 8)

### Examples
1. Convert entire video to GIF:
```bash
gif video.mp4
```

2. Convert with custom output filename:
```bash
gif video.mp4 -o my_animation.gif
```

3. Convert specific time segment:
```bash
gif video.mp4 -s 00:00:03.5 -e 00:00:08.0
```

4. Convert using seconds:
```bash
gif video.mp4 -s 3.5 -e 8
```

## Output
- The script creates a GIF with the following settings:
  - 15 FPS
  - Width: 960px (height scaled proportionally)
  - High-quality Lanczos scaling
  - Optimized color palette

## Notes
- If no output filename is specified, the GIF will be saved with the same name as the input file but with a .gif extension
- The script automatically cleans up temporary files after conversion

## Installation
```bash
sudo curl -o sudo curl -o /usr/local/bin/gif https://raw.githubusercontent.com/santigallego9/gif/refs/heads/main/gif.sh
sudo chmod +x /usr/local/bin/gif
```

### Install ffmpeg
#### macOS
Using Homebrew:
```bash
brew install ffmpeg
```

#### Linux
Using apt (Debian/Ubuntu):
```bash
sudo apt update
sudo apt install ffmpeg
```

Using dnf (Fedora/RHEL):
```bash
sudo dnf install ffmpeg
```

### Windows
Using Chocolatey:
```powershell
choco install ffmpeg
```

### Manual Installation
If you prefer to install manually:
1. Download the `gif.sh` script
2. Make it executable:
```bash
sudo chmod +x gif.sh
```
3. Move it to a directory in your PATH:
```bash
sudo mv gif.sh /usr/local/bin/gif
```

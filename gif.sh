#!/bin/zsh
set -e  # Exit immediately on error

# Check for ffmpeg
if ! command -v ffmpeg >/dev/null 2>&1; then
  echo "Error: ffmpeg is not installed." >&2
  exit 1
fi

# Help function
show_help() {
  echo "Usage: gif <input_file> [-o output_file] [-s start_time] [-e end_time]"
  echo "  -o output_file   Output GIF filename (optional)"
  echo "  -s start_time    Start time (e.g. 00:00:03.5 or 3.5)"
  echo "  -e end_time      End time (e.g. 00:00:08.0 or 8)"
  exit 1
}

# Validate args
if [[ $# -lt 1 ]]; then
  show_help
fi

input_file="$1"
shift

# Defaults
output_file=""
start_time="0"
end_time=""

# Parse flags
while [[ $# -gt 0 ]]; do
  case "$1" in
    -o)
      output_file="$2"
      shift 2
      ;;
    -s)
      start_time="$2"
      shift 2
      ;;
    -e)
      end_time="$2"
      shift 2
      ;;
    -*)
      echo "Unknown option: $1"
      show_help
      ;;
    *)
      echo "Unexpected argument: $1"
      show_help
      ;;
  esac
done

# Set default output file if not specified
if [[ -z "$output_file" ]]; then
  output_file="${input_file%.*}.gif"
fi

palette="palette.png"

# Build duration arguments safely
duration_args=(-ss "$start_time")
[[ -n "$end_time" ]] && duration_args+=(-to "$end_time")

# Generate palette
ffmpeg "${duration_args[@]}" -i "$input_file" \
  -vf "fps=15,scale=960:-1:flags=lanczos,palettegen" \
  -f image2 -frames:v 1 -y "$palette"

# Generate GIF using the palette
ffmpeg "${duration_args[@]}" -i "$input_file" -i "$palette" \
  -filter_complex "[0:v]fps=15,scale=960:-1:flags=lanczos[x];[x][1:v]paletteuse" \
  -y "$output_file"

# Cleanup
[[ -f "$palette" ]] && rm "$palette"

echo "✅ GIF saved to: $output_file"
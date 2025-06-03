# Audio Bitrate Checker

A simple command-line tool to check the bitrate of audio files interactively.

## Requirements

- Python 3.x
- ffmpeg/ffprobe (must be installed and available in your system PATH)

## Installation

1. Make sure you have ffmpeg installed on your system:

   - For macOS: `brew install ffmpeg`

2. Make the script executable:

   ```bash
   chmod +x check_bitrate.py
   ```

## Usage

1. Run the script:

   ```bash
   ./check_bitrate.py
   ```

2. When prompted, enter the full path to your audio file:

   ```bash
   > /path/to/your/audio/file.m4a
   ```

3. The script will display the bitrate of the audio file in kbps:

   ```bash
   ビットレート: 256.0 kbps
   ```

4. You can check multiple files in succession. To exit the program, type 'q' when prompted for a file path.

## Features

- Supports various audio formats (mp3, m4a, wav, etc.)
- Displays bitrate in kbps
- Interactive command-line interface
- Error handling for invalid files or paths
- Checks both stream and format information for accurate bitrate detection

## Related Tools

- [WAV to M4A Converter with Speed-up](../convert_and_speedup_wav/README.md)
- [M4A Speed-up Tool](../speedup_m4a_only/README.md)

## Example

```bash
$ ./check_bitrate.py
音声ファイルのビットレートを確認します。
ファイルパスを入力してください（終了するには 'q' を入力）:
> /Users/username/Music/song.m4a
ビットレート: 256.0 kbps

次のファイルを入力するか、終了するには 'q' を入力してください:
> q
プログラムを終了します。
```

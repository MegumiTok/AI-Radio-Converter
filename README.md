# AI Radio Converter

A collection of tools for audio file conversion and processing, specifically designed for managing audio summary files from NotebookLM.

## Tools

1. [WAV to M4A Converter with Speed-up](convert_and_speedup_wav/README.md)

   - Converts WAV files to M4A format and speeds up the audio
   - Includes input/output directories for batch processing

2. [M4A Speed-up Tool](speedup_m4a_only/README.md)

   - Speeds up existing M4A files
   - Optimized for post-conversion processing

3. [Audio Bitrate Checker](check_audio_bitrate/README.md)

   - Checks the bitrate of audio files
   - Interactive command-line interface

4. [Add Metadata to M4A](add_metadata/README.md)
   - Adds metadata to M4A files (artist name and compilation flag)

## Prerequisites

- macOS (tested on macOS 24.5.0)
- ffmpeg installed on your system
- Python 3.x (for bitrate checker)

## Directory Structure

```text
AIRadioConverter/
├── convert_and_speedup_wav/    # WAV to M4A conversion with speed-up
├── speedup_m4a_only/          # M4A speed-up only
├── check_audio_bitrate/       # Bitrate checking tool
├── add_metadata/              # Metadata addition tool
└── docs/                     # Developer's Notes and documentation
```

## Project Background

This project was created to manage and process audio summary files from NotebookLM. The main goals are:

- Convert WAV files to M4A format for better file size management
- Speed up audio playback to 1.5x for efficient listening
- Maintain audio quality while reducing file size
- Provide tools for audio file analysis

For detailed information about each tool and its usage, please refer to the individual README files linked above.

## Notes

- All tools are designed to work with macOS
- Original files are never modified
- Output files are named with "\_1.5x" suffix
- For best results, use QuickTime Player for initial WAV to M4A conversion

## Developer's Notes

- [本プロジェクトの目的など (2025-05-23)](docs/project-overview-2025-05-23.md)
- [M4A 変換と倍速処理における音質と bitrate の分析 (2025-05-23)](docs/audio-analysis-2025-05-23.md)
- [M4A ファイルへのメタデータ追加 開発方針検討（2025-06-03）](docs/add_metadata-2025-06-03-v1.md)
- [M4A ファイルへのメタデータ追加 開発プロセスの振り返り（2025-06-03）](docs/add_metadata-2025-06-03-v2.md)

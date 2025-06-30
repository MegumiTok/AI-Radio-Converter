# Audio Metadata Tools

Tools for adding metadata to M4A and MP3 files. These tools automate the process of adding metadata and speed processing to audio files, making it easier to manage and organize your audio files.

**Note**: MP3 and M4A files are now processed by separate scripts for optimal format-specific handling.

## Features

- Add metadata to audio files
  - Set artist name: "AI らじお"
  - Enable compilation flag
- Speed up audio to 1.5x
- Support for both M4A and MP3 formats
- Automated processing with format-specific optimization

## Supported Formats

### M4A Files

- Speed processing: Uses `speedup_existing_m4a.sh` script
- Metadata: Uses AtomicParsley for iTunes-compatible metadata

### MP3 Files

- Speed processing: Uses ffmpeg with atempo filter
- Metadata: Uses ffmpeg for ID3 tag processing
- Both speed and metadata are processed in a single operation
- **⚠️ Known Issue**: Compilation flag is set in metadata but not recognized by Music app (requires manual setting)

## Prerequisites

- macOS 24.5.0
- [AtomicParsley](https://github.com/wez/atomicparsley) (CLI tool for M4A metadata editing)
- ffmpeg (for MP3 processing and speed adjustment)

## Directory Structure

```text
AIRadioConverter/
├── speedup_m4a_only/
│   ├── input_m4a/     # Place your M4A and MP3 files here
│   └── output_m4a/    # Processed files will be here
└── add_metadata/
    ├── add_metadata_m4a.sh  # For M4A files (unified script)
    └── add_metadata_mp3.sh  # For MP3 files (dedicated script)
```

## Usage Examples

① Place M4A and/or MP3 files in `speedup_m4a_only/input_m4a/`

② Choose the appropriate script and run from the project root directory (AIRadioConverter/):

### For M4A files:

```bash
# Normal mode (speed-up + metadata)
./add_metadata/add_metadata_m4a.sh

# Metadata only mode
./add_metadata/add_metadata_m4a.sh -m

# Show help
./add_metadata/add_metadata_m4a.sh -h
```

### For MP3 files:

```bash
# Normal mode (speed-up + metadata)
./add_metadata/add_metadata_mp3.sh

# Metadata only mode
./add_metadata/add_metadata_mp3.sh -m

# Show help
./add_metadata/add_metadata_mp3.sh -h
```

③ Processed files will be in `speedup_m4a_only/output_m4a/`

## Command Line Options

- `-m, --metadata-only`: Add metadata to existing files in the output directory (files will be overwritten)
- `-h, --help`: Show help message with detailed format support information

## Processing Details

### Normal Mode

- **M4A files**: First processed by `speedup_existing_m4a.sh` for speed adjustment, then AtomicParsley adds metadata
- **MP3 files**: ffmpeg handles both speed adjustment (1.5x) and ID3 metadata in one operation

### Metadata-only Mode (-m option)

- **M4A files**: AtomicParsley overwrites existing metadata in output directory
- **MP3 files**: ffmpeg overwrites existing ID3 tags in output directory

## Important Notes

### MP3 Compilation Flag Issue

**⚠️ Known Limitation**: While the compilation flag is correctly set in MP3 metadata (verified by `ffprobe`), it is **not recognized by the Music app**. You will need to manually enable the compilation setting in the Music app for each MP3 file.

### General Notes

- When using the `-m` option, the script processes files in `speedup_m4a_only/output_m4a/` directory
- Existing files in the output directory will be overwritten with new metadata
- If a file already has metadata, it will be completely replaced with the new metadata (artist: "AI らじお" and compilation flag)
- MP3 files maintain their format throughout processing (no conversion to M4A)
- Audio quality is preserved while reducing file size through optimized encoding
- Make sure to run the script from the project root directory (AIRadioConverter/)

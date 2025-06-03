# M4A Metadata Tool

A tool for adding metadata to M4A files. This tool automates the process of adding metadata to M4A files, making it easier to manage and organize your audio files.

## Features

- Add metadata to M4A files
  - Set artist name: "AI らじお"
  - Enable compilation flag
- Automated metadata addition process
- Integration with speed-up processing tool

## Prerequisites

- macOS 24.5.0
- [AtomicParsley](https://github.com/wez/atomicparsley) (CLI tool for metadata editing)

## Directory Structure

```text
AIRadioConverter/
├── speedup_m4a_only/
│   ├── input_m4a/     # Place your M4A files here
│   └── output_m4a/    # Processed files will be here
└── add_metadata/
    └── add_metadata_m4a.sh
```

## Usage

① Place M4A files in `speedup_m4a_only/input_m4a/`

② Run the script from the project root directory (AIRadioConverter/):

```bash
# Normal mode (speed-up + metadata)
./add_metadata/add_metadata_m4a.sh

# Metadata only mode (processes and overwrites files in output directory)
./add_metadata/add_metadata_m4a.sh -m
```

③ Processed files will be in `speedup_m4a_only/output_m4a/`

## Command Line Options

- `-m, --metadata-only`: Add metadata to existing files in the output directory (files will be overwritten)
- `-h, --help`: Show help message

## Notes

- When using the `-m` option, the script processes files in `speedup_m4a_only/output_m4a/` directory
- Existing files in the output directory will be overwritten with new metadata
- If a file already has metadata, it will be completely replaced with the new metadata (artist: "AI らじお" and compilation flag)
- Make sure to run the script from the project root directory (AIRadioConverter/)

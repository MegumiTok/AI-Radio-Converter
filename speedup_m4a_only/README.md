# M4A Speed-up Tool

This tool speeds up existing M4A files to 1.5x without converting the format.

## Directory Structure

```text
speedup_m4a_only/
├── input_m4a/      # Place your M4A files here
├── output_m4a/     # Speed-up files will be here
└── speedup_existing_m4a.sh
```

## Usage

1. Make the script executable (one-time setup):

   ```bash
   chmod +x speedup_existing_m4a.sh
   ```

2. Place your M4A files in the `input_m4a` directory

3. Run the script:

   ```bash
   ./speedup_existing_m4a.sh
   ```

4. The speed-up files will be created in `output_m4a`

## Technical Details

- Uses ffmpeg's atempo filter to speed up audio to 1.5x
- Maintains original audio quality and bitrate
- Output files are named with "\_1.5x" suffix

## Notes

- Original files are not modified
- This tool is optimized for M4A files that were converted using [QuickTime Player](../README.md#notes)
- If you need to check the bitrate of the output files, use the [Audio Bitrate Checker](../check_audio_bitrate/README.md)
- For best results, use this tool after converting WAV to M4A with QuickTime Player

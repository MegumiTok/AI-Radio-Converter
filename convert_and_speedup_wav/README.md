# WAV to M4A Converter with Speed-up

This tool converts WAV files to M4A format and speeds up the audio to 1.5x.

## Directory Structure

```text
convert_and_speedup_wav/
├── input_wav/      # Place your WAV files here
├── output_m4a/     # Converted and speed-up files will be here
└── convert_wav_to_m4a_and_speedup.sh
```

## Usage

1. Make the script executable (one-time setup):

   ```bash
   chmod +x convert_wav_to_m4a_and_speedup.sh
   ```

2. Place your WAV files in the `input_wav` directory

3. Run the script:

   ```bash
   ./convert_wav_to_m4a_and_speedup.sh
   ```

4. The converted and speed-up files will be created in `output_m4a`

## Technical Details

- Converts WAV to M4A using AAC codec
- Sets bitrate to 64kbps
- Speeds up audio to 1.5x using ffmpeg's atempo filter
- Output files are named with "\_1.5x" suffix

## Notes

- Original files are not modified
- For best audio quality, consider using [QuickTime Player](../README.md#notes) for the initial WAV to M4A conversion
- If you need to check the bitrate of the output files, use the [Audio Bitrate Checker](../check_audio_bitrate/README.md)

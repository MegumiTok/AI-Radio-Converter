# AI Radio Converter

A simple tool to convert WAV files to M4A format and speed up audio files. This tool provides two main functionalities:

1. Convert WAV to M4A and speed up the audio
2. Speed up existing M4A files

## Prerequisites

- macOS (tested on macOS 24.5.0)
- ffmpeg installed on your system

## Directory Structure

```text
AIRadioConverter/
├── convert_and_speedup_wav/
│   ├── input_wav/      # Place your WAV files here
│   ├── output_m4a/     # Converted and speed-up files will be here
│   └── convert_wav_to_m4a_and_speedup.sh
└── speedup_m4a_only/
    ├── input_m4a/      # Place your M4A files here
    ├── output_m4a/     # Speed-up files will be here
    └── speedup_existing_m4a.sh
```

## Usage

First, navigate to the project directory:

```bash
cd /path/to/AIRadioConverter
```

Then, make the scripts executable (this is a one-time setup):

```bash
chmod +x convert_and_speedup_wav/convert_wav_to_m4a_and_speedup.sh speedup_m4a_only/speedup_existing_m4a.sh
```

### 1. Convert WAV to M4A and Speed Up (WIP)

1. Place your WAV files in the `convert_and_speedup_wav/input_wav` directory
2. Run the script:

   ```bash
   ./convert_and_speedup_wav/convert_wav_to_m4a_and_speedup.sh
   ```

3. The converted and speed-up files will be created in `convert_and_speedup_wav/output_m4a`

### 2. Speed Up Existing M4A Files

1. Place your M4A files in the `speedup_m4a_only/input_m4a` directory
2. Run the script:

   ```bash
   ./speedup_m4a_only/speedup_existing_m4a.sh
   ```

3. The speed-up files will be created in `speedup_m4a_only/output_m4a`

## Notes

- Audio files are speed up to 1.5x
- For radio-like quality, a bitrate of 32-64kbps is recommended
- When speed-up is applied, you might want to increase the bitrate slightly to compensate for quality loss
- Original files are not modified
- Output files are named with "\_1.5x" suffix

## Developer's Notes

### 本プロジェクトの目的など

このプロジェクトは、主に NotebookLM で作成した音声概要ファイルの管理と活用を目的としています。NotebookLM からダウンロードされる WAV 形式のファイルは、そのままではサイズが大きく、個人利用には少々扱いにくいと感じていました。そこで、Mac との相性が良く、ファイルサイズを抑えられる M4A 形式への変換 を考えました。

個人的なニーズとして、長い音声コンテンツを効率的に聴くために 再生速度を 1.5 倍速に一括で変更したかったため、超便利ツールとして名高い[ffmpeg](https://ffmpeg.org/) を使っていました。

しかし、手動でコマンドを実行していましたが、毎回ターミナルで操作するのは手間がかかりますし、コマンドの管理も煩雑になります。そこで、これらの操作を自動化しようと思ったのが今回 shell script を書くことにしたきかっけです。コード化しておけばバージョン管理も Git でできて便利なメリットもあります。

音質についても考慮しました。個人的に QuickTime Player で簡単なファイル編集を行うことがありますが、WAV から M4A に変換したファイルをさらに倍速処理すると、若干音がこもるように感じられました。そのため、速度調整時のビットレートは 48–64kbps くらいが、ラジオレベルの聴きやすさを保ちつつ、音質の劣化を抑えるのにちょうど良いかな、という今のところの感想です。

> NOTE:
> M4A の基盤である Advanced Audio Coding (AAC) codec が非可逆圧縮のため、一度圧縮された音声を再度加工（再エンコード）する場合はさらなる劣化（多段階圧縮劣化）が避けられなません。

M4A 形式のファイルを何度も再編集すると劣化の心配はありますが、速度変更以外の編集であれば、たとえば [LosslessCut](https://github.com/mifi/lossless-cut) のようなツールを使えば、M4A 形式でも目立った劣化は気にならないと考えています。 LosslessCut は実際使っていますがとっても便利です。

■ まとめ

今回書いた shell script を実行したら `.wav` ファイルを `.m4a` ファイルに convert することでファイル圧縮できたり、音声速度を好みに合わせて変えれたりして便利になりました。音質が気になるようであれば bitrate も適宜調整したいと思います。また音声ファイルのトリミングについては個人的には LosslessCut をつかえば音質の劣化は気にならないと思ってます。

■ 余談

今回ファイル圧縮界隈についても少し調べてみたのですが、人間が認知しないところをうまく誤魔化してファイルサイズを小さくしてる技術がとても面白いなって思いました。Codec の世界は興味深いですね。

### M4A変換と倍速処理における音質とbitrateの分析

QuickTime Playerと今回作成したスクリプトを用いて、WAVファイルからM4Aファイルへの変換、および倍速処理（1.5倍速）を行った際の音質とbitrateについて調査しました。

▷ 調査結果の概要

テスト用のWAVファイルを用いて、以下の結果が得られました。

bitrateの確認には別で作成したスクリプト（`check_audio_bitrate/check_bitrate.py`）を使いました。

|                                                          |           |      |               |
| -------------------------------------------------------- | --------- | ---- | ------------- |
| 処理方法                                                     | bitrate   | 音質   | 備考            |
| QuickTime Playerで変換                                      | 32.5 kbps | クリア  | 変換のみ          |
| スクリプト（`convert_wav_to_m4a_and_speedup.sh`）で変換+倍速         | 70.8 kbps | 雑音あり |               |
| QuickTime Playerで変換後、スクリプト（`speedup_existing_m4a.sh`）で倍速 | 68.3 kbps | 問題なし | 倍速処理のみスクリプト使用 |

▷ 考察と推奨

この結果から、現時点ではQuickTime PlayerでM4Aに変換した後、スクリプト（`speedup_existing_m4a.sh`）で倍速処理を行う方法がよろしいかと思いました。個人的にこの方法でも特に手間ではないのでとりあえず満足です。

スクリプト（`convert_wav_to_m4a_and_speedup.sh`）による変換処理ではビットレートが不必要に高くなり、音質に雑音が入る問題が確認されました。今後、改善できればいいかもしれません。

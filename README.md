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

## Prerequisites

- macOS (tested on macOS 24.5.0)
- ffmpeg installed on your system
- Python 3.x (for bitrate checker)

## Directory Structure

```text
AIRadioConverter/
├── convert_and_speedup_wav/    # WAV to M4A conversion with speed-up
├── speedup_m4a_only/          # M4A speed-up only
└── check_audio_bitrate/       # Bitrate checking tool
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

### M4A 変換と倍速処理における音質と bitrate の分析

QuickTime Player と今回作成したスクリプトを用いて、WAV ファイルから M4A ファイルへの変換、および倍速処理（1.5 倍速）を行った際の音質と bitrate について調査しました。

▷ 調査結果の概要

テスト用の WAV ファイルを用いて、以下の結果が得られました。

bitrate の確認には別で作成したスクリプト（`check_audio_bitrate/check_bitrate.py`）を使いました。

|                                                                          |           |          |                            |
| ------------------------------------------------------------------------ | --------- | -------- | -------------------------- |
| 処理方法                                                                 | bitrate   | 音質     | 備考                       |
| QuickTime Player で変換                                                  | 32.5 kbps | クリア   | 変換のみ                   |
| スクリプト（`convert_wav_to_m4a_and_speedup.sh`）で変換+倍速             | 70.8 kbps | 雑音あり |                            |
| QuickTime Player で変換後、スクリプト（`speedup_existing_m4a.sh`）で倍速 | 68.3 kbps | 問題なし | 倍速処理のみスクリプト使用 |

▷ 考察と推奨

この結果から、現時点では QuickTime Player で M4A に変換した後、スクリプト（`speedup_existing_m4a.sh`）で倍速処理を行う方法がよろしいかと思いました。個人的にこの方法でも特に手間ではないのでとりあえず満足です。

スクリプト（`convert_wav_to_m4a_and_speedup.sh`）による変換処理ではビットレートが不必要に高くなり、音質に雑音が入る問題が確認されました。今後、改善できればいいかもしれません。

#!/bin/bash

# 作業ディレクトリのパスを設定
project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
input_dir="${project_dir}/convert_and_speedup_wav/input_wav"
output_dir="${project_dir}/convert_and_speedup_wav/output_m4a"

# 出力ディレクトリが存在しない場合は作成
mkdir -p "$output_dir"

# input_wav フォルダ内のすべての .wav ファイルをループ処理
for file in "$input_dir"/*.wav; do
  # ファイル名から拡張子を除いた部分を取得
  filename=$(basename "$file" .wav)

  echo "Processing: $file"

  # ffmpeg で変換を実行
  # -i: 入力ファイル
  # -filter:a "atempo=1.5": 音声のテンポを1.5倍にする（速度を1.5倍にする）
  # -c:a aac: 音声コーデックをAACに指定
  # -b:a 64k: 音声のビットレートを64kbpsに指定
  ffmpeg -i "$file" -filter:a "atempo=1.5" -c:a aac -b:a 64k "$output_dir/${filename}_1.5x.m4a"
  # ffmpeg -i "$file" -filter:a "atempo=1.7" -c:a aac -b:a 64k "$output_dir/${filename}_1.7x.m4a"


  echo "Finished: $output_dir/${filename}_1.5x.m4a"
  echo "-----------------------------------"
done

echo "All WAV files processed."
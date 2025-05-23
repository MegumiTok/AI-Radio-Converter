#!/bin/bash

# 作業ディレクトリのパスを設定
project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
input_dir="${project_dir}/speedup_m4a_only/input_m4a"
output_dir="${project_dir}/speedup_m4a_only/output_m4a"

# 出力ディレクトリが存在しない場合は作成
mkdir -p "$output_dir"

# input_m4a フォルダ内のすべての .m4a ファイルをループ処理
for file in "$input_dir"/*.m4a; do
  # ファイル名から拡張子を除いた部分を取得
  filename=$(basename "$file" .m4a)

  echo "Processing: $file"

  # ffmpeg で倍速化を実行
  # -i: 入力ファイル
  # -filter:a "atempo=1.5": 音声のテンポを1.5倍にする（速度を1.5倍にする）
  # -vn: ビデオストリームを無視
  ffmpeg -i "$file" -filter:a "atempo=1.5" -vn "$output_dir/${filename}_1.5x.m4a"

  echo "Finished: $output_dir/${filename}_1.5x.m4a"
  echo "-----------------------------------"
done

echo "All M4A files processed." 
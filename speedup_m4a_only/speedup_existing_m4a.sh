#!/bin/bash

# 作業ディレクトリのパスを設定
project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
input_dir="${project_dir}/speedup_m4a_only/input_m4a"
output_dir="${project_dir}/speedup_m4a_only/output_m4a"

# 出力ディレクトリが存在しない場合は作成
mkdir -p "$output_dir"

# 最初のファイルのビットレートを取得して表示する関数
get_bitrate() {
    local file="$1"
    ffprobe -v error -select_streams a:0 -show_entries stream=bit_rate -of default=noprint_wrappers=1:nokey=1 "$file"
}

# input_m4a フォルダ内のすべての .m4a ファイルをループ処理
first_file=true
for file in "$input_dir"/*.m4a; do
  # ファイル名から拡張子を除いた部分を取得
  filename=$(basename "$file" .m4a)

  echo "Processing: $file"

  # 最初のファイルの場合、元のビットレートを表示
  if [ "$first_file" = true ]; then
    original_bitrate=$(get_bitrate "$file")
    echo "Original bitrate: $((original_bitrate/1000))kbps"
    first_file=false
  fi

  # ffmpeg で倍速化を実行
  # -i: 入力ファイル
  # -filter:a "atempo=1.5": 音声のテンポを1.5倍にする（速度を1.5倍にする）
  # -c:a aac: 音声コーデックをAACに指定
  # -b:a 64k: 音声のビットレートを64kbpsに指定
  # -vn: ビデオストリームを無視
  ffmpeg -i "$file" -filter:a "atempo=1.5" -c:a aac -b:a 64k -vn "$output_dir/${filename}.m4a"

  # 最初のファイルの場合、変換後のビットレートを表示
  if [ "$first_file" = false ]; then
    output_file="$output_dir/${filename}.m4a"
    new_bitrate=$(get_bitrate "$output_file")
    echo "New bitrate: $((new_bitrate/1000))kbps"
    echo "Bitrate change: $((original_bitrate/1000))kbps -> $((new_bitrate/1000))kbps"
    first_file=true  # 最初のファイルの処理が終わったらフラグをリセット
  fi

  echo "Finished: $output_dir/${filename}.m4a"
  echo "-----------------------------------"
done

echo "All M4A files processed." 
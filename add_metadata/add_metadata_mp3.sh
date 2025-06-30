#!/bin/bash

# プロジェクトのルートディレクトリを取得
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# 入力・出力ディレクトリのパス
INPUT_DIR="$PROJECT_ROOT/speedup_m4a_only/input_m4a"
OUTPUT_DIR="$PROJECT_ROOT/speedup_m4a_only/output_m4a"

# 入力ディレクトリの存在確認
if [ ! -d "$INPUT_DIR" ]; then
    echo "Error: Input directory not found: $INPUT_DIR"
    exit 1
fi

# 出力ディレクトリの存在確認と作成
if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir -p "$OUTPUT_DIR"
fi

# MP3ファイルの存在確認
mp3_files=$(find "$INPUT_DIR" -maxdepth 1 -type f -name "*.mp3")
if [ -z "$mp3_files" ]; then
    echo "No MP3 files found in $INPUT_DIR"
    exit 0
fi

# MP3用メタデータ追加処理（メタデータのみモード用）
add_metadata_mp3_only() {
    local file=$1
    local filename=$(basename "$file")
    echo "Processing MP3 metadata: $filename"
    
    # ffmpegを使用してメタデータの追加（上書き、ID3v2.3で最適化）
    # TODO: compilation=1とTCMP=1を設定しているが、現状Music appでは
    # compilationフラグが反映されない。手動でMusic appから設定する必要がある
    local temp_file="${file}.tmp"
    ffmpeg -i "$file" \
        -c copy \
        -id3v2_version 3 \
        -metadata artist="AI らじお" \
        -metadata compilation="1" \
        -metadata TCMP="1" \
        "$temp_file" -y -v quiet
    
    # 処理結果の確認
    if [ $? -eq 0 ]; then
        mv "$temp_file" "$file"
        echo "Successfully added metadata to $filename"
    else
        rm -f "$temp_file"
        echo "Error: Failed to add metadata to $filename"
    fi
}

# MP3ファイルの速度変更とメタデータ追加処理
process_mp3_files() {
    echo "Processing MP3 files for speed-up and metadata..."
    
    for file in "$INPUT_DIR"/*.mp3; do
        if [ -f "$file" ]; then
            local filename=$(basename "$file" .mp3)
            local output_file="$OUTPUT_DIR/${filename}.mp3"
            
            echo "Processing MP3: $filename"
            
            # ffmpegで速度変更とメタデータ追加を同時実行（ID3v2.3で最適化）
            # TODO: compilation=1とTCMP=1を設定しているが、現状Music appでは
            # compilationフラグが反映されない。手動でMusic appから設定する必要がある
            ffmpeg -i "$file" \
                -filter:a "atempo=1.5" \
                -c:a mp3 \
                -b:a 64k \
                -id3v2_version 3 \
                -metadata artist="AI らじお" \
                -metadata compilation="1" \
                -metadata TCMP="1" \
                "$output_file" -y -v quiet
            
            if [ $? -eq 0 ]; then
                echo "Successfully processed: ${filename}.mp3"
            else
                echo "Error: Failed to process ${filename}.mp3"
            fi
            echo "-----------------------------------"
        fi
    done
}

# ヘルプメッセージの表示
show_help() {
    echo "MP3 Metadata Tool - Specialized for MP3 files"
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -m, --metadata-only    Add metadata only (skip speed-up processing)"
    echo "  -h, --help             Show this help message"
    echo ""
    echo "Features:"
    echo "  - Speed up MP3 files to 1.5x"
    echo "  - Add ID3 metadata: artist='AI らじお' and compilation=1"
    echo "  - Uses ffmpeg with ID3v2.3 optimization for better compatibility"
    echo ""
    echo "Input directory:  $INPUT_DIR"
    echo "Output directory: $OUTPUT_DIR"
    exit 0
}

# コマンドラインオプションの解析
METADATA_ONLY=false
while [[ $# -gt 0 ]]; do
    case $1 in
        -m|--metadata-only)
            METADATA_ONLY=true
            shift
            ;;
        -h|--help)
            show_help
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            ;;
    esac
done

# メイン処理
if [ "$METADATA_ONLY" = false ]; then
    # 通常モード：速度変更とメタデータ追加
    echo "Running MP3 speed-up and metadata processing..."
    process_mp3_files
else
    # メタデータのみモード：出力ディレクトリ内のMP3ファイルを処理
    echo "Running MP3 metadata-only processing..."
    
    for file in "$OUTPUT_DIR"/*.mp3; do
        if [ -f "$file" ]; then
            add_metadata_mp3_only "$file"
        fi
    done
fi

echo "MP3 processing completed"

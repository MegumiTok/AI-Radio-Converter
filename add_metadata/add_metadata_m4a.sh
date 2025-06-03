#!/bin/bash

# プロジェクトのルートディレクトリを取得
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# 入力ディレクトリのパス
INPUT_DIR="$PROJECT_ROOT/speedup_m4a_only/input_m4a"
OUTPUT_DIR="$PROJECT_ROOT/speedup_m4a_only/output_m4a"
SPEEDUP_SCRIPT="$PROJECT_ROOT/speedup_m4a_only/speedup_existing_m4a.sh"

# 入力ディレクトリの存在確認
if [ ! -d "$INPUT_DIR" ]; then
    echo "Error: Input directory not found: $INPUT_DIR"
    exit 1
fi

# 出力ディレクトリの存在確認と作成
if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir -p "$OUTPUT_DIR"
fi

# M4Aファイルの存在確認
m4a_files=$(find "$INPUT_DIR" -maxdepth 1 -type f -name "*.m4a")
if [ -z "$m4a_files" ]; then
    echo "No M4A files found in $INPUT_DIR"
    exit 0
fi

# メタデータ追加のみの処理
add_metadata() {
    local file=$1
    local filename=$(basename "$file")
    echo "Processing: $filename"
    
    # メタデータの追加
    AtomicParsley "$file" \
        --artist "AI らじお" \
        --compilation 1 \
        --overWrite
    
    # 処理結果の確認
    if [ $? -eq 0 ]; then
        echo "Successfully added metadata to $filename"
    else
        echo "Error: Failed to add metadata to $filename"
    fi
}

# ヘルプメッセージの表示
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -m, --metadata-only    Add metadata only (skip speed-up processing)"
    echo "  -h, --help             Show this help message"
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

# 倍速処理の実行（メタデータのみモードでない場合）
if [ "$METADATA_ONLY" = false ] && [ -f "$SPEEDUP_SCRIPT" ]; then
    echo "Running speed-up processing..."
    "$SPEEDUP_SCRIPT"
elif [ "$METADATA_ONLY" = true ]; then
    echo "Running metadata-only processing..."
fi

# 出力ディレクトリ内のM4Aファイルに対してメタデータを追加
for file in "$OUTPUT_DIR"/*.m4a; do
    if [ -f "$file" ]; then
        add_metadata "$file"
    fi
done

echo "Processing completed" 
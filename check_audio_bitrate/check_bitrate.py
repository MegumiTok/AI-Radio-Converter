#!/usr/bin/env python3

import subprocess
import json
import sys
import re

def clean_file_path(file_path):
    # シングルクォートで囲まれている場合は除去
    file_path = file_path.strip()
    if file_path.startswith("'") and file_path.endswith("'"):
        file_path = file_path[1:-1]
    return file_path

def get_audio_bitrate(file_path):
    try:
        # パスをクリーンアップ
        file_path = clean_file_path(file_path)
        
        # ffprobeを使用して音声ファイルの情報を取得
        cmd = [
            'ffprobe',
            '-v', 'quiet',
            '-print_format', 'json',
            '-show_format',
            '-show_streams',
            file_path
        ]
        
        result = subprocess.run(cmd, capture_output=True, text=True)
        data = json.loads(result.stdout)
        
        # 音声ストリームを探す
        for stream in data.get('streams', []):
            if stream.get('codec_type') == 'audio':
                bitrate = stream.get('bit_rate')
                if bitrate:
                    # ビットレートをkbpsに変換
                    return int(bitrate) / 1000
                
        # ストリーム情報から取得できない場合はフォーマット情報から取得
        format_info = data.get('format', {})
        bitrate = format_info.get('bit_rate')
        if bitrate:
            return int(bitrate) / 1000
            
        return None
        
    except Exception as e:
        print(f"エラーが発生しました: {str(e)}")
        return None

def main():
    print("音声ファイルのビットレートを確認します。")
    print("ファイルパスを入力してください（終了するには 'q' を入力）:")
    print("※ パスはシングルクォート(')で囲んでも囲まなくても構いません")
    
    while True:
        file_path = input("> ").strip()
        
        if file_path.lower() == 'q':
            print("プログラムを終了します。")
            break
            
        if not file_path:
            print("ファイルパスを入力してください。")
            continue
            
        bitrate = get_audio_bitrate(file_path)
        
        if bitrate is not None:
            print(f"ビットレート: {bitrate:.1f} kbps")
        else:
            print("ビットレートを取得できませんでした。")
        
        print("\n次のファイルを入力するか、終了するには 'q' を入力してください:")

if __name__ == "__main__":
    main() 
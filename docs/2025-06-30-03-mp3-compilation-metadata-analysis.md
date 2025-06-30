# MP3 Compilation メタデータ問題の分析

## 問題の状況

ユーザーからの報告：「MP3 の metadata で compilation が追加されていません」

## 技術的調査結果

### ffprobe による確認

```bash
$ ffprobe -v quiet -show_format -show_streams "output.mp3" | grep -i -E "(artist|tcmp|compilation)"
TAG:compilation=1
TAG:artist=AI らじお
```

### ffmpeg による詳細確認

```bash
$ ffmpeg -i "output.mp3" 2>&1 | grep -A10 Metadata
  Metadata:
    compilation     : 1
    artist          : AI らじお
    encoder         : Lavf61.7.100
```

## 分析結果

**技術的には問題なし**: ffmpeg で設定したメタデータは正常に書き込まれている。

## 可能性の高い原因

### 1. ID3 タグバージョンの問題

MP3 の ID3 タグには複数のバージョン（ID3v1, ID3v2.3, ID3v2.4）があり、`compilation`フィールドの扱いが異なる可能性があります。

**ID3v2.4**: `TCMP`フレーム
**ID3v2.3**: `TCMP`フレームまたは独自フレーム
**ID3v1**: `compilation`フィールド非対応

### 2. 音楽アプリの互換性問題

- iTunes/Apple Music: ID3v2.3 の`TCMP`フレームを期待
- その他の音楽アプリ: 独自の実装

### 3. ffmpeg のデフォルト設定

ffmpeg は`-metadata compilation=\"1\"`を設定しているが、特定の ID3 タグバージョンや形式に最適化されていない可能性があります。

## 推奨される解決策

### 解決策 1: ID3 タグバージョンの明示的指定

```bash
ffmpeg -i input.mp3 -c copy -id3v2_version 3 -metadata artist=\"AI らじお\" -metadata TCMP=\"1\" output.mp3
```

### 解決策 2: 複数の compilation タグ設定

```bash
ffmpeg -i input.mp3 -c copy \
  -metadata artist=\"AI らじお\" \
  -metadata compilation=\"1\" \
  -metadata TCMP=\"1\" \
  output.mp3
```

### 解決策 3: 専用ツールの使用検討

- `eyeD3`: Python ベースの高機能 ID3 タグエディタ
- `mid3v2`: 軽量な ID3v2 タグエディタ

## 次のアクション

1. ID3 タグバージョンを明示的に指定した修正
2. 複数の音楽アプリでの検証
3. 必要に応じて専用ツールの導入検討

## 検証方法

音楽アプリ（iTunes, Apple Music, VLC 等）で実際に compilation として認識されるかの確認が最終的な検証方法となります。

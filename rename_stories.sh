#!/bin/bash

# 短編ファイルを各中分類ごとに01から連番に振り直すスクリプト

# 中分類ディレクトリを再帰的に処理
find "短編集" -mindepth 2 -maxdepth 2 -type d | sort | while read -r dir; do
    echo "Processing: $dir"

    # そのディレクトリ内の.txtファイルを取得（数字順にソート）
    counter=1
    find "$dir" -maxdepth 1 -name "*.txt" -type f | sort | while read -r file; do
        # ファイル名から番号部分とタイトル部分を分離
        basename=$(basename "$file")
        # 最初の数字_を削除してタイトル部分を取得
        title=${basename#*_}

        # 新しいファイル名を生成（01, 02, 03...）
        new_name=$(printf "%02d_%s" $counter "$title")
        new_path="$dir/$new_name"

        # ファイル名が変わる場合のみリネーム
        if [ "$file" != "$new_path" ]; then
            echo "  $basename -> $new_name"
            mv "$file" "$new_path"
        fi

        counter=$((counter + 1))
    done

    echo ""
done

echo "Renaming completed!"

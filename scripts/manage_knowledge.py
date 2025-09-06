#!/usr/bin/env python3
"""ナレッジ管理スクリプト"""
import sys
import yaml
from pathlib import Path
from datetime import datetime

def add_knowledge(title, category, content, tags=None):
    root = Path.cwd()
    index_file = root / "knowledge" / "_index.yaml"
    items_dir = root / "knowledge" / "items"
    
    # インデックス読み込み
    if index_file.exists():
        with open(index_file, "r", encoding="utf-8") as f:
            index = yaml.safe_load(f) or {"items": [], "categories": [], "tags": []}
    else:
        index = {"items": [], "categories": [], "tags": []}
    
    # ID生成
    knowledge_id = f"k{len(index['items'])+1:04d}"
    filename = f"{knowledge_id}_{title.replace(' ', '_').lower()}.md"
    
    # ファイル作成
    file_path = items_dir / filename
    with open(file_path, "w", encoding="utf-8") as f:
        f.write(f"# {title}\n\n")
        f.write(f"**カテゴリ**: {category}\n")
        f.write(f"**タグ**: {', '.join(tags or [])}\n")
        f.write(f"**作成日**: {datetime.now().strftime('%Y-%m-%d')}\n\n")
        f.write("## 内容\n\n")
        f.write(content)
    
    # インデックス更新
    index["items"].append({
        "id": knowledge_id,
        "title": title,
        "category": category,
        "tags": tags or [],
        "file": str(file_path.relative_to(root)),
        "created": datetime.now().strftime("%Y-%m-%d")
    })
    
    with open(index_file, "w", encoding="utf-8") as f:
        yaml.dump(index, f, allow_unicode=True, sort_keys=False)
    
    print(f"✅ ナレッジ '{title}' を追加しました")
    print(f"📁 {file_path}")

if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("Usage: python manage_knowledge.py <title> <category> <content> [tags...]")
        sys.exit(1)
    
    title = sys.argv[1]
    category = sys.argv[2]
    content = sys.argv[3]
    tags = sys.argv[4:] if len(sys.argv) > 4 else []
    
    add_knowledge(title, category, content, tags)

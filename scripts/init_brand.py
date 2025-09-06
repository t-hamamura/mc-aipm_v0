#!/usr/bin/env python3
"""ブランド初期化スクリプト"""
import sys
import os
import yaml
from pathlib import Path
from datetime import datetime

def init_brand(brand_name):
    root = Path.cwd()
    brand_dir = root / "brands" / brand_name
    
    # ディレクトリ作成
    for d in ["guidelines", "proposals", "metrics"]:
        (brand_dir / d).mkdir(parents=True, exist_ok=True)
    
    # info.yaml作成
    info = {
        "brand": {
            "name": brand_name,
            "created": datetime.now().strftime("%Y-%m-%d"),
            "status": "active"
        },
        "contacts": [],
        "projects": {
            "active": [],
            "completed": []
        }
    }
    
    with open(brand_dir / "info.yaml", "w", encoding="utf-8") as f:
        yaml.dump(info, f, allow_unicode=True, sort_keys=False)
    
    print(f"✅ ブランド '{brand_name}' を初期化しました")
    print(f"📁 {brand_dir}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python init_brand.py <brand_name>")
        sys.exit(1)
    init_brand(sys.argv[1])

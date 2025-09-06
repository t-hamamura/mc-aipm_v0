#!/bin/bash
#============================================================
# setup_config.sh
# カスタマイズ用設定ファイル
#============================================================

# 自動承認（確認スキップ）
AUTO_APPROVE=false

# 初期ブランド
INITIAL_BRANDS=()
# INITIAL_BRANDS=("BrandA" "BrandB")  # 例

# カスタム設定
ENABLE_BACKUP=true
BACKUP_DIR="_backup"

# デフォルトカテゴリ
DEFAULT_CATEGORIES="strategy,creative,content,analysis,operations"

# テンプレート言語
TEMPLATE_LANG="ja"  # ja/en

# バックアップ設定
BACKUP_INTERVAL="daily"  # daily/weekly/monthly

# 拡張機能
ENABLE_API_INTEGRATION=false
ENABLE_DASHBOARD=false
ENABLE_MOBILE=false
#!/bin/bash
#============================================================
# setup_config.sh
# カスタマイズ用設定ファイル（v2.0改変版）
#============================================================

# 自動承認（確認スキップ）
AUTO_APPROVE=false

# 初期ブランド
INITIAL_BRANDS=()
# INITIAL_BRANDS=("BrandA" "BrandB")  # 例

# 段階的承認システム設定
APPROVAL_FLOW_ENABLED=true
REQUIRED_APPROVALS="planning,completion"  # planning,execution,review,completion
OPTIONAL_APPROVALS="review"

# 動的ルール拡張設定
DYNAMIC_RULES_ENABLED=true
SIMILARITY_THRESHOLD=0.7  # 類似度閾値
AUTO_PROPOSE_RULES=true

# 情報連動システム設定
BRAND_SYNC_ENABLED=true
KNOWLEDGE_SYNC_ENABLED=true
TEMPLATE_SYNC_ENABLED=true

# Notion連携設定
NOTION_EXPORT_ENABLED=true
NOTION_PAGE_FORMAT="markdown"
AUTO_EXPORT_ON_COMPLETION=true

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
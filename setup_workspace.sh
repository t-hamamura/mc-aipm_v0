#!/bin/bash
#============================================================
# setup_workspace.sh
# ─ マーケティング・コンサルティング特化AIPMシステム
#   完全自動セットアップスクリプト
# 
# このスクリプト1つですべての環境を構築します
#============================================================

set -e

# 色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# ログ関数
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[✓]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[!]${NC} $1"; }
log_error() { echo -e "${RED}[✗]${NC} $1"; }
log_section() { echo -e "\n${CYAN}━━━ $1 ━━━${NC}"; }

# プログレスバー
show_progress() {
    local current=$1
    local total=$2
    local width=50
    local percentage=$((current * 100 / total))
    local filled=$((current * width / total))
    
    printf "\rProgress: ["
    printf "%${filled}s" | tr ' ' '='
    printf "%$((width - filled))s" | tr ' ' ']'
    printf "] %3d%%" $percentage
}

# メイン処理
main() {
    clear
    echo "╔════════════════════════════════════════════════════════╗"
    echo "║   マーケティング・コンサルティング特化 AIPMシステム    ║"
    echo "║              自動セットアップスクリプト                 ║"
    echo "╚════════════════════════════════════════════════════════╝"
    echo
    
    # 設定読み込み
    if [ -f "setup_config.sh" ]; then
        source setup_config.sh
        log_info "設定ファイルを読み込みました"
    fi
    
    # 確認
    if [ "${AUTO_APPROVE:-false}" != "true" ]; then
        echo -e "${YELLOW}このスクリプトは以下を実行します:${NC}"
        echo "  • ディレクトリ構造の作成"
        echo "  • ルールファイルの生成"
        echo "  • テンプレートの配置"
        echo "  • スクリプトの生成"
        echo
        read -p "続行しますか？ (y/n): " confirm
        if [[ "$confirm" != [yY] ]]; then
            log_info "キャンセルされました"
            exit 0
        fi
    fi
    
    echo
    TOTAL_STEPS=7
    CURRENT_STEP=0
    
    # Step 1: ディレクトリ構造
    log_section "Step 1/7: ディレクトリ構造の作成"
    create_directory_structure
    ((CURRENT_STEP++))
    show_progress $CURRENT_STEP $TOTAL_STEPS
    
    # Step 2: コアルール
    log_section "Step 2/7: コアルールファイルの生成"
    create_core_rules
    ((CURRENT_STEP++))
    show_progress $CURRENT_STEP $TOTAL_STEPS
    
    # Step 3: マーケティングルール
    log_section "Step 3/7: マーケティングルールの生成"
    create_marketing_rules
    ((CURRENT_STEP++))
    show_progress $CURRENT_STEP $TOTAL_STEPS
    
    # Step 4: テンプレート
    log_section "Step 4/7: テンプレートの配置"
    create_templates
    ((CURRENT_STEP++))
    show_progress $CURRENT_STEP $TOTAL_STEPS
    
    # Step 5: スクリプト
    log_section "Step 5/7: 管理スクリプトの生成"
    create_scripts
    ((CURRENT_STEP++))
    show_progress $CURRENT_STEP $TOTAL_STEPS
    
    # Step 6: 初期ファイル
    log_section "Step 6/7: 初期ファイルの作成"
    create_initial_files
    ((CURRENT_STEP++))
    show_progress $CURRENT_STEP $TOTAL_STEPS
    
    # Step 7: VSCode設定
    log_section "Step 7/7: エディタ設定"
    setup_vscode
    ((CURRENT_STEP++))
    show_progress $CURRENT_STEP $TOTAL_STEPS
    
    echo -e "\n"
    show_completion_message
}

# ディレクトリ構造作成
create_directory_structure() {
    local dirs=(
        "workspace/projects/active"
        "workspace/projects/done"
        "workspace/operations"
        "brands/_template/guidelines"
        "brands/_template/proposals"
        "brands/_template/metrics"
        "knowledge/_index"
        "knowledge/items"
        "knowledge/templates"
        "exports/reports"
        "exports/guidelines"
        "exports/presentations"
        ".cursor/rules/core"
        ".cursor/rules/marketing"
        "scripts"
        "_backup"
    )
    
    for dir in "${dirs[@]}"; do
        mkdir -p "$dir"
        log_success "作成: $dir"
    done
}

# コアルール作成
create_core_rules() {
    # マスタールール
    cat > .cursor/rules/core/00_master_rules.mdc << 'EOF'
---
description: "マーケティング・コンサルティング特化 マスタールール"
---

# マスタールール

## システム概要
マーケティング・コンサルティング業務に特化した管理システムです。

## プロジェクト管理

### 新規プロジェクト
- trigger: ["新規プロジェクト", "プロジェクト開始"]
  action: |
    タイプを選択:
    1. 戦略策定
    2. 制作案件
    3. 分析案件
    4. 継続運用

### ブランド管理
- trigger: ["ブランド追加", "new brand"]
  action: brands/{brand_name}/を初期化

## L1: 戦略
- trigger: ["戦略", "strategy"]
  rule: @marketing/10_strategy.mdc

- trigger: ["価格戦略", "pricing"]
  template: knowledge/templates/pricing.md

## L2: 企画
- trigger: ["キャンペーン", "campaign"]
  rule: @marketing/11_planning.mdc

## L3: 制作
- trigger: ["記事", "SEO記事", "コンテンツ"]
  rule: @marketing/12_creative.mdc

## L4: 実行
- trigger: ["広告運用", "ads"]
  rule: @marketing/13_execution.mdc

## L5: 分析
- trigger: ["効果測定", "分析"]
  rule: @marketing/14_analytics.mdc

## L6: ナレッジ
- trigger: ["ナレッジ追加", "knowledge"]
  rule: @marketing/15_knowledge.mdc
EOF
    
    # パス定義
    cat > .cursor/rules/core/paths.mdc << 'EOF'
---
description: "システムパス定義"
---

# パス定義

project_root: "."

workspace:
  projects_active: "{{project_root}}/workspace/projects/active"
  projects_done: "{{project_root}}/workspace/projects/done"
  operations: "{{project_root}}/workspace/operations"

brands:
  root: "{{project_root}}/brands"
  template: "{{project_root}}/brands/_template"

knowledge:
  root: "{{project_root}}/knowledge"
  templates: "{{project_root}}/knowledge/templates"

exports:
  root: "{{project_root}}/exports"
EOF
    
    log_success "コアルール生成完了"
}

# マーケティングルール作成
create_marketing_rules() {
    # L1: 戦略
    cat > .cursor/rules/marketing/10_strategy.mdc << 'EOF'
---
description: "戦略レイヤー"
---

# L1: 戦略レイヤー

## ブランド戦略
questions:
  - ブランド名は？
  - ターゲット市場は？
  - 競合優位性は？
  - ビジョンは？

template: |
  # {{brand_name}} ブランド戦略
  
  ## ビジョン
  {{vision}}
  
  ## ターゲット
  {{target}}
  
  ## ポジショニング
  {{positioning}}
EOF

    # L2: 企画
    cat > .cursor/rules/marketing/11_planning.mdc << 'EOF'
---
description: "企画レイヤー"
---

# L2: 企画レイヤー

## キャンペーン企画
questions:
  - キャンペーン名は？
  - 目的は？
  - 予算は？
  - 期間は？

template: |
  # {{campaign_name}}
  
  ## 目的
  {{purpose}}
  
  ## 予算
  {{budget}}
  
  ## スケジュール
  {{schedule}}
EOF

    # L3: 制作
    cat > .cursor/rules/marketing/12_creative.mdc << 'EOF'
---
description: "制作レイヤー"
---

# L3: 制作レイヤー

## コンテンツ制作
questions:
  - コンテンツタイプは？
  - ターゲットは？
  - キーワードは？

template: |
  # {{title}}
  
  ## 概要
  {{summary}}
  
  ## 本文
  {{content}}
EOF

    # L4: 実行
    cat > .cursor/rules/marketing/13_execution.mdc << 'EOF'
---
description: "実行レイヤー"
---

# L4: 実行レイヤー

## 施策実行
questions:
  - 実行内容は？
  - チャネルは？
  - スケジュールは？

template: |
  # 実行計画
  
  ## 内容
  {{content}}
  
  ## チャネル
  {{channels}}
  
  ## タイムライン
  {{timeline}}
EOF

    # L5: 分析
    cat > .cursor/rules/marketing/14_analytics.mdc << 'EOF'
---
description: "分析レイヤー"
---

# L5: 分析レイヤー

## 効果測定
questions:
  - 測定対象は？
  - KPIは？
  - 期間は？

template: |
  # 分析レポート
  
  ## 結果
  {{results}}
  
  ## インサイト
  {{insights}}
  
  ## 改善提案
  {{recommendations}}
EOF

    # L6: ナレッジ
    cat > .cursor/rules/marketing/15_knowledge.mdc << 'EOF'
---
description: "ナレッジレイヤー"
---

# L6: ナレッジレイヤー

## ナレッジ登録
questions:
  - タイトルは？
  - カテゴリは？
  - タグは？
  - 内容は？

template: |
  # {{title}}
  
  **カテゴリ**: {{category}}
  **タグ**: {{tags}}
  
  ## 内容
  {{content}}
  
  ## 活用方法
  {{usage}}
EOF
    
    log_success "マーケティングルール生成完了"
}

# テンプレート作成
create_templates() {
    # 記事テンプレート
    cat > knowledge/templates/article.md << 'EOF'
# {{title}}

## 概要
{{summary}}

## 本文
{{content}}

## まとめ
{{conclusion}}

---
*作成日: {{date}}*
*ブランド: {{brand}}*
EOF

    # 戦略テンプレート
    cat > knowledge/templates/strategy.md << 'EOF'
# {{brand_name}} 戦略ドキュメント

## エグゼクティブサマリー
{{executive_summary}}

## 市場分析
{{market_analysis}}

## 競合分析
{{competitive_analysis}}

## 戦略提言
{{recommendations}}

## 実行計画
{{execution_plan}}
EOF

    # レポートテンプレート
    cat > knowledge/templates/report.md << 'EOF'
# {{title}}

## 期間
{{period}}

## サマリー
{{summary}}

## 詳細データ
{{data}}

## 分析
{{analysis}}

## 次のアクション
{{next_actions}}
EOF
    
    log_success "テンプレート配置完了"
}

# スクリプト作成
create_scripts() {
    # ブランド初期化スクリプト
    cat > scripts/init_brand.py << 'EOF'
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
EOF

    # ナレッジ管理スクリプト
    cat > scripts/manage_knowledge.py << 'EOF'
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
EOF
    
    chmod +x scripts/*.py 2>/dev/null || true
    log_success "スクリプト生成完了"
}

# 初期ファイル作成
create_initial_files() {
    # ブランドテンプレート
    cat > brands/_template/info.yaml << 'EOF'
brand:
  name: "{{brand_name}}"
  created: "{{date}}"
  status: "active"
contacts: []
projects:
  active: []
  completed: []
kpis: {}
notes: ""
EOF
    
    # ナレッジインデックス
    cat > knowledge/_index.yaml << 'EOF'
items: []
categories: [strategy, creative, content, analysis, operations]
tags: []
EOF
    
    # .gitkeepファイル
    touch workspace/projects/active/.gitkeep
    touch workspace/projects/done/.gitkeep
    touch workspace/operations/.gitkeep
    touch exports/reports/.gitkeep
    touch exports/guidelines/.gitkeep
    touch exports/presentations/.gitkeep
    
    log_success "初期ファイル作成完了"
}

# VSCode設定
setup_vscode() {
    mkdir -p .vscode
    cat > .vscode/settings.json << 'EOF'
{
  "files.exclude": {
    "**/.git": true,
    "_backup": true,
    "**/.gitkeep": true
  },
  "search.exclude": {
    "_backup/**": true,
    "workspace/projects/done/**": true
  },
  "editor.wordWrap": "on",
  "markdown.preview.breaks": true
}
EOF
    
    log_success "エディタ設定完了"
}

# 完了メッセージ
show_completion_message() {
    echo
    echo "╔════════════════════════════════════════════════════════╗"
    echo "║                  セットアップ完了！                     ║"
    echo "╚════════════════════════════════════════════════════════╝"
    echo
    echo "✅ すべての環境構築が完了しました"
    echo
    echo "📁 作成された構造:"
    echo "  • workspace/   - 作業領域"
    echo "  • brands/      - ブランド管理"
    echo "  • knowledge/   - ナレッジベース"
    echo "  • exports/     - 共有用出力"
    echo
    echo "🚀 使い方:"
    echo "  1. Cursorのチャットで「新規プロジェクト」"
    echo "  2. 「戦略」「記事」「分析」など入力"
    echo "  3. 「ナレッジ追加」で知見を保存"
    echo
    echo "📖 詳細はREADME.mdをご覧ください"
}

# 実行
main "$@"
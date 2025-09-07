#!/bin/bash
#============================================================
# setup_workspace.sh
# ─ マーケティング・コンサルティング特化AIPMシステム v2.0
#   完全自動セットアップスクリプト（改変版）
# 
# このスクリプト1つですべての環境を構築します
# 情報連動型アーキテクチャ・段階的承認システム・動的ルール拡張システム対応
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
    echo "║                    v2.0 改変版                        ║"
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
        echo "  • 改変版ディレクトリ構造の作成"
        echo "  • 動的ルール拡張システムの構築"
        echo "  • 段階的承認フローの設定"
        echo "  • 情報連動システムの初期化"
        echo "  • Notion連携機能の準備"
        echo
        read -p "続行しますか？ (y/n): " confirm
        if [[ "$confirm" != [yY] ]]; then
            log_info "キャンセルされました"
            exit 0
        fi
    fi
    
    echo
    TOTAL_STEPS=8
    CURRENT_STEP=0
    
    # Step 1: 改変版ディレクトリ構造
    log_section "Step 1/8: 改変版ディレクトリ構造の作成"
    create_directory_structure
    ((CURRENT_STEP++))
    show_progress $CURRENT_STEP $TOTAL_STEPS
    
    # Step 2: 基本ルール
    log_section "Step 2/8: 基本ルールファイルの生成"
    create_basic_rules
    ((CURRENT_STEP++))
    show_progress $CURRENT_STEP $TOTAL_STEPS
    
    # Step 3: マーケティングルール
    log_section "Step 3/8: マーケティングルールの生成"
    create_marketing_rules
    ((CURRENT_STEP++))
    show_progress $CURRENT_STEP $TOTAL_STEPS
    
    # Step 4: ワークフロールール
    log_section "Step 4/8: ワークフロールールの生成"
    create_workflow_rules
    ((CURRENT_STEP++))
    show_progress $CURRENT_STEP $TOTAL_STEPS
    
    # Step 5: システムテンプレート
    log_section "Step 5/8: システムテンプレートの配置"
    create_system_templates
    ((CURRENT_STEP++))
    show_progress $CURRENT_STEP $TOTAL_STEPS
    
    # Step 6: 管理スクリプト
    log_section "Step 6/8: 管理スクリプトの生成"
    create_scripts
    ((CURRENT_STEP++))
    show_progress $CURRENT_STEP $TOTAL_STEPS
    
    # Step 7: 初期ファイル
    log_section "Step 7/8: 初期ファイルの作成"
    create_initial_files
    ((CURRENT_STEP++))
    show_progress $CURRENT_STEP $TOTAL_STEPS
    
    # Step 8: エディタ設定
    log_section "Step 8/8: エディタ設定"
    setup_vscode
    ((CURRENT_STEP++))
    show_progress $CURRENT_STEP $TOTAL_STEPS
    
    echo -e "\n"
    show_completion_message
}

# 改変版ディレクトリ構造作成
create_directory_structure() {
    local dirs=(
        # .cursor/rules/ 構造
        ".cursor/rules/basic"
        ".cursor/rules/marketing"
        ".cursor/rules/workflows"
        
        # .system/ 構造
        ".system/templates"
        ".system/config"
        
        # brands/ 構造（連動型）
        "brands/_template/knowledge"
        "brands/_template/projects"
        
        # projects/ 構造（統一）
        "projects"
        
        # knowledge/ 構造
        "knowledge/items"
        "knowledge/templates"
        
        # exports/ 構造
        "exports/notion/pages"
        "exports/documents/reports"
        "exports/documents/guidelines"
        "exports/documents/presentations"
        
        # scripts/ 構造
        "scripts"
        
        # backup
        "_backup"
    )
    
    for dir in "${dirs[@]}"; do
        mkdir -p "$dir"
        log_success "作成: $dir"
    done
}

# 基本ルール作成
create_basic_rules() {
    # マスタールール
    cat > .cursor/rules/basic/00_master_rules.mdc << 'EOF'
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
    cat > .cursor/rules/basic/01_paths.mdc << 'EOF'
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
    
    # 段階的承認フロー
    cat > .cursor/rules/basic/02_approval_flow.mdc << 'EOF'
---
description: "段階的承認フロー定義"
---

# 段階的承認フロー

## 基本フロー
1. 作業開始 → 計画提案
2. 計画承認 → 実行開始
3. 中間レビュー → 改善提案
4. 完了承認 → 情報連動

## 承認タイプ
- required: 必須承認
- optional: 任意承認
- auto: 自動進行

## ユーザー確認
- 各段階で必ず確認を取る
- 承認なしでは次段階に進まない
- 承認後は自動で次段階実行
EOF

    # 動的ルール拡張
    cat > .cursor/rules/basic/03_dynamic_rules.mdc << 'EOF'
---
description: "動的ルール拡張システム"
---

# 動的ルール拡張システム

## 類似度ベース判定
1. 未知のトリガーワード検出
2. 既存ルールとの類似度計算
3. 類似度が低い場合、新ルール提案
4. ユーザー承認後にルール追加

## 提案フォーマット
- 類似ルールの提示
- 新ルールの内容説明
- カテゴリ分類の提案
- 承認/拒否の選択肢
EOF
    
    log_success "基本ルール生成完了"
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

# ワークフロールール作成
create_workflow_rules() {
    # プロジェクトフロー
    cat > .cursor/rules/workflows/20_project_flow.mdc << 'EOF'
---
description: "統一プロジェクトフロー"
---

# 統一プロジェクトフロー

## プロジェクト構造
projects/{date}_{type}_{name}/
├── 01_planning/     # 計画段階
├── 02_execution/    # 実行段階
├── 03_review/       # レビュー段階
└── 04_completion/   # 完了段階

## 段階別処理
1. planning: 計画策定・承認
2. execution: 実行・進捗管理
3. review: レビュー・改善
4. completion: 完了・情報連動
EOF

    # ブランド情報更新
    cat > .cursor/rules/workflows/21_brand_update.mdc << 'EOF'
---
description: "ブランド情報自動更新"
---

# ブランド情報自動更新

## 更新タイミング
- プロジェクト完了時
- 調査結果取得時
- ナレッジ追加時

## 更新対象
- profile.yaml
- knowledge/
- projects/

## 連動処理
1. プロジェクト情報抽出
2. ブランド情報更新
3. ナレッジ統合
4. 履歴記録
EOF

    # Notion出力
    cat > .cursor/rules/workflows/22_notion_export.mdc << 'EOF'
---
description: "Notion連携出力"
---

# Notion連携出力

## 出力形式
- ページ形式
- マークダウン準拠
- 構造化データ

## 出力タイミング
- ドキュメント作成時
- プロジェクト完了時
- 定期レポート時

## 出力先
exports/notion/pages/
EOF
    
    log_success "ワークフロールール生成完了"
}

# システムテンプレート作成
create_system_templates() {
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
    
    # システムテンプレート
    cat > .system/templates/project_structure.md << 'EOF'
# プロジェクト構造テンプレート

## 基本構造
```
{date}_{type}_{name}/
├── 01_planning/
│   ├── brief.md
│   ├── timeline.md
│   └── resources.md
├── 02_execution/
│   ├── progress.md
│   ├── deliverables/
│   └── notes.md
├── 03_review/
│   ├── review_notes.md
│   ├── feedback.md
│   └── improvements.md
└── 04_completion/
    ├── final_report.md
    ├── lessons_learned.md
    └── next_steps.md
```

## メタデータ
- プロジェクト名
- ブランド
- 開始日
- 完了日
- ステータス
- 担当者
EOF

    # Notion出力テンプレート
    cat > .system/templates/notion_page.md << 'EOF'
# {{title}}

**作成日**: {{date}}
**ブランド**: {{brand}}
**カテゴリ**: {{category}}

## 概要
{{summary}}

## 詳細
{{content}}

## 関連情報
- プロジェクト: {{project_link}}
- ナレッジ: {{knowledge_link}}

---
*このページは自動生成されました*
EOF
    
    log_success "システムテンプレート配置完了"
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

    # ブランド情報同期スクリプト
    cat > scripts/sync_brand_info.py << 'EOF'
#!/usr/bin/env python3
"""ブランド情報同期スクリプト"""
import sys
import os
import yaml
from pathlib import Path
from datetime import datetime

def sync_brand_info(brand_name, project_path):
    root = Path.cwd()
    brand_dir = root / "brands" / brand_name
    project_dir = Path(project_path)
    
    # プロジェクト情報読み込み
    if not project_dir.exists():
        print(f"❌ プロジェクトディレクトリが見つかりません: {project_path}")
        return
    
    # ブランド情報更新
    profile_file = brand_dir / "profile.yaml"
    if profile_file.exists():
        with open(profile_file, "r", encoding="utf-8") as f:
            profile = yaml.safe_load(f) or {}
    else:
        profile = {"brand": {"name": brand_name}}
    
    # プロジェクト履歴追加
    if "projects" not in profile:
        profile["projects"] = []
    
    project_info = {
        "name": project_dir.name,
        "path": str(project_dir.relative_to(root)),
        "completed": datetime.now().strftime("%Y-%m-%d")
    }
    profile["projects"].append(project_info)
    
    # 保存
    with open(profile_file, "w", encoding="utf-8") as f:
        yaml.dump(profile, f, allow_unicode=True, sort_keys=False)
    
    print(f"✅ ブランド '{brand_name}' の情報を更新しました")

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python sync_brand_info.py <brand_name> <project_path>")
        sys.exit(1)
    sync_brand_info(sys.argv[1], sys.argv[2])
EOF

    # Notion出力スクリプト
    cat > scripts/export_to_notion.py << 'EOF'
#!/usr/bin/env python3
"""Notion出力スクリプト"""
import sys
import os
from pathlib import Path
from datetime import datetime

def export_to_notion(source_file, title, brand, category):
    root = Path.cwd()
    notion_dir = root / "exports" / "notion" / "pages"
    
    # 出力ファイル名生成
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    filename = f"{timestamp}_{title.replace(' ', '_').lower()}.md"
    output_path = notion_dir / filename
    
    # ソースファイル読み込み
    with open(source_file, "r", encoding="utf-8") as f:
        content = f.read()
    
    # Notion用フォーマット
    notion_content = f"""# {title}

**作成日**: {datetime.now().strftime('%Y-%m-%d')}
**ブランド**: {brand}
**カテゴリ**: {category}

{content}

---
*このページは自動生成されました*
"""
    
    # 出力
    with open(output_path, "w", encoding="utf-8") as f:
        f.write(notion_content)
    
    print(f"✅ Notion用ページを作成しました: {output_path}")

if __name__ == "__main__":
    if len(sys.argv) < 5:
        print("Usage: python export_to_notion.py <source_file> <title> <brand> <category>")
        sys.exit(1)
    export_to_notion(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4])
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
    cat > brands/_template/profile.yaml << 'EOF'
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
    touch exports/notion/pages/.gitkeep
    touch exports/documents/reports/.gitkeep
    touch exports/documents/guidelines/.gitkeep
    touch exports/documents/presentations/.gitkeep
    touch brands/_template/knowledge/.gitkeep
    touch brands/_template/projects/.gitkeep
    
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
    echo "  • .cursor/rules/ - 動的ルールシステム"
    echo "  • .system/       - システム管理"
    echo "  • brands/        - ブランド管理（連動型）"
    echo "  • projects/      - 統一プロジェクト構造"
    echo "  • knowledge/     - グローバルナレッジ"
    echo "  • exports/       - 出力管理（Notion連携）"
    echo
    echo "🚀 使い方:"
    echo "  1. Cursorのチャットで「新規プロジェクト」"
    echo "  2. 段階的承認フローで確認を取りながら進行"
    echo "  3. プロジェクト完了時に自動でブランド情報更新"
    echo "  4. Notion出力でドキュメント共有"
    echo
    echo "📖 詳細はREADME.mdをご覧ください"
}

# 実行
main "$@"
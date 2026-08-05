#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
blueprint_root="$(cd -- "${script_dir}/.." && pwd)"
workspace_root="${WORKSPACE_ROOT:-$(cd -- "${blueprint_root}/../.." && pwd)}"
destination="${blueprint_root}/workspace"

if ! command -v rsync >/dev/null 2>&1; then
  echo "rsync is required for workspace sync" >&2
  exit 1
fi

if [ ! -d "${workspace_root}" ]; then
  echo "workspace root does not exist: ${workspace_root}" >&2
  exit 1
fi

mkdir -p "${destination}"

rsync -a --delete \
  --exclude '/repos/' \
  --exclude '/projects/' \
  --exclude '/gogetajob-data/' \
  --exclude '/finance/' \
  --exclude '/invest/' \
  --exclude '/.venvs/' \
  --exclude '/memory/.dreams/' \
  --exclude '/tmp/' \
  --exclude '/.openclaw/' \
  --exclude '/.git/' \
  --exclude '/.env' \
  --exclude '*.log' \
  --exclude '*.pid' \
  --exclude '/*.sqlite' \
  --exclude '/*.sqlite-*' \
  "${workspace_root}/" "${destination}/"

python3 - "${destination}" <<'PY'
from pathlib import Path
import re
import sys

root = Path(sys.argv[1])
memory_dir = root / "memory"

private_section_heading = re.compile(
    r"^## .*?(zhaoyi|603986|daily[- ]prediction|private[- ]excluded[- ]cron|investment prediction)",
    re.IGNORECASE,
)
private_detail = re.compile(
    r"("
    r"zhaoyi|603986|#invest|stock_model|gd_model|eastmoney|fund-flow|"
    r"premarket/day prediction|daily prediction job|Chinese Discord|"
    r"private finance/investment|finance/investment|finance backtest|private investment prediction|"
    r"Sent conclusion:|Context used:|ATR risk|VWAP|rule_score|defensive/high-volatility|"
    r"semiconductor context|delayed/EOD|半导体ETF|科创50|创业板|上证|投资建议|"
    r"NVDA|AMD|SMH|SOXX|\^SOX"
    r")",
    re.IGNORECASE,
)
private_reference = re.compile(
    r"(?:its |the |and private |plus the private |plus private |plus )?(?:[0-9]{1,2}:[0-9]{2} )?(?:private )?(?:Zhaoyi Innovation|finance/investment|investment prediction|investment)(?: daily prediction| cron)? note",
    re.IGNORECASE,
)

if memory_dir.is_dir():
    for path in sorted(memory_dir.glob("*.md")):
        lines = path.read_text(encoding="utf-8").splitlines(keepends=True)
        output = []
        skip_private_section = False
        inserted_placeholder = False

        for line in lines:
            if line.startswith("## "):
                skip_private_section = bool(private_section_heading.search(line))
                inserted_placeholder = False
                if skip_private_section:
                    if not output or output[-1].strip():
                        output.append("\n")
                    output.append("## Private Excluded Cron\n")
                    output.append("\n")
                    output.append("- Private cron activity existed in local memory but is intentionally omitted from the public blueprint snapshot.\n")
                    output.append("\n")
                    inserted_placeholder = True
                    continue

            if skip_private_section:
                if line.startswith("## "):
                    skip_private_section = False
                else:
                    continue

            if private_reference.search(line):
                line = private_reference.sub("a private excluded cron note", line)
                line = line.replace("private a private excluded cron note", "a private excluded cron note")
                line = line.replace("private/a private excluded cron note", "a private excluded cron note")
                line = line.replace("a a private excluded cron note", "a private excluded cron note")

            if private_detail.search(line):
                if line.startswith("- "):
                    line = "- Private excluded cron activity was reviewed locally but is intentionally not published in the blueprint snapshot.\n"
                elif not line.startswith("## Private Excluded Cron"):
                    continue

            if inserted_placeholder and line.startswith("## "):
                inserted_placeholder = False

            output.append(line)

        collapsed = []
        for line in output:
            if (
                line == "- Private excluded cron activity was reviewed locally but is intentionally not published in the blueprint snapshot.\n"
                and collapsed
                and collapsed[-1] == line
            ):
                continue
            collapsed.append(line)

        path.write_text("".join(collapsed), encoding="utf-8")
PY

echo "Synced ${workspace_root} -> ${destination}"

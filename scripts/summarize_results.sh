
#!/usr/bin/env bash
# MIT License © 2025 Motohiro Suzuki
#
# Stage177: summarize_results.sh
# Collect results from downloaded artifacts and produce a single Markdown summary.
#
# Inputs:
#   --artifacts-dir <path>   (required) directory where actions/download-artifact placed artifacts
#   --out <path>             (required) output summary.md path
#
# Expected layout (from workflow):
#   _ci_artifacts/
#     ci-attack-01/
#       meta.txt
#       exit_code.txt
#       result.txt
#       stdout.txt
#       stderr.txt
#     ci-attack-02/
#     ...
#
# Behavior:
#   - Writes summary.md
#   - Exits non-zero if any case FAIL (fail-closed)

set -euo pipefail

ARTIFACTS_DIR=""
OUT_PATH=""

usage() {
  cat <<'EOF'
Usage:
  scripts/summarize_results.sh --artifacts-dir <dir> --out <out_md>

Example:
  ./scripts/summarize_results.sh --artifacts-dir _ci_artifacts --out out/reports/summary.md
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --artifacts-dir)
      ARTIFACTS_DIR="${2:-}"
      shift 2
      ;;
    --out)
      OUT_PATH="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "[ERROR] Unknown arg: $1" >&2
      usage
      exit 2
      ;;
  esac
done

if [[ -z "${ARTIFACTS_DIR}" || -z "${OUT_PATH}" ]]; then
  echo "[ERROR] --artifacts-dir and --out are required" >&2
  usage
  exit 2
fi

if [[ ! -d "${ARTIFACTS_DIR}" ]]; then
  echo "[ERROR] artifacts dir not found: ${ARTIFACTS_DIR}" >&2
  exit 2
fi

mkdir -p "$(dirname "${OUT_PATH}")"

# Collect cases in a stable order (human-friendly).
ORDERED_CASES=(
  "attack-01"
  "attack-02"
  "attack-03"
  "attack-04"
  "attack-05"
  "attack-06"
  "demo"
)

# Helper to read a file safely
read_file() {
  local p="$1"
  if [[ -f "$p" ]]; then
    cat "$p"
  else
    echo ""
  fi
}

# Compute commit hash from any meta.txt if possible
COMMIT_SHA=""
for c in "${ORDERED_CASES[@]}"; do
  d="${ARTIFACTS_DIR}/ci-${c}"
  if [[ -f "${d}/meta.txt" ]]; then
    COMMIT_SHA="$(grep -E '^commit=' "${d}/meta.txt" | head -n1 | cut -d= -f2- || true)"
    if [[ -n "${COMMIT_SHA}" ]]; then
      break
    fi
  fi
done

DATE_UTC="$(date -u '+%Y-%m-%d %H:%M:%S UTC')"

# Build table and detect failures
any_fail=0

{
  echo "# QSP Attack Matrix Summary"
  echo ""
  echo "- Commit: \`${COMMIT_SHA:-unknown}\`"
  echo "- Generated: \`${DATE_UTC}\`"
  echo ""
  echo "| Case | Result | Exit | Notes |"
  echo "|------|--------|------|-------|"

  for c in "${ORDERED_CASES[@]}"; do
    d="${ARTIFACTS_DIR}/ci-${c}"

    result="$(read_file "${d}/result.txt")"
    exit_code="$(read_file "${d}/exit_code.txt")"

    # Normalize
    result="$(echo "${result}" | tr -d '\r\n' | tr '[:lower:]' '[:upper:]')"
    exit_code="$(echo "${exit_code}" | tr -d '\r\n')"

    if [[ -z "${result}" ]]; then
      result="MISSING"
      exit_code="${exit_code:-?}"
      any_fail=1
    fi

    if [[ "${result}" == "FAIL" ]]; then
      any_fail=1
    fi

    # Notes: include first line of stderr if fail, else keep short.
    notes=""
    if [[ "${result}" == "FAIL" ]]; then
      first_err="$(read_file "${d}/stderr.txt" | head -n 1 | tr -d '\r')"
      if [[ -n "${first_err}" ]]; then
        # Escape pipes to avoid breaking markdown table
        first_err="${first_err//|/\\|}"
        notes="${first_err}"
      else
        notes="(see stderr.txt)"
      fi
    elif [[ "${result}" == "PASS" ]]; then
      notes="OK"
    else
      notes="(artifact missing or incomplete)"
    fi

    echo "| ${c} | ${result} | ${exit_code:-?} | ${notes} |"
  done

  echo ""
  echo "## Evidence artifacts"
  echo ""
  echo "- Per-case logs are stored as CI artifacts: \`ci-attack-01\` ... \`ci-demo\`"
  echo "- This summary is stored as: \`attack-summary\`"
  echo ""
  echo "## How to reproduce locally"
  echo ""
  echo '```bash'
  echo 'docker compose -f docker/docker-compose.yml run --rm --build qsp attack-01'
  echo 'docker compose -f docker/docker-compose.yml run --rm --build qsp attack-02'
  echo 'docker compose -f docker/docker-compose.yml run --rm --build qsp attack-03'
  echo 'docker compose -f docker/docker-compose.yml run --rm --build qsp attack-04'
  echo 'docker compose -f docker/docker-compose.yml run --rm --build qsp attack-05'
  echo 'docker compose -f docker/docker-compose.yml run --rm --build qsp attack-06'
  echo 'docker compose -f docker/docker-compose.yml run --rm --build qsp demo'
  echo '```'
} > "${OUT_PATH}"

echo "[OK] wrote ${OUT_PATH}"

if [[ "${any_fail}" -ne 0 ]]; then
  echo "[FAIL] at least one case failed (or artifacts missing). Failing CI (fail-closed)." >&2
  exit 1
fi

echo "[OK] all cases PASS"
exit 0

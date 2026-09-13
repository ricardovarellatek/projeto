#!/usr/bin/env bash
# Roda uma única auditoria de performance (Lighthouse) contra o site servido
# localmente e salva o relatório em perf-reports/.
#
# Uso:
#   bash scripts/perf-audit.sh [label]
#
# Variáveis de ambiente:
#   PERF_PORT      porta do servidor estático local (padrão: 5050)
#   PERF_THRESHOLD score mínimo de performance (0-100) para sair com sucesso (padrão: 90)
#   CHROME_PATH    caminho do binário do Chrome/Chromium, se não for detectado automaticamente
#
# Saída (stdout), uma linha por chave, para ser lida por outros scripts:
#   REPORT_JSON=perf-reports/report-<label>.report.json
#   REPORT_HTML=perf-reports/report-<label>.report.html
#   SCORE=<0-100>
#
# Código de saída: 0 se SCORE >= PERF_THRESHOLD, 1 caso contrário.

set -euo pipefail

LABEL="${1:-manual}"
PORT="${PERF_PORT:-5050}"
THRESHOLD="${PERF_THRESHOLD:-90}"
REPORT_DIR="perf-reports"
URL="http://localhost:${PORT}/index.html"

cd "$(dirname "${BASH_SOURCE[0]}")/.."
mkdir -p "$REPORT_DIR"

SERVER_PID=""
cleanup() {
  if [[ -n "$SERVER_PID" ]]; then
    kill "$SERVER_PID" 2>/dev/null || true
    wait "$SERVER_PID" 2>/dev/null || true
  fi
}
trap cleanup EXIT

npx --yes serve -l "$PORT" . >/dev/null 2>&1 &
SERVER_PID=$!

for _ in $(seq 1 20); do
  if curl -sf "$URL" >/dev/null 2>&1; then
    break
  fi
  sleep 0.5
done

REPORT_BASE="${REPORT_DIR}/report-${LABEL}"

npx --yes lighthouse "$URL" \
  --output=json --output=html \
  --output-path="$REPORT_BASE" \
  --chrome-flags="--headless=new --no-sandbox" \
  --only-categories=performance \
  --quiet

REPORT_JSON="${REPORT_BASE}.report.json"
REPORT_HTML="${REPORT_BASE}.report.html"

SCORE=$(node -e "console.log(Math.round(require(process.argv[1]).categories.performance.score * 100))" "$PWD/$REPORT_JSON")

echo "REPORT_JSON=${REPORT_JSON}"
echo "REPORT_HTML=${REPORT_HTML}"
echo "SCORE=${SCORE}"

if [[ "$SCORE" -ge "$THRESHOLD" ]]; then
  exit 0
else
  exit 1
fi

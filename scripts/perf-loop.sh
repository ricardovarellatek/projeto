#!/usr/bin/env bash
# Loop de performance no estilo "Ralph Wiggum": audita com Lighthouse,
# passa as oportunidades encontradas para o Claude Code corrigir, faz commit
# do resultado, e repete até atingir o threshold ou o limite de iterações.
#
# Uso:
#   bash scripts/perf-loop.sh
#
# Variáveis de ambiente:
#   PERF_THRESHOLD       score mínimo de performance para parar com sucesso (padrão: 90)
#   PERF_MAX_ITERATIONS  número máximo de iterações (padrão: 5)
#   CLAUDE_FLAGS         flags extras passadas para o `claude` a cada iteração
#                        (ex.: "--permission-mode acceptEdits" para rodar sem
#                        precisar aprovar cada edição manualmente)
#
# Cada iteração que resultar em mudanças gera um commit git separado, então
# dá pra acompanhar/reverter iteração por iteração com `git log` / `git revert`.

set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."

THRESHOLD="${PERF_THRESHOLD:-90}"
MAX_ITER="${PERF_MAX_ITERATIONS:-5}"
CLAUDE_FLAGS="${CLAUDE_FLAGS:-}"

if [[ -n "$(git status --porcelain)" ]]; then
  echo "Working tree tem mudanças não commitadas. Commit ou stash antes de rodar o loop." >&2
  exit 1
fi

for i in $(seq 1 "$MAX_ITER"); do
  echo ""
  echo "== Loop de performance — iteração ${i}/${MAX_ITER} =="

  set +e
  AUDIT_OUTPUT="$(PERF_THRESHOLD="$THRESHOLD" bash scripts/perf-audit.sh "iter-${i}")"
  AUDIT_STATUS=$?
  set -e

  echo "$AUDIT_OUTPUT"
  REPORT_JSON="$(echo "$AUDIT_OUTPUT" | sed -n 's/^REPORT_JSON=//p')"
  SCORE="$(echo "$AUDIT_OUTPUT" | sed -n 's/^SCORE=//p')"

  if [[ "$AUDIT_STATUS" -eq 0 ]]; then
    echo "Meta atingida: score ${SCORE} >= ${THRESHOLD}. Parando o loop."
    exit 0
  fi

  echo "Score ${SCORE} abaixo do threshold (${THRESHOLD}). Preparando o prompt para o agente..."

  PROMPT_FILE="$(mktemp)"
  cat PROMPT.md > "$PROMPT_FILE"
  node scripts/extract-opportunities.mjs "$REPORT_JSON" >> "$PROMPT_FILE"

  echo "Rodando o Claude Code para tentar corrigir..."
  claude -p "$(cat "$PROMPT_FILE")" $CLAUDE_FLAGS
  rm -f "$PROMPT_FILE"

  if git status --porcelain -- . ':!perf-reports' | grep -q .; then
    git add -A -- . ':!perf-reports'
    git commit -m "perf loop: iteração ${i} (score anterior ${SCORE}/100)"
  else
    echo "O agente não fez nenhuma mudança nesta iteração. Parando para evitar loop sem progresso."
    exit 1
  fi
done

echo ""
echo "Limite de ${MAX_ITER} iterações atingido sem alcançar o threshold de ${THRESHOLD}."
exit 1

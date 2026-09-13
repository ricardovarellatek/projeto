#!/usr/bin/env node
// Lê um relatório JSON do Lighthouse e imprime, em Markdown, os audits que
// realmente pesam no score de performance e estão abaixo de 0.9 — ou seja,
// as oportunidades de melhoria mais relevantes, ordenadas por impacto.
//
// Uso: node scripts/extract-opportunities.mjs <caminho-do-report.json>

import { readFileSync } from "node:fs";

const [, , reportPath] = process.argv;

if (!reportPath) {
  console.error("Uso: node scripts/extract-opportunities.mjs <report.json>");
  process.exit(1);
}

const report = JSON.parse(readFileSync(reportPath, "utf8"));
const perf = report.categories.performance;
const audits = report.audits;

const opportunities = perf.auditRefs
  .filter((ref) => ref.weight > 0)
  .map((ref) => audits[ref.id])
  .filter((audit) => audit && audit.score !== null && audit.score < 0.9)
  .sort((a, b) => a.score - b.score);

console.log(`Score de performance atual: ${Math.round(perf.score * 100)}/100`);
console.log("");

if (opportunities.length === 0) {
  console.log(
    "Nenhum audit com peso no score de performance está abaixo de 0.9. " +
      "Se o score ainda estiver baixo, o gargalo pode estar em métricas de " +
      "campo (variação de rede) — considere rodar a auditoria de novo.",
  );
  process.exit(0);
}

console.log("## Principais oportunidades (ordenadas por impacto no score)\n");

for (const audit of opportunities.slice(0, 8)) {
  const savings = audit.displayValue ? ` — ${audit.displayValue}` : "";
  console.log(`### ${audit.title} (score ${audit.score})${savings}`);
  if (audit.description) {
    console.log(audit.description.replace(/\[([^\]]+)\]\([^)]+\)/g, "$1").trim());
  }
  console.log("");
}

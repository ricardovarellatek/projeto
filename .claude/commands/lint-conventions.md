---
description: Verifica o código do DevLinks contra as convenções do projeto (Prettier, padrões de HTML/CSS observados) e reporta violações; use "--fix" para aplicar correções simples
argument-hint: [arquivo opcional] [--fix]
allowed-tools: Read, Grep, Glob, Edit, Bash(git diff:*)
---

O projeto não tem ESLint/Stylelint configurado, mas tem convenções definidas
em `.vscode/settings.json` (Prettier) e padrões consistentes no código
existente. Alvo: `$ARGUMENTS` (arquivo específico) ou todo o projeto
(`index.html`, `style.css`, `script.js`) se nada for informado.

Convenções a verificar:

1. **Formatação (Prettier)** — indentação de 2 espaços, sem ponto e vírgula
   em JS, aspas duplas (`prettier.singleQuote: false`).
2. **CSS custom properties** — toda variável nova declarada em `:root` deve
   ter um par correspondente redefinido em `.light` (e vice-versa); não usar
   cor/tamanho fixo onde já existe uma variável de tema equivalente.
3. **HTML** — atributos em minúsculas, todo `<img>` com `alt` descritivo,
   sem `href="#"` fora de protótipo, links externos com `target="_blank"`
   quando abrem em nova aba (seguir o padrão já usado em `#social-links`).
4. **Sem código morto** — sem blocos de código comentados deixados no
   arquivo (ex.: comentários de tentativa anterior), sem estilos de debug
   esquecidos (ex.: bordas coloridas usadas só para visualizar um elemento
   durante o desenvolvimento).
5. **Sem estilos inline** — estilização deve ficar em `style.css`, não em
   atributos `style=""` no HTML.

Para cada violação encontrada, reporte `arquivo:linha`, a regra violada e a
correção sugerida.

Se `$ARGUMENTS` contiver `--fix`, aplique diretamente as correções mecânicas
e de baixo risco (remover código morto/comentado, remover estilos de debug,
espelhar variáveis CSS ausentes, ajustar formatação) usando a ferramenta
Edit, e finalize com um resumo do que foi corrigido automaticamente vs. o
que precisa de decisão humana (ex.: escolher o `href` real para um link
placeholder). Sem `--fix`, apenas reporte — não edite nada.

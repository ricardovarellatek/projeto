---
description: Reporta o status de implementação das fases de construção do DevLinks (estrutura, estilo, tema, responsividade, polimento)
argument-hint: (nenhum argumento necessário)
allowed-tools: Read, Grep, Glob, Bash(git log:*)
---

O DevLinks (ver README.md) é construído nas seguintes fases. Para cada uma,
inspecione o código-fonte atual e reporte o status usando ✅ (concluída),
⚠️ (parcial / com pendências) ou ❌ (não iniciada), citando `arquivo:linha`
como evidência:

1. **Estrutura HTML** — perfil (`#profile`), lista de links (`ul li a`),
   redes sociais (`#social-links`) e footer presentes em `index.html`.
2. **Estilização base** — variáveis de tema em `:root` (`style.css`),
   tipografia (`Inter` via Google Fonts), layout do `#container`.
3. **Modo claro/escuro** — `toggleMode()` em `script.js`, bloco `.light` em
   `style.css` com todas as variáveis de `:root` espelhadas, troca de imagem
   do avatar.
4. **Responsividade** — media query de breakpoint (700px) trocando
   `--bg-url` para desktop.
5. **Polimento e publicação** — remoção de código morto/comentários de
   debug (ex.: bloco comentado em `script.js`, `border: 1px solid red` em
   `style.css`), `href` reais no lugar de placeholders `#` em `index.html`,
   e presença de configuração de deploy (ex.: GitHub Pages/workflow em
   `.github/`).

Para a fase 5, trate qualquer achado de código morto, placeholder ou
ausência de deploy como pendência (⚠️), não como bloqueio — apenas liste o
que falta.

Saída: uma tabela ou lista markdown com as 5 fases, status, evidência e,
para toda fase ⚠️ ou ❌, o que falta fazer para concluí-la. Termine com um
resumo de uma linha do progresso geral (ex.: "3/5 fases concluídas").

---
description: Gera uma checklist de casos de teste manuais para uma alteração no DevLinks (projeto sem suíte de testes automatizada)
argument-hint: [arquivo ou funcionalidade, opcional]
allowed-tools: Bash(git diff:*), Bash(git status:*), Read, Grep, Glob
---

O DevLinks é um site estático (HTML/CSS/JS puro, sem framework, sem build e sem
testes automatizados). Este comando gera uma checklist de testes **manuais**
para validar uma mudança antes de considerá-la pronta.

Alvo da análise: `$ARGUMENTS` (arquivo, funcionalidade ou trecho descrito pelo
usuário). Se nada for informado, use `git diff` (contra a branch base) e
`git status` para descobrir o que mudou recentemente.

Monte a checklist cobrindo, quando aplicável ao que mudou:

1. **Funcional** — o elemento/link/botão alterado faz o que deveria.
2. **Tema claro/escuro** — `toggleMode()` em `script.js` alterna corretamente
   as variáveis CSS (`:root` vs `.light` em `style.css`) e a troca de imagem
   do avatar (`avatar.png` / `avatar-light.png`); verificar que toda variável
   nova em `:root` tem par em `.light`.
3. **Responsividade** — comportamento abaixo e acima do breakpoint de 700px
   (`style.css`, media query de `--bg-url`): imagem de fundo mobile vs
   desktop, quebra de layout do `#container`.
4. **Links e ícones** — `href` válidos (nenhum `href="#"` esquecido em
   produção), links externos abrindo como esperado, ícones `ion-icon`
   carregando (dependem do script `unpkg.com/ionicons`).
5. **Acessibilidade** — `alt` descritivo em `<img>`, contraste de texto nas
   duas variantes de tema, área clicável do switch de tema.
6. **Cross-browser** — propriedades que exigem prefixo (`backdrop-filter` /
   `-webkit-backdrop-filter`) continuam parelhas.

Formato de saída: lista markdown com checkboxes (`- [ ] ...`), agrupada pelas
categorias acima, citando `arquivo:linha` sempre que possível. Omita
categorias claramente irrelevantes à mudança analisada — não gere itens
genéricos que não fazem sentido para o diff em questão.

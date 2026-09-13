<h1 align="center"> DevLinks </h1>

<p align="center">
Programa exclusivo e gratuito, promovido pela Rocketseat para ensino de tecnologias WEB. <br/>
<a href="https://lp.rocketseat.com.br/devlinks/inscricao?utm_source=github&utm_medium=descricao&utm_campaign=capture-devlinks&utm_term=organic&utm_content=descricao-github-mayk-brito">Estude esse projeto em formato de vídeo clicando aqui.</a>
</p>

<p align="center">
  <a href="#-tecnologias">Tecnologias</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-projeto">Projeto</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-layout">Layout</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#memo-licença">Licença</a>
</p>

<p align="center">
  <img alt="License" src="https://img.shields.io/static/v1?label=license&message=MIT&color=49AA26&labelColor=000000">
</p>

<br>

<p align="center">
  <img alt="projeto DevLinks" src=".github/preview.jpg" width="100%">
</p>

## 🚀 Tecnologias

Esse projeto foi desenvolvido com as seguintes tecnologias:

- HTML e CSS
- JavaScript
- Git e Github
- Figma

## 💻 Projeto

O DevLinks é um agregador de links para usar como cartão de visitas online.

- [Acesse o projeto finalizado, online](https://maykbrito.github.io/devlinks)

- [Assistir aulas](https://lp.rocketseat.com.br/devlinks/inscricao?utm_source=github&utm_medium=descricao&utm_campaign=capture-devlinks&utm_term=organic&utm_content=descricao-github-mayk-brito)

## 🔖 Layout

Você pode visualizar o layout do projeto através [DESSE LINK](https://www.figma.com/community/file/1187422022288947321). É necessário ter conta no [Figma](https://figma.com) para acessá-lo.

## ⚡ Loop automático de performance (Lighthouse)

Este repositório tem uma infraestrutura para medir e melhorar a performance
automaticamente, usando o Lighthouse e o Claude Code em loop (a "técnica
Ralph Wiggum": repetir a mesma tarefa, verificando o progresso a cada
rodada, em vez de tentar acertar tudo de uma vez).

Pré-requisitos: Node.js 18+ e um Chrome/Chromium instalado (se o Lighthouse
não achar automaticamente, defina `CHROME_PATH` apontando para o binário) e
o [Claude Code CLI](https://claude.com/claude-code) autenticado.

```bash
npm install        # instala lighthouse e serve como devDependencies

npm run perf:audit # roda uma auditoria única e salva o relatório em perf-reports/
npm run perf:loop  # roda o loop: audita -> se não bater a meta, chama o
                    # Claude Code com as oportunidades encontradas -> commita
                    # -> audita de novo, até atingir o threshold ou o limite
                    # de iterações
```

Variáveis de ambiente úteis para o `perf:loop`:

- `PERF_THRESHOLD` — score mínimo de performance para parar (padrão: 90)
- `PERF_MAX_ITERATIONS` — máximo de rodadas (padrão: 5)
- `CLAUDE_FLAGS` — flags extras pro `claude`, ex.:
  `CLAUDE_FLAGS="--permission-mode acceptEdits" npm run perf:loop` para não
  precisar aprovar cada edição manualmente

Cada rodada que resulta em mudança gera um commit separado (`perf loop:
iteração N`), então dá pra acompanhar ou reverter iteração por iteração com
`git log` / `git revert`. As instruções que guiam o agente em cada rodada
ficam em `PROMPT.md` — vale revisar/ajustar antes de rodar.

## :memo: Licença

Esse projeto está sob a licença MIT.

---

Feito com ♥ by Rocketseat :wave: [Participe da nossa comunidade!](https://discord.gg/rocketseat)

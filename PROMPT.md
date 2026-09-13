# Loop de performance (técnica "Ralph Wiggum")

Você está rodando dentro de um loop automático que mede a performance desta
landing page estática (DevLinks) com o Lighthouse e tenta melhorá-la a cada
iteração, até atingir um score-alvo.

## Objetivo

Aumentar o score de Performance do Lighthouse, atacando o relatório mais
recente (anexado abaixo), sem alterar o design, o conteúdo ou o comportamento
visual da página.

## Regras

1. Ataque apenas os itens listados na seção "Principais oportunidades"
   abaixo, começando pelo de maior impacto (score mais baixo / maior
   economia estimada).
2. Faça uma mudança pequena e objetiva por execução. Não tente resolver tudo
   de uma vez — outra iteração vai rodar em seguida se ainda for necessário.
3. Nunca altere textos visíveis, links, ou a lógica do dark/light mode.
4. Se a correção envolver imagens, preserve o caminho e a extensão dos
   arquivos (não troque de formato sem atualizar todas as referências no
   HTML/CSS/JS).
5. Não introduza dependências de build (webpack, vite, bundlers, frameworks)
   — o site é HTML/CSS/JS estático de propósito. Ferramentas de linha de
   comando usadas só para gerar/otimizar assets (ex.: recomprimir uma
   imagem) são aceitáveis.
6. Não rode `npm install` para adicionar dependências ao `package.json` do
   projeto (o `package.json` na raiz é só para as ferramentas de
   performance em `scripts/`, não para o site em si).
7. Ao terminar, deixe as mudanças aplicadas no working tree. Não faça commit
   — o script do loop cuida disso.
8. Se não houver nenhuma melhoria razoável a fazer sem sacrificar qualidade
   visual ou adicionar complexidade desproporcional ao projeto, não altere
   nada e explique o motivo em texto.

## Relatório mais recente


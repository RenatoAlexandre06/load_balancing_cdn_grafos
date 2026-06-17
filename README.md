# Load Balancing & CDN com Grafos 🌐⚖️

Este projeto apresenta uma simulação prática de um **Balanceador de Carga (Load Balancer)** em uma **Rede de Distribuição de Conteúdo (CDN)** utilizando conceitos de teoria dos grafos. A aplicação foi desenvolvida em **Dart** para demonstrar como o roteamento dinâmico de tráfego pode prevenir quedas de infraestrutura e mitigar gargalos durante picos de acesso.

## 🚀 O Cenário (Pitch)
Imagine a equipe de engenharia de uma grande CDN (como AWS ou Cloudflare) gerenciando a transmissão de um grande evento ao vivo. De repente, o servidor de borda principal de São Paulo (`Edge_SP`) atinge **99% de capacidade**, elevando drasticamente a latência e colocando o sistema sob risco iminente de *downtime*.

**A Solução:** Modelar a topologia de rede como um **Grafo Ponderado Dinâmico**. O algoritmo calcula o caminho de menor custo em tempo real, considerando não apenas a distância física (latência base), mas também o nível de estresse (fator de carga) de cada servidor, desviando o tráfego automaticamente para rotas alternativas ociosas (como `Edge_RJ`).

## 🧠 Como Funciona a Modelagem

- **Vértices (Nós):** Representam os pontos críticos da rede: `Usuario`, `Edge_SP`, `Edge_RJ` e `Core_Server`.
- **Arestas (Links):** Conexões físicas de rede entre os nós, possuindo uma latência base medida em milissegundos (ms).
- **Pesos Dinâmicos:** O custo real de cada rota é determinado dinamicamente através da fórmula:
  
  $$Custo = Lat\hat{e}ncia\ Base \times Fator\ de\ Carga\ do\ Servidor$$

Se a carga do servidor estiver saudável ($1.0$), o custo final reflete puramente a latência física. Caso o servidor esteja severamente sobrecarregado ($4.5$), o custo calculado dispara, forçando o motor do Load Balancer a escolher um caminho alternativo mais eficiente para o usuário.

## 🛠️ Tecnologias Utilizadas
- **Linguagem:** Dart 3.11.1
- **Paradigma:** Orientação a Objetos (OO) e Algoritmos Adaptativos de Grafos

## 📋 Como Executar o Projeto

### Pré-requisitos
É necessário ter o **Dart SDK** instalado localmente. Caso prefira não instalar nada, o código pode ser copiado e executado diretamente no ambiente web do [DartPad](https://dartpad.dev).

### Passos para Execução Local
1. Clone ou baixe o arquivo de código fonte do projeto.
2. Abra o seu terminal na pasta onde o arquivo se encontra.
3. Execute o seguinte comando: dart run main.dart

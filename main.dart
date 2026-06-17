// Representa a conexão entre dois pontos na rede
class Link {
  String destination;
  double baseLatency; // Latência em ms

  Link(this.destination, this.baseLatency);
}

void main() {
  // 1. Modelagem do Grafo (A Topologia da CDN)
  Map<String, List<Link>> networkGraph = {
    'Usuario': [Link('Edge_SP', 10.0), Link('Edge_RJ', 25.0)],
    'Edge_SP': [Link('Core_Server', 30.0)],
    'Edge_RJ': [Link('Core_Server', 20.0)],
    'Core_Server': []
  };

  // 2. Carga atual dos servidores (Métrica de Load Balancing)
  // 1.0 = Normal | > 2.0 = Sobrecarga severa
  Map<String, double> serverLoad = {
    'Edge_SP': 4.5, // ATENÇÃO: Servidor de SP está gargalando!
    'Edge_RJ': 1.1, // Servidor do RJ está tranquilo
    'Core_Server': 1.0
  };

  print('--- Iniciando Balanceamento de Carga via Grafos ---\n');

  // 3. Simulação do Algoritmo de Roteamento (Caminho Mínimo)
  String currentNode = 'Usuario';
  String targetNode = 'Core_Server';
  double totalCost = 0.0;
  List<String> route = [currentNode];

  while (currentNode != targetNode) {
    List<Link> neighbors = networkGraph[currentNode] ?? [];
    
    if (neighbors.isEmpty) break;

    Link? bestLink;
    double minCost = double.infinity;

    for (var link in neighbors) {
      // O 'peso' do grafo dinâmico: Latência * Carga do servidor de destino
      double loadFactor = serverLoad[link.destination] ?? 1.0;
      double currentCost = link.baseLatency * loadFactor;

      print('Avaliando rota $currentNode -> ${link.destination} | Latência: ${link.baseLatency}ms | Carga: $loadFactor | Custo Calculado: $currentCost');

      if (currentCost < minCost) {
        minCost = currentCost;
        bestLink = link;
      }
    }

    if (bestLink != null) {
      currentNode = bestLink.destination;
      totalCost += minCost;
      route.add(currentNode);
    }
  }

  print('\n--- Resultado do Roteamento ---');
  print('Caminho escolhido para fugir do gargalo: ${route.join(" -> ")}');
  print('Custo total da rota: $totalCost');
}
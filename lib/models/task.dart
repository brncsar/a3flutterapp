class Task {
  final int id; // Campo opcional, pois o ID é gerado automaticamente no banco de dados
  final String titulo; // Título da tarefa
  final String descricao; // Descrição da tarefa
  final DateTime dataHoraVencimento; // Data e hora de vencimento
  final String categoria; // Categoria da tarefa
  bool concluida; // Indicador de conclusão (somente no front-end)

  Task({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.dataHoraVencimento,
    required this.categoria,
    this.concluida = false, // Inicialmente, a tarefa não está concluída
  });

  // Factory para criar um objeto Task a partir de um JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      titulo: json['titulo'] as String,
      descricao: json['descricao'] as String,
      dataHoraVencimento: DateTime.parse(json['dataHoraVencimento'] as String),
      categoria: json['categoria'] as String,
      concluida: json['concluida'] == 1, // Se for 1, torna true; se for 0, torna false
    );
  }

  // Método para converter o objeto Task em um JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'dataHoraVencimento': dataHoraVencimento.toIso8601String(),
      'categoria': categoria,
      'concluida': concluida,
    };
  }

  // Método para alternar o estado de conclusão da tarefa
  void marcarComoConcluida() {
    concluida = true;
  }
}

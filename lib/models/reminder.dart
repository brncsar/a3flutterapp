class Reminder {
  final int id; // Campo opcional, pois o ID é gerado automaticamente no banco de dados
  final String titulo; // Título do lembrete
  final String descricao; // Descrição do lembrete
  final DateTime dataHora; // Data e hora do lembrete

  Reminder({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.dataHora,
  });

  // Factory para criar um objeto Reminder a partir de um JSON
  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'] as int,
      titulo: json['titulo'] as String,
      descricao: json['descricao'] as String,
      dataHora: DateTime.parse(json['dataHora'] as String),
    );
  }

  // Método para converter o objeto Reminder em um JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'dataHora': dataHora.toIso8601String(),
    };
  }
}

import 'dart:ffi';

class User {
  final Int? id;
  final String name;
  final String email;
  final String password;
  final DateTime dataNascimento; // Novo campo adicionado

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.dataNascimento, // Campo obrigatório
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as Int,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      dataNascimento: DateTime.parse(json['dataNascimento'] as String), // Conversão de String para DateTime
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'dataNascimento': dataNascimento.toIso8601String(), // Conversão de DateTime para String ISO 8601
    };
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/reminder.dart';

class ReminderService {
  static const String _baseUrl = 'http://10.0.2.2:9001'; // URL base da API

  // Método para buscar todos os lembretes
  Future<List<Reminder>> fetchReminders() async {
    final response = await http.get(Uri.parse('$_baseUrl/reminders'));

    if (response.statusCode == 200) {
      // Se a resposta for bem-sucedida, parse a lista de lembretes
      List<dynamic> data = json.decode(response.body);
      return data.map((reminderJson) => Reminder.fromJson(reminderJson)).toList();
    } else {
      throw Exception('Falha ao carregar os lembretes');
    }
  }

  // Método para pegar um lembrete pelo ID
  static Future<Reminder> getReminderById(int reminderId) async {
    final response = await http.get(Uri.parse('$_baseUrl/reminders/$reminderId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Reminder.fromJson(data);
    } else {
      throw Exception('Falha ao carregar o lembrete');
    }
  }

  // Método para adicionar um novo lembrete
  static Future<void> addReminder(Reminder reminder) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/reminders'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(reminder.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Falha ao criar o lembrete');
    }
  }

  // Método para atualizar um lembrete existente
  static Future<void> updateReminder(Reminder reminder) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/reminders/${reminder.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(reminder.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar o lembrete');
    }
  }

  // Método para excluir um lembrete pelo ID
  static Future<void> deleteReminder(int reminderId) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/reminders/$reminderId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao excluir o lembrete');
    }
  }

   // Método para pegar todas os lembretes
  static Future<List<Reminder>> getAllReminders() async {
    final response = await http.get(Uri.parse('$_baseUrl/reminders'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((reminder) => Reminder.fromJson(reminder)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }
}

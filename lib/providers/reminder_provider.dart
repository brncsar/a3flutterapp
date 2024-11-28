import 'package:flutter/material.dart';
import 'package:primeiroapp/models/reminder.dart'; // Modelo de Reminder
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReminderProvider extends ChangeNotifier {
  List<Reminder> _reminders = [];

  List<Reminder> get reminders => _reminders;

  // Método para buscar lembretes do banco de dados
  Future<void> fetchReminders() async {
    final url = 'http://10.0.2.2:9001/reminders'; // URL da API
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Se a resposta for 200, parseia os lembretes e atualiza o estado
        final List<dynamic> data = json.decode(response.body);
        _reminders = data.map((item) => Reminder.fromJson(item)).toList();
        notifyListeners();
      } else {
        throw Exception('Erro ao carregar lembretes');
      }
    } catch (error) {
      throw Exception('Erro ao buscar lembretes: $error');
    }
  }

  // Método para adicionar um novo lembrete
  void addReminder(Reminder reminder) {
    _reminders.add(reminder);
    notifyListeners();
  }

  // Método para atualizar um lembrete existente
  void updateReminder(Reminder updatedReminder) {
    final index = _reminders.indexWhere((reminder) => reminder.id == updatedReminder.id);
    if (index >= 0) {
      _reminders[index] = updatedReminder;
      notifyListeners();
    }
  }

  // Método para deletar um lembrete
  Future<void> deleteReminder(int reminderId) async {
    final url = 'http://10.0.2.2:9001/reminders/$reminderId'; // URL para deletar lembrete
    try {
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        // Se a resposta for 200, removemos o lembrete da lista
        _reminders.removeWhere((reminder) => reminder.id == reminderId);
        notifyListeners();
      } else {
        throw Exception('Erro ao deletar lembrete');
      }
    } catch (error) {
      throw Exception('Erro ao deletar lembrete: $error');
    }
  }
}

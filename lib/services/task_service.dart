import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task.dart';

class TaskService {
  static const String _baseUrl = 'http://10.0.2.2:9001'; // URL base da API

  Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse('$_baseUrl/tasks'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((taskJson) => Task.fromJson(taskJson)).toList();
    } else {
      throw Exception('Falha ao carregar as tarefas');
    }
  }

  // Método para pegar uma tarefa pelo ID
  static Future<Task> getTaskById(int taskId) async {
    final response = await http.get(Uri.parse('$_baseUrl/tasks/$taskId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Task.fromJson(data);
    } else {
      throw Exception('Failed to load task');
    }
  }

  // Método para adicionar uma nova tarefa
  static Future<void> addTask(Task task) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/tasks'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(task.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create task');
    }
  }
  

  // Método para atualizar uma tarefa existente
  static Future<void> updateTask(Task task) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/tasks/${task.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(task.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update task');
    }
  }

  // Método para excluir uma tarefa pelo ID
  static Future<void> deleteTask(int taskId) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/tasks/$taskId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }

  // Método para pegar todas as tarefas
  static Future<List<Task>> getAllTasks() async {
    final response = await http.get(Uri.parse('$_baseUrl/tasks'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((task) => Task.fromJson(task)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  // Novo método para atualizar o status de conclusão da tarefa
  static Future<void> updateTaskCompletion(int taskId, bool concluida) async {
    try {
      final response = await http.patch(
        Uri.parse('$_baseUrl/tasks/$taskId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'concluida': concluida}),
      );

      if (response.statusCode != 200) {
        throw Exception('Falha ao atualizar o status da tarefa');
      }
    } catch (error) {
      throw Exception('Falha ao atualizar o status da tarefa: $error');
    }
  }
}

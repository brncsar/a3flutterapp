import 'package:flutter/material.dart';
import 'package:primeiroapp/models/task.dart'; // Modelo da Task
import 'package:http/http.dart' as http;
import 'dart:convert';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  // Método para buscar tarefas do banco de dados
  Future<void> fetchTasks() async {
    final url = 'http://10.0.2.2:9001/tasks'; // URL da API
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Se a resposta for 200, parseia as tarefas e atualiza o estado
        final List<dynamic> data = json.decode(response.body);
        _tasks = data.map((item) => Task.fromJson(item)).toList();
        notifyListeners();
      } else {
        throw Exception('Erro ao carregar tarefas');
      }
    } catch (error) {
      throw Exception('Erro ao buscar tarefas: $error');
    }
  }



  // Método para adicionar uma nova tarefa
  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  // Método para atualizar uma tarefa existente
  void updateTask(Task updatedTask) {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index >= 0) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  // Método para atualizar o status de conclusão da tarefa
  Future<void> updateTaskCompletion(int taskId, bool concluida) async {
    try {
      final response = await http.patch(
        Uri.parse('http://10.0.2.2:9001/tasks/$taskId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'concluida': concluida,
        }),
      );

      if (response.statusCode == 200) {
        // Atualiza o estado local da tarefa
        final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
        if (taskIndex != -1) {
          _tasks[taskIndex].concluida = concluida;
          notifyListeners(); // Notifica para atualizar a UI
        }
      } else {
        throw Exception('Falha ao atualizar o status da tarefa');
      }
    } catch (error) {
      throw Exception('Falha ao atualizar o status da tarefa: $error');
    }
  }

  // Método para deletar uma tarefa
  Future<void> deleteTask(int taskId) async {
    final url = 'http://10.0.2.2:9001/tasks/$taskId'; // URL para deletar tarefa
    try {
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        // Se a resposta for 200, removemos a tarefa da lista
        _tasks.removeWhere((task) => task.id == taskId);
        notifyListeners();
      } else {
        throw Exception('Erro ao deletar tarefa');
      }
    } catch (error) {
      throw Exception('Erro ao deletar tarefa: $error');
    }
  }
}

import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> fetchTasks() async {
    try {
      _tasks = await TaskService().fetchTasks();
      notifyListeners();
    } catch (error) {
      throw Exception('Failed to fetch tasks');
    }
  }

  Future<void> addTask(Task task) async {
    try {
      await TaskService().addTask(task);
      _tasks.add(task);
      notifyListeners();
    } catch (error) {
      throw Exception('Failed to add task');
    }
  }

  Future<void> updateTask(Task updatedTask) async {
    try {
      await TaskService().updateTask(updatedTask);
      final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
      if (index != -1) {
        _tasks[index] = updatedTask;
        notifyListeners();
      }
    } catch (error) {
      throw Exception('Failed to update task');
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await TaskService().deleteTask(id);
      _tasks.removeWhere((task) => task.id == id);
      notifyListeners();
    } catch (error) {
      throw Exception('Failed to delete task');
    }
  }

  void markTaskAsCompleted(String id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index].isCompleted = true;
      notifyListeners();
    }
  }

  List<Task> getTasksByCategory(String category) {
    return _tasks.where((task) => task.category == category).toList();
  }
}

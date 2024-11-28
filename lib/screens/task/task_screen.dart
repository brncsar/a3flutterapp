import 'package:flutter/material.dart';
import 'package:primeiroapp/models/reminder.dart';
import 'package:primeiroapp/models/task.dart';
import 'package:primeiroapp/screens/task/edit_reminder_screen.dart';
import 'package:primeiroapp/screens/task/edit_task_screen.dart';
import 'package:primeiroapp/services/reminder_service.dart';
import 'package:primeiroapp/services/task_service.dart';
import 'package:primeiroapp/widgets/back_button.dart';
import 'package:primeiroapp/widgets/custom_layout.dart';
import 'package:primeiroapp/widgets/custom_button.dart';
import 'package:intl/intl.dart';

// Função para formatar a data para "dd/MM/yyyy"
String formatDate(DateTime date) {
  final formatter = DateFormat("dd/MM/yyyy");
  return formatter.format(date);
}

// Função para formatar o horário para "HH:mm"
String formatTime(DateTime time) {
  final timeFormatter = DateFormat("HH:mm");
  return timeFormatter.format(time);
}

class TaskScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskScreen> {
  List<Task> _tasks = [];
  List<Reminder> _reminders = [];
  bool _isLoading = true;
  bool _isTaskView = true;

  // Método para buscar as tarefas
  Future<void> _fetchTasks() async {
    try {
      final tasks = await TaskService.getAllTasks();
      setState(() {
        _tasks = tasks;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print('Failed to load tasks: $error');
    }
  }

  // Método para buscar os lembretes
  Future<void> _fetchReminders() async {
    try {
      final reminders = await ReminderService.getAllReminders();
      setState(() {
        _reminders = reminders;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print('Failed to load reminders: $error');
    }
  }

  // Método para excluir uma tarefa
  Future<void> _deleteTask(int taskId) async {
    try {
      await TaskService.deleteTask(taskId);
      setState(() {
        _tasks.removeWhere((task) => task.id == taskId);
      });
    } catch (error) {
      print('Failed to delete task: $error');
    }
  }

  // Método para excluir um lembrete
  Future<void> _deleteReminder(int reminderId) async {
    try {
      await ReminderService.deleteReminder(reminderId);
      setState(() {
        _reminders.removeWhere((reminder) => reminder.id == reminderId);
      });
    } catch (error) {
      print('Failed to delete reminder: $error');
    }
  }

  // Função para abrir o painel de edição da tarefa
  void _openEditTaskPanel(Task task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: EditTaskPanel(
              task: task,
              onSave: (updatedTask) async {
                Navigator.pop(context);
                setState(() {
                  int index = _tasks.indexWhere((t) => t.id == updatedTask.id);
                  if (index != -1) {
                    _tasks[index] = updatedTask;
                  }
                });
                await TaskService.updateTask(updatedTask); // Envia as alterações para o back-end
              },
            ),
          ),
        );
      },
    );
  }

  // Função para abrir o painel de edição do lembrete
  void _openEditReminderPanel(Reminder reminder) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: EditReminderPanel(
              reminder: reminder,
              onSave: (updatedReminder) async {
                Navigator.pop(context);
                setState(() {
                  int index = _reminders.indexWhere((r) => r.id == updatedReminder.id);
                  if (index != -1) {
                    _reminders[index] = updatedReminder;
                  }
                });
                await ReminderService.updateReminder(updatedReminder); // Envia as alterações para o back-end
              },
            ),
          ),
        );
      },
    );
  }

  // Função para abrir a tela de criação de nova tarefa
  void _openCreateTaskPanel() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: EditTaskPanel(
              task: Task(id: 0, titulo: '', descricao: '', dataHoraVencimento: DateTime.now(), categoria: '', concluida: false),
              onSave: (newTask) async {
                Navigator.pop(context);
                setState(() {
                  _tasks.add(newTask);
                });
                await TaskService.addTask(newTask); // Envia a nova tarefa para o back-end
              },
            ),
          ),
        );
      },
    );
  }

  // Função para abrir a tela de criação de novo lembrete
  void _openCreateReminderPanel() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: EditReminderPanel(
              reminder: Reminder(id: 0, titulo: '', descricao: '', dataHora: DateTime.now()),
              onSave: (newReminder) async {
                Navigator.pop(context);
                setState(() {
                  _reminders.add(newReminder);
                });
                await ReminderService.addReminder(newReminder); // Envia o novo lembrete para o back-end
              },
            ),
          ),
        );
      },
    );
  }

  // Função para alternar o estado do checkbox (marcar como concluído ou não)
  void _toggleTaskCompletion(int taskId, bool isCompleted) async {
    try {
      final updatedTask = _tasks.firstWhere((task) => task.id == taskId);
      updatedTask.concluida = isCompleted;
      setState(() {
        // Atualiza o estado da tarefa na lista
      });
      await TaskService.updateTask(updatedTask); // Envia a alteração para o back-end
    } catch (error) {
      print('Failed to update task completion: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      bodyContent: Column(
        children: [
          // Botão de Voltar no topo da tela
          Padding(
            padding: const EdgeInsets.only(top: 60, right: 300),
            child: BotaoVoltar(),
          ),
          SizedBox(height: 50),
          // Botões para alternar entre tarefas e lembretes
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  label: 'Tarefas',
                  onPressed: () {
                    setState(() {
                      _isTaskView = true; // Exibe tarefas
                      _fetchTasks(); // Busca tarefas
                    });
                  },
                ),
                SizedBox(width: 20),
                CustomButton(
                  label: 'Lembretes',
                  onPressed: () {
                    setState(() {
                      _isTaskView = false; // Exibe lembretes
                      _fetchReminders(); // Busca lembretes
                    });
                  },
                ),
              ],
            ),
          ),
          // Lista de Tarefas ou Lembretes
          // Lista de Tarefas ou Lembretes
Expanded(
  child: ListView.builder(
    reverse: true, // Inverte a direção da lista
    itemCount: _isTaskView ? _tasks.length : _reminders.length,
    itemBuilder: (ctx, index) {
      if (_isTaskView) {
        final task = _tasks[index];
        return Card(
          color: Colors.white,
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            leading: Checkbox(
              value: task.concluida,
              onChanged: (bool? value) {
                _toggleTaskCompletion(task.id, value ?? false);
              },
            ),
            title: Text(
              task.titulo,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.descricao),
                SizedBox(height: 5),
                Text('Vencimento: ${formatDate(task.dataHoraVencimento)} às ${formatTime(task.dataHoraVencimento)}'),
                SizedBox(height: 5),
                Text('Categoria: ${task.categoria}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    _openEditTaskPanel(task); // Editar a tarefa
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _deleteTask(task.id); // Deletar a tarefa
                  },
                ),
              ],
            ),
            onTap: () {
              _openEditTaskPanel(task); // Editar a tarefa
            },
            onLongPress: () {
              _deleteTask(task.id); // Deletar a tarefa
            },
          ),
        );
      } else {
        final reminder = _reminders[index];
        return Card(
          color: Colors.white,
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            title: Text(
              reminder.titulo,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(reminder.descricao),
                SizedBox(height: 5),
                Text('Data: ${formatDate(reminder.dataHora)} às ${formatTime(reminder.dataHora)}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    _openEditReminderPanel(reminder); // Editar o lembrete
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _deleteReminder(reminder.id); // Deletar o lembrete
                  },
                ),
              ],
            ),
            onTap: () {
              _openEditReminderPanel(reminder); // Editar o lembrete
            },
            onLongPress: () {
              _deleteReminder(reminder.id); // Deletar o lembrete
            },
          ),
        );
      }
    },
  ),
),

          // Botões para adicionar novas tarefas ou lembretes
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _openCreateTaskPanel, // Adicionar nova tarefa
                  child: Text('Adicionar Tarefa'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _openCreateReminderPanel, // Adicionar novo lembrete
                  child: Text('Adicionar Lembrete'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

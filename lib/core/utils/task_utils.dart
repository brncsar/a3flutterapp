/*import 'package:primeiroapp/models/task.dart';
import 'package:primeiroapp/services/task_service.dart';

/// Função para criar uma nova Task a partir de um formulário.
Future<bool> createTaskFromForm({
  required String title,
  required String description,
  required String dueDate,
  required String dueTime,
  required String category,
}) async {
  // Combina a data e hora para criar um objeto DateTime
  DateTime? parsedDueDate = DateTime.tryParse('$dueDate $dueTime');
  if (parsedDueDate == null) {
    throw Exception('Data ou hora inválida!');
  }

  // Cria o objeto Task com os dados fornecidos
  Task task = Task(
    id: ,
    titulo: title,
    descricao: description,
    dataHoraVencimento: parsedDueDate,
    categoria: category,
  );

  // Faz a chamada para o serviço de API
  await TaskService.addTask(task);

  return true;
}
*/
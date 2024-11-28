import 'package:flutter/material.dart';
import 'package:primeiroapp/core/utils/date_utils.dart';
import 'package:primeiroapp/models/reminder.dart';
import 'package:primeiroapp/services/reminder_service.dart';


class EditReminderPanel extends StatefulWidget {
  final Reminder reminder;
  final Function(Reminder) onSave;

  const EditReminderPanel({required this.reminder, required this.onSave, Key? key}) : super(key: key);

  @override
  _EditReminderPanelState createState() => _EditReminderPanelState();
}

class _EditReminderPanelState extends State<EditReminderPanel> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.reminder.titulo);
    _descriptionController = TextEditingController(text: widget.reminder.descricao);
    _dateController = TextEditingController(text: formatDate(widget.reminder.dataHora));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Título'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Descrição'),
          ),
          TextField(
            controller: _dateController,
            decoration: InputDecoration(labelText: 'Data'),
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode()); // Remove o foco para evitar abrir o teclado
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: widget.reminder.dataHora,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                setState(() {
                  _dateController.text = formatDate(pickedDate);
                });
              }
            },
            readOnly: true, // Impede a digitação direta
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final updatedReminder = Reminder(
                id: widget.reminder.id,
                titulo: _titleController.text,
                descricao: _descriptionController.text,
                dataHora: parseDate(_dateController.text) ?? widget.reminder.dataHora,
              );

              // Chamando a função onSave passada por parâmetro para salvar as alterações
              widget.onSave(updatedReminder);

              // Atualizando o lembrete no backend
              ReminderService.updateReminder(updatedReminder).then((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Lembrete atualizado com sucesso!')),
                );
              }).catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Falha ao atualizar o lembrete.')),
                );
              });
            },
            child: Text('Salvar Alterações'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:primeiroapp/core/utils/date_utils.dart';
import 'package:primeiroapp/models/task.dart';

class EditTaskPanel extends StatefulWidget {
  final Task task;
  final Function(Task) onSave;

  const EditTaskPanel({required this.task, required this.onSave, Key? key}) : super(key: key);

  @override
  _EditTaskPanelState createState() => _EditTaskPanelState();
}

class _EditTaskPanelState extends State<EditTaskPanel> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _categoryController;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.titulo);
    _descriptionController = TextEditingController(text: widget.task.descricao);
    _categoryController = TextEditingController(text: widget.task.categoria);
    _dateController = TextEditingController(text: formatDate(widget.task.dataHoraVencimento));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
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
            controller: _categoryController,
            decoration: InputDecoration(labelText: 'Categoria'),
          ),
          TextField(
            controller: _dateController,
            decoration: InputDecoration(labelText: 'Data de Vencimento'),
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode()); // Remove o foco para evitar abrir o teclado
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: widget.task.dataHoraVencimento,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                setState(() {
                  _dateController.text = formatDate(pickedDate);
                });
              }
            },
            readOnly: true, // Evita digitação direta
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final updatedTask = Task(
                id: widget.task.id,
                titulo: _titleController.text,
                descricao: _descriptionController.text,
                categoria: _categoryController.text,
                dataHoraVencimento: parseDate(_dateController.text) ?? widget.task.dataHoraVencimento,
                concluida: widget.task.concluida,
              );

              widget.onSave(updatedTask);
            },
            child: Text('Salvar Alterações'),
          ),
        ],
      ),
    );
  }
}

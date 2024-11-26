import 'package:flutter/material.dart';
import 'package:primeiroapp/widgets/back_button.dart';
import 'package:primeiroapp/widgets/custom_layout.dart';

class TaskScreen extends StatelessWidget {
  final List<String> tarefasELembretes = [
    "Comprar materiais para a aula",
    "Lembrar de pegar o relatório",
    "Ir à reunião de equipe",
    "Meditar por 15 minutos",
    "Enviar e-mail para o cliente",
  ];

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      bodyContent: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Botão de voltar para a tela home
               Align(
                  alignment: Alignment.centerLeft,
                  child: BotaoVoltar(
                    onPressed: () {
                      Navigator.pop(context); // Volta para a página anterior
                    },
                  ),
                ),
                const SizedBox(height: 90), // Espaço após o botão
            // Título da tela
            const Text(
              "Tarefas e Lembretes",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            
            // Lista de tarefas e lembretes
            Expanded(
              child: ListView.builder(
                itemCount: tarefasELembretes.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.black87,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        tarefasELembretes[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          // Ação para excluir a tarefa ou lembrete
                          print('Excluir tarefa: ${tarefasELembretes[index]}');
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Botão para adicionar nova tarefa ou lembrete
            ElevatedButton(
              onPressed: () {
                // Ação para adicionar nova tarefa ou lembrete
                print("Adicionar nova tarefa ou lembrete");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lime, // Cor do botão
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              child: const Text(
                "Adicionar Tarefa/Lembrete",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed; // Função personalizada para o clique do botão
  final String label; // Texto do botão

  const CustomButton({
    super.key,
    this.onPressed,
    this.label = '', // Texto padrão vazio
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, // Função que será executada quando o botão for pressionado
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black, // Cor do texto em branco
          fontSize: 16, // Tamanho da fonte
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Cor de fundo verde
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}

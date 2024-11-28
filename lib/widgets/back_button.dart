import 'package:flutter/material.dart';

class BotaoVoltar extends StatelessWidget {
  final String? targetRoute; // Rota para onde o botão deve navegar (opcional)
  final VoidCallback? onPressed; // Função personalizada (opcional)
  final String label; // Texto do botão
  final IconData icon; // Ícone ao lado do texto

  const BotaoVoltar({
    super.key,
    this.targetRoute,
    this.onPressed,
    this.label = '',
    this.icon = Icons.arrow_back, // Ícone padrão
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed ??
          () {
            if (targetRoute != null) {
              Navigator.of(context).pushReplacementNamed(targetRoute!);
            } else {
              Navigator.of(context).pop();
            }
          },
      icon: Icon(
        icon,
        color: Colors.white, // Cor do ícone (seta) em branco
      ),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white, // Cor do texto em branco
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lime, // Cor de fundo verde
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomLayout extends StatelessWidget {
  final Widget bodyContent;

  CustomLayout({required this.bodyContent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo da tela
          _buildBackground(context),
          // Conteúdo da tela
          bodyContent,
        ],
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
    return Column(
      children: [
        // Imagem ocupando a metade superior da tela
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/teste.png'), // Caminho da imagem
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        // Cor de fundo preta na metade inferior
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

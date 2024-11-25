import 'package:flutter/material.dart';
import 'package:primeiroapp/widgets/custom_layout.dart';

class HomeScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      bodyContent: Center(
        child: Text(
          "Tela vazia usando CustomLayout", // Texto só para visualização
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

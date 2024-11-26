import 'package:flutter/material.dart';
import 'package:primeiroapp/widgets/custom_layout.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    // Aqui você chamará sua API para autenticação
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError("Por favor, preencha todos os campos.");
      return;
    }

    // Simulação de login bem-sucedido
    if (email == "admin@teste.com" && password == "123456") {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      _showError("Credenciais inválidas.");
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Erro"),
        content: Text(message),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      bodyContent: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Bem-vindo ao Sistema!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                // Adicionando o Expanded para preencher o espaço e deslocar os campos para baixo
                Spacer(), // Esta linha irá empurrar os campos para o fundo
                // Formulário de login
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Campo de email com ícone
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "E-mail",
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: Colors.black54,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 16),

                    // Campo de senha com ícone
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Senha",
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: Colors.black54,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    // Link para "Esqueceu sua senha?"
                    TextButton(
                      onPressed: () {
                        // Aqui você pode adicionar a navegação para a tela de recuperação de senha
                      },
                      child: Text("Esqueceu sua senha?", style: TextStyle(color: Colors.blue)),
                    ),
                    const SizedBox(height: 16),

                    // Botão de login
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Define a cor de fundo para verde
                      ),
                      child: const Text("Entrar", style: TextStyle(color: Colors.black)),
                    ),
                    const SizedBox(height: 16),

                    // Palavra "ou"
                    const Center(child: Text("ou", style: TextStyle(fontSize: 16, color: Colors.white))),
                    const SizedBox(height: 16),

                    // Botão "Entrar com o Google" com ícone
                    ElevatedButton.icon(
                      onPressed: () {
                        // Aqui você pode adicionar a lógica de login com o Google
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 221, 231, 240), // Cor de fundo para o botão do Google
                      ),
                      icon: const Icon(
                        Icons.g_mobiledata, // Ícone do Google
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Entrar com o Google",
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Link para cadastro
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // Aqui você pode adicionar a navegação para a tela de cadastro
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text("Ainda não tem cadastro? Cadastre-se", style: TextStyle(color: Colors.blue)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:primeiroapp/core/utils/date_utils.dart';
import 'package:primeiroapp/core/utils/user_utils.dart';
import 'package:primeiroapp/widgets/custom_layout.dart';
import 'package:primeiroapp/widgets/back_button.dart';



class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dataNascimentoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Função para mostrar o DatePicker
  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null && picked != initialDate) {
      setState(() {
        _dataNascimentoController.text = formatDate(picked); // Usando a função reutilizável
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      bodyContent: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: BotaoVoltar(
                    onPressed: () {
                      Navigator.pop(context); // Volta para a página anterior
                    },
                  ),
                ),
                const SizedBox(height: 90), // Espaço após o botão

                const Text(
                  "Cadastro de Usuário",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                // Campo Nome
                _buildTextField(
                  controller: _nameController,
                  label: "Nome",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor, insira seu nome.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Campo Data de Nascimento
                _buildTextField(
                  controller: _dataNascimentoController,
                  label: "Data de Nascimento",
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor, insira sua data de nascimento.";
                    }
                    return null;
                  },
                  onTap: () => _selectDate(context),  // Adicionando o DatePicker
                  readOnly: true,  // Para garantir que o usuário não edite diretamente
                ),
                const SizedBox(height: 16),
                // Campo Email
                _buildTextField(
                  controller: _emailController,
                  label: "Email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor, insira seu email.";
                    }
                    if (!RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(value)) {
                      return "Por favor, insira um email válido.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Campo Confirmar Email
                _buildTextField(
                  controller: _confirmEmailController,
                  label: "Confirmar Email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor, confirme seu email.";
                    }
                    if (value != _emailController.text) {
                      return "Os emails não coincidem.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Campo Senha
                _buildTextField(
                  controller: _passwordController,
                  label: "Senha",
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor, insira uma senha.";
                    }
                    if (value.length < 6) {
                      return "A senha deve ter pelo menos 6 caracteres.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Campo Confirmar Senha
                _buildTextField(
                  controller: _confirmPasswordController,
                  label: "Confirmar Senha",
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor, confirme sua senha.";
                    }
                    if (value != _passwordController.text) {
                      return "As senhas não coincidem.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Botão de Cadastro
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      try {
                        // Chama a função utilitária para criar o usuário
                        await createUserFromForm(
                          name: _nameController.text,
                          dataNascimento: _dataNascimentoController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Cadastro realizado com sucesso')),
                        );

                        Navigator.of(context).pushReplacementNamed('/login');
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Erro ao cadastrar: $e')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lime,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  ),
                  child: const Text(
                    "Cadastrar",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],      
            ),
          ),
        ),
      ),
    );
  }

  // Função para criar os campos com o efeito blur
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    VoidCallback? onTap, // Para capturar o tap no campo de data
    bool readOnly = false, // Para garantir que o campo de data seja apenas leitura
  }) {
    return Stack(
      children: [
        // Efeito de blur no fundo
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0), // Bordas ainda mais arredondadas
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Efeito de blur
              child: Container(
                color: Colors.white.withOpacity(0.2), // Cor de fundo com transparência
              ),
            ),
          ),
        ),
        // O campo de texto real
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          onTap: onTap, // Ação no tap
          readOnly: readOnly, // Para garantir que o usuário não edite diretamente
          style: const TextStyle(color: Colors.white), // Texto branco
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0), // Bordas arredondadas no campo
            ),
            filled: true,
            fillColor: Colors.transparent, // O fundo fica transparente com blur
          ),
        ),
      ],
    );
  }
}

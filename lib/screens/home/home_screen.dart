import 'package:flutter/material.dart';
import 'package:primeiroapp/widgets/custom_layout.dart';

class HomeScreen extends StatelessWidget {
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
                // Saudação ao usuário
                const Text(
                  "Olá usuário!\nSeja bem-vindo!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                // Corpo principal com os botões
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end, // Alinha os itens ao fundo
                    children: [
                      // Botão "Ficha de treino"
                      _buildMenuButton(
                        icon: Icons.description,
                        label: "Ficha de treino",
                        onTap: () {
                          // Ação para a ficha de treino
                        },
                      ),
                      const SizedBox(height: 16),
                      // Botão "Dicas"
                      _buildMenuButton(
                        icon: Icons.lightbulb_outline,
                        label: "Dicas",
                        onTap: () {
                          // Ação para dicas
                        },
                      ),
                      const SizedBox(height: 16),
                      // Botões "Avaliações" e "Financeiro" em uma linha
                      Row(
                        children: [
                          Expanded(
                            child: _buildMenuButton(
                              icon: Icons.health_and_safety,
                              label: "Avaliações",
                              onTap: () {
                                // Ação para avaliações
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildMenuButton(
                              icon: Icons.attach_money,
                              label: "Financeiro",
                              onTap: () {
                                // Ação para financeiro
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Botão "Tarefas"
                      _buildMenuButton(
                        icon: Icons.task_alt,
                        label: "Tarefas e lembretes",
                        onTap: () {
                          // Navegar para a tela de tarefas
                          Navigator.pushNamed(context, '/task');
                        },
                      ),
                      const SizedBox(height: 20),
                      // Botão "Sair"
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login'); // Voltar à tela de login
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 160),
                        ),
                        child: const Text(
                          "Sair",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Círculo com a imagem do usuário e menu
          Positioned(
            top: 40, // Ajuste a distância do topo aqui
            right: 16,
            child: Column(
              children: [
                // Círculo com imagem do usuário
                GestureDetector(
                  onTap: () {
                    // Ação ao clicar na imagem do usuário
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/avatar.png'), // Substitua pelo caminho da imagem do usuário
                  ),
                ),
                const SizedBox(height: 8),
                // Menu com opções abaixo do círculo
                PopupMenuButton<String>(
                  onSelected: (String value) {
                    // Ação ao selecionar uma opção
                    print("Selecionado: $value");
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Perfil',
                      child: Text('Perfil'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Configurações',
                      child: Text('Configurações'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Ajuda',
                      child: Text('Ajuda'),
                    ),
                  ],
                  child: const Icon(
                    Icons.menu,
                    color: Color.fromARGB(255, 255, 102, 0),
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Função auxiliar para criar os botões do menu
  Widget _buildMenuButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lime, // Cor de fundo do botão
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black, size: 24),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

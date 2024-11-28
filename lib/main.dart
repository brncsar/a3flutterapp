import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:primeiroapp/screens/home/home_screen.dart';
import 'package:primeiroapp/screens/register/register_screen.dart';
import 'package:primeiroapp/screens/task/task_screen.dart';
import 'screens/auth/login_screen.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'package:primeiroapp/providers/task_provider.dart'; // Importando o TaskProvider

void main() async {
  // Inicializa o SettingsController e carrega as configurações do usuário
  final settingsController = SettingsController(SettingsService());

  // Carrega as configurações (como o tema) antes de iniciar o app
  await settingsController.loadSettings();

  // Executa o app com o SettingsController
  runApp(MyApp(settingsController: settingsController));
}

class MyApp extends StatelessWidget {
  final SettingsController settingsController;

  // Recebe o SettingsController para passar para o resto do app
  MyApp({required this.settingsController});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(), // Fornece o TaskProvider para a aplicação
      child: MaterialApp(
        title: 'To-Do Academy',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: settingsController.themeMode, // Usa o themeMode do SettingsController
        initialRoute: '/home',
        routes: {
          '/login': (context) => LoginScreen(),
          '/home': (context) => HomeScreen(),
          '/register': (context) => RegisterScreen(),
          '/task': (context) => TaskScreen(), // Rota para a tela de tarefas
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:primeiroapp/screens/home/home_screen.dart';
import 'package:primeiroapp/screens/home/home_screen2.dart';
import 'screens/auth/login_screen.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

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
    return MaterialApp(
      title: 'To-Do Academy',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: settingsController.themeMode, // Usa o themeMode do SettingsController
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/home2': (context) => HomeScreen2(),
      },
    );
  }
}

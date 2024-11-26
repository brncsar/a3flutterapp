import 'package:primeiroapp/core/utils/date_utils.dart';
import 'package:primeiroapp/models/user.dart';
import 'package:primeiroapp/services/user_service.dart';

Future<bool> createUserFromForm({
  required String name,
  required String dataNascimento, // Nome ajustado
  required String email,
  required String password,
}) async {
  // Tenta converter a data de nascimento usando a função utilitária
  DateTime? parsedDataNascimento = parseDate(dataNascimento);
  if (parsedDataNascimento == null) {
    throw Exception('Data inválida!');
  }

  // Cria o objeto User com os dados fornecidos
  User user = User(
    name: name,
    dataNascimento: parsedDataNascimento, // Nome ajustado
    email: email,
    password: password,
  );

  // Faz a chamada para o serviço de API
  await UserService.createUser(user);

  return true;
}

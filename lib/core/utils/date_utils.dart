import 'package:intl/intl.dart';

// Função para formatar uma data para "dd/MM/yyyy"
String formatDate(DateTime date) {
  final formatter = DateFormat("dd/MM/yyyy");
  return formatter.format(date);
}

// Função para converter uma String em DateTime
DateTime? parseDate(String date) {
  try {
    return DateFormat("dd/MM/yyyy").parse(date);
  } catch (e) {
    return null; // Retorna null se a conversão falhar
  }
}
 
import 'package:intl/intl.dart';

class HumanFormats {


  static String number(num value) {
    return NumberFormat.compact(
      locale: 'en',
    ).format(value);
  }

  // Llama a esto si tu entrada es una cadena que puede tener separadores de miles.
  static String numberFromString(double input) {
    final inputStr = input.toString();
    final sanitized = inputStr.replaceAll('.', '').replaceAll(',', '.');
    final value = double.tryParse(sanitized) ?? 0;
    return number(value);
  }
}
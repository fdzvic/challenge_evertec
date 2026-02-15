final RegExp _emailRegExp = RegExp(
  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
);
String? validateEmail(String email, {String? matchValue}) {
  if (email.isEmpty) {
    return 'Introduce un correo';
  } else if (!_emailRegExp.hasMatch(email.trim())) {
    return 'Por favor introduce un correo válido';
  }

  if (matchValue != null) {
    return validateMatchValue(email, matchValue);
  }

  return null;
}

String? validatePassword(String input, {String? matchValue}) {
  if (input.isEmpty) {
    return 'Este campo es obligatorio';
  }

  if (matchValue != null && input != matchValue) {
    return 'Las contraseñas no coinciden';
  }

  if (input.length < 8) {
    return 'Debe tener al menos 8 caracteres';
  }

  return null;
}

String? validateName(String input, {String? matchValue}) {
  if (input.isEmpty) {
    return 'Este campo es obligatorio';
  } else {
    final String pattern = r'^[a-zA-Z\s]*$';
    final RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(input)) {
      return 'Ingresa un nombre válido';
    }
    return null;
  }
}

String? validatePhone(String input, {String? matchValue}) {
  if (input.isEmpty || input.length != 10) {
    return 'Introduce un número de celular válido';
  }
  return null;
}

String? validateMatchValue(String value, String match) => value != match
    ? 'Las contraseñas no coinciden. Corrige y vuelve a intentar'
    : null;

String? noValidate() => null;

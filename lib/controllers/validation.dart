String? validateEmail(String? formEmail) {
  final RegExp emailRegExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (formEmail == null || formEmail.isEmpty) {
    return 'Enter your E-mail Address';
  }

  if (!emailRegExp.hasMatch(formEmail)) {
    return 'Enter a valid email address';
  }

  return null;
}

String? validateName(String? formName) {
  final RegExp nameRegExp = RegExp(r"^[\p{L} ,.'-]*$",
      caseSensitive: false, unicode: true, dotAll: true);

  if (formName == null || formName.isEmpty) {
    return 'Enter your Name';
  }

  if (!nameRegExp.hasMatch(formName)) {
    return 'Enter a valid Name';
  }

  return null;
}

String? validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return 'Enter a password';
  } else if (password.length < 8) {
    return 'Your Password must have at least 8 characters';
  }
  return null;
}

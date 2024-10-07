/// Exception that occurs when the user enter invalid data into the form
class InvalidDataError implements Exception {}

class InputValidators {
  static void checkEmail(String email) {
    final check = RegExp(
      r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$",
    ).hasMatch(email);

    if (email.isEmpty || !check) throw InvalidDataError();
  }

  static void checkPassword(String password) {
    final check = password.length > 7;

    if (!check) throw InvalidDataError();
  }
}

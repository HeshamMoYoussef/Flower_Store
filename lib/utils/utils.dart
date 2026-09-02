String? isEmailValid(String? email) {
  return email!.contains(
    RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ),
  )
      ? null
      : "Enter a valid Email";
}

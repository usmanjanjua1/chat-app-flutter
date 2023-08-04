class CommonFuncs {
  static bool validateForm(dynamic fKey) {
    final isValid = fKey.currentState?.validate();
    return isValid ?? false;
  }
}

class AdminAuth {
  static const _adminname = 'pinky';
  static const _adminPassword = '123456';

  static bool login(String name, String password) {
    return name == _adminname && password == _adminPassword;
  }
}
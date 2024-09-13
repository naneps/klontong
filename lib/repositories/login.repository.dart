class LoginRepository {
  Future<bool> login(String username, String password) async {
    return username == 'admin' && password == 'password';
  }
}

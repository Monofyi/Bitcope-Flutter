class UserModel {
  final String userName;
  final String email;
  final String password;
  final String confirmPassword;
  UserModel({
    this.userName,
    this.email,
    this.password,
    this.confirmPassword,
  });

  set userName(String userName) {
    this.userName = userName;
  }

  set email(String email) {
    this.email = email;
  }

  set password(String password) {
    this.password = password;
  }

  set confirmPassword(String confirmPassword) {
    this.confirmPassword = confirmPassword;
  }
}

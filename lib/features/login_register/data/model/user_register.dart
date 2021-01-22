class UserRegister {
  String username;
  String password;
  String confirmPassword;

  UserRegister({this.username, this.password});

  Map<String, dynamic> toDatabaseJson() => {
        "username": this.username,
        "password": this.password,
        "confirmpassword": this.confirmPassword
      };
}

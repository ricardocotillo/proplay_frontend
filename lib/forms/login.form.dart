class LoginForm {
  String? email;
  String? password;

  LoginForm({
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() => ({
        'email': email,
        'password': password,
      });
}

class SignupModel {
  final String email;
  final String phonenumber;
  final String password;
  final String confirmPassword;

  SignupModel(
      {required this.email,
      required this.phonenumber,
      required this.password,
      required this.confirmPassword});
}

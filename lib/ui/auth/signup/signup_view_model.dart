import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/app/locator.dart';
import 'package:todo_app/model/signup_model.dart';
import 'package:todo_app/service/auth_service.dart';

class SignupViewModel extends BaseViewModel {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  void navigateToLogin(BuildContext context) {
    context.go('/login');
  }

  Future<void> signup(SignupModel signupModel, BuildContext context) async {
    setBusy(true);

    final result = await locator<AuthService>().signup(SignupModel(
      email: signupModel.email,
      username: signupModel.username,
      phonenumber: signupModel.phonenumber,
      password: signupModel.password,
      confirmPassword: signupModel.confirmPassword,
    ));

    result.fold((error) {
      setBusy(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        content: Text(error),
      ));
    }, (success) {
      setBusy(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        content: Text(success),
      ));
      context.go('/login');
    });
  }
}

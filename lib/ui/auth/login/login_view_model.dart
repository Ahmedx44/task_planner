import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/app/locator.dart';
import 'package:todo_app/model/login_model.dart';
import 'package:todo_app/service/auth_service.dart';

class LoginViewModel extends BaseViewModel {
  void navigatetosignup(BuildContext context) {
    context.go('/signup');
  }

  Future<void> login(LoginModel loginModel, BuildContext context) async {
    setBusy(true);
    final result = await locator<AuthService>().login(
        LoginModel(email: loginModel.email, password: loginModel.password));

    result.fold((error) {
      setBusy(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        content: Text(error),
      ));
    }, (success) {
      context.go('/home');
      setBusy(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        content: Text(success),
      ));
    });
  }

  Future<void> googleSignin(BuildContext context) async {
    setBusy(true);
    final result = await locator<AuthService>().signinWithGoogle();

    result.fold((error) {
      setBusy(false);
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1), content: Text(error.toString())));
    }, (success) {
      context.go('/home');
      setBusy(false);
      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 1),
          content: Text('User Sucessfully Logged in')));
    });
  }
}

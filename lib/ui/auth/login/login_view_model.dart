import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:go_router/go_router.dart';

class LoginViewModel extends BaseViewModel {
  void navigatetosignup(BuildContext context) {
    context.go('/signup');
  }
}

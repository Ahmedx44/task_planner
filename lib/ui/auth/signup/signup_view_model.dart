import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

class SignupViewModel extends BaseViewModel {
  void navigatetologin(BuildContext context) {
    context.go('/login');
  }
}

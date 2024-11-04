import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

class OnboardingViewModel extends BaseViewModel {
  void navigatetosignup(BuildContext context) {
    context.go('/signup');
  }
}

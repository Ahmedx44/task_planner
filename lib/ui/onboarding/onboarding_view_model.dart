import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class OnboardingViewModel extends BaseViewModel {
  void navigatetosignup(BuildContext context) {
    context.go('/login');
  }

  void firstTimeLoading() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('started', true);
  }
}

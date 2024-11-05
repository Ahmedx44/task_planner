import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/ui/auth/autGate/auth_gate_view_model.dart';
import 'package:todo_app/ui/auth/login/login_view.dart';
import 'package:todo_app/ui/home/home_view.dart';
import 'package:todo_app/ui/onboarding/onboarding_view.dart';

class AuthgateView extends StatelessWidget {
  const AuthgateView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthGateViewModel>.reactive(
      viewModelBuilder: () => AuthGateViewModel(),
      builder: (context, viewModel, child) {
        return StreamBuilder<User?>(
          stream: viewModel.userStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold();
            }
            if (snapshot.hasData) {
              return const HomeView();
            } else {
              // Check if it's the user's first time using the app
              return FutureBuilder<bool>(
                future: viewModel.getFirstTime(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Scaffold();
                  }
                  // Show OnboardingView if it's the user's first time; otherwise, show LoginView
                  return snapshot.data == true
                      ? const LoginView()
                      : const OnboardingView();
                },
              );
            }
          },
        );
      },
    );
  }
}

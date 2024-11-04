import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/theme/theme.dart';
import 'package:todo_app/ui/auth/login/login_view.dart';
import 'package:todo_app/ui/auth/signup/signup_view.dart';
import 'package:todo_app/ui/onboarding/onboarding_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const OnboardingView(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupView(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginView(),
    )
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}

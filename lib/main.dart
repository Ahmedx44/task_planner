import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/app/locator.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/theme/theme.dart';
import 'package:todo_app/ui/auth/login/login_view.dart';
import 'package:todo_app/ui/auth/signup/signup_view.dart';
import 'package:todo_app/ui/onboarding/onboarding_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupLocator();
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

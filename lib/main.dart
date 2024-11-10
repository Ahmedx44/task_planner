import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:todo_app/app/locator.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/theme/theme.dart';
import 'package:todo_app/ui/auth/autGate/authGate_view.dart';
import 'package:todo_app/ui/auth/login/login_view.dart';
import 'package:todo_app/ui/auth/signup/signup_view.dart';
import 'package:todo_app/ui/home/home_view.dart';
import 'package:todo_app/ui/licenese/licenses.dart';
import 'package:todo_app/ui/onboarding/onboarding_view.dart';
import 'package:todo_app/ui/task_detail/task_detail_view.dart';

void main() async {
  await ThemeManager.initialise();
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
      builder: (context, state) => const AuthgateView(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupView(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingView(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: '/task_detail',
      builder: (BuildContext context, GoRouterState state) {
        final task = state.extra as TaskModel;
        return TaskDetailView(task: task);
      },
    ),
    GoRoute(
      path: '/license',
      builder: (context, state) {
        return PackagesPage();
      },
    )
  ]);

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      darkTheme: darkMode,
      lightTheme: lightMode,
      builder: (context, theme, darkTheme, themeMode) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
          theme: theme, // Light theme provided by ThemeBuilder
          darkTheme: darkTheme, // Dark theme provided by ThemeBuilder
          themeMode: themeMode, // ThemeMode provided by ThemeBuilder
        );
      },
    );
  }
}

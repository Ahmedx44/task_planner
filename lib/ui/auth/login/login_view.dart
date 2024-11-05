import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/model/login_model.dart';
import 'package:todo_app/ui/auth/login/login_view_model.dart';

class LoginView extends HookWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, viewModel, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.05,
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                    const Text(
                      'Welcome back, login to continue',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.04,
                    ),

                    // Email Text Field
                    const Text(
                      'Email',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.01,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'example@gmail.com',
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: Icon(
                          CupertinoIcons.mail,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 0.2,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                      ),
                    ),

                    // Password Text Field
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.02,
                    ),
                    const Text(
                      'Password',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.01,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: Icon(
                          Icons.lock_outline_rounded,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        suffixIcon: const Icon(CupertinoIcons.eye_slash),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 0.2,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                      ),
                    ),

                    // Forgot Password
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.01,
                    ),
                    const _ForgotPassword(),

                    // Login Button
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.04,
                    ),
                    GestureDetector(
                      onTap: () {
                        viewModel.login(
                          LoginModel(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                          context,
                        );
                      },
                      child: Center(
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.7,
                          height: MediaQuery.sizeOf(context).height * 0.065,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: Center(
                            child: viewModel.isBusy
                                ? SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  )
                                : Text(
                                    'Login',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),

                    // Social Login
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.04,
                    ),
                    const _OrDivider(),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.04,
                    ),
                    SocialLoginButton(
                      borderRadius: 30,
                      backgroundColor: Theme.of(context).colorScheme.onSurface,
                      textColor: Theme.of(context).colorScheme.onSecondary,
                      buttonType: SocialLoginButtonType.google,
                      onPressed: () async {
                        await viewModel.googleSignin(context);
                      },
                    ),

                    // Sign Up Prompt
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            viewModel.navigatetosignup(context);
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Forgot Password Text
class _ForgotPassword extends StatelessWidget {
  const _ForgotPassword();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Forgot Password?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

// OR Divider
class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),
        ),
        Text(
          'OR',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),
        ),
      ],
    );
  }
}

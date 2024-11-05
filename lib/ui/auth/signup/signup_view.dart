import 'package:flagkit/flagkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:phonenumbers/phonenumbers.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/model/signup_model.dart';
import 'package:todo_app/ui/auth/signup/signup_view_model.dart';

class SignupView extends HookWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = useTextEditingController();
    final emailController = useTextEditingController();
    final phonenumberController =
        useMemoized(() => PhoneNumberEditingController());
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SignupViewModel(),
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
                      height: MediaQuery.sizeOf(context).height * 0.01,
                    ),
                    Text(
                      'Sign up',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                    const Text(
                      'Create account for Free',
                      style: TextStyle(fontSize: 16),
                    ),

                    // USERNAME
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.03,
                    ),
                    const Text(
                      'Username',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.01,
                    ),
                    _UsernameTextField(usernameController),

                    // EMAIL
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.03,
                    ),
                    const Text(
                      'Email',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.01,
                    ),
                    _EmailTextField(emailController),

                    // PHONE NUMBER
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.02,
                    ),
                    const Text(
                      'Phone number',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.01,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: PhoneNumberField(
                            controller: phonenumberController,
                            dialogTitle: 'Phone number',
                            prefixBuilder: (context, country) {
                              if (country != null) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Flag(country.code, size: 20),
                                );
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            countryCodeWidth:
                                MediaQuery.sizeOf(context).width * 0.25,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // PASSWORD
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.01,
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
                      obscureText: viewModel.obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: Icon(
                          Icons.lock_outline_rounded,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            viewModel.togglePasswordVisibility();
                          },
                          icon: viewModel.obscurePassword
                              ? const Icon(CupertinoIcons.eye)
                              : const Icon(CupertinoIcons.eye_slash),
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
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.01,
                    ),

                    //Confirm Password
                    const Text(
                      'Confirm Password',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.01,
                    ),

                    TextField(
                      controller: confirmPasswordController,
                      obscureText: viewModel.obscureConfirmPassword,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: Icon(
                          Icons.lock_outline_rounded,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            viewModel.toggleConfirmPasswordVisibility();
                          },
                          icon: viewModel.obscureConfirmPassword
                              ? const Icon(CupertinoIcons.eye)
                              : const Icon(CupertinoIcons.eye_slash),
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

                    // FORGOT PASSWORD
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.01,
                    ),
                    _ForgotPassword(),

                    // SIGNUP BUTTON
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.04,
                    ),
                    GestureDetector(
                      onTap: () {
                        viewModel.signup(
                            SignupModel(
                                email: emailController.text,
                                username: usernameController.text,
                                phonenumber:
                                    phonenumberController.value.toString(),
                                password: passwordController.text,
                                confirmPassword:
                                    confirmPasswordController.text),
                            context);
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
                                    width: 5,
                                    height: 5,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      strokeAlign: 2,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  )
                                : Text(
                                    'Signup',
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

                    // SOCIAL SIGNUP
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.02,
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
                      onPressed: () {
                        viewModel.googleSignin(context);
                      },
                    ),

                    // LOGIN
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You don\'t have an Account?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            viewModel.navigateToLogin(context);
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
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

// Username TextField
class _UsernameTextField extends StatelessWidget {
  final controller;
  const _UsernameTextField(this.controller);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Your username',
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Icon(
          CupertinoIcons.person,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            width: 0.2,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}

// Email TextField
class _EmailTextField extends StatelessWidget {
  final controller;
  const _EmailTextField(this.controller);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}

// Forgot Password Text
class _ForgotPassword extends StatelessWidget {
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

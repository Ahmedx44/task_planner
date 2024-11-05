import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/model/login_model.dart';
import 'package:todo_app/model/signup_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<Either<String, String>> login(LoginModel loginModel);
  Future<Either<String, String>> signup(SignupModel signupModel);
}

@LazySingleton(as: AuthService)
class AuthServiceImpl extends AuthService {
  @override
  Future<Either<String, String>> login(LoginModel loginModel) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginModel.email, password: loginModel.password);

      return const Right('Sucessfully logged in');
    } catch (e) {
      return const Left('Something went wrong,Try again');
    }
  }

  @override
  Future<Either<String, String>> signup(SignupModel signupModel) async {
    try {
      final UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: signupModel.email, password: signupModel.password);

      await FirebaseFirestore.instance.collection(user.user!.uid).add({
        'username': signupModel.username,
        'email': signupModel.email,
        'phone_number': signupModel.phonenumber
      });

      return const Right('User Succesfully Created');
    } catch (e) {
      return Left(e.toString());
    }
  }
}

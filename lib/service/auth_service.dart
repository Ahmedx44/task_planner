import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/model/login_model.dart';
import 'package:todo_app/model/signup_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthService {
  Future<Either<String, String>> login(LoginModel loginModel);
  Future<Either<String, String>> signup(SignupModel signupModel);
  Future<Either<String, String>> signinWithGoogle();
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

      await FirebaseFirestore.instance
          .collection('User')
          .doc(user.user!.uid)
          .set({
        'username': signupModel.username,
        'email': signupModel.email,
        'phone_number': signupModel.phonenumber
      });

      return const Right('User Succesfully Created');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> signinWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount == null) {
        return const Left('Google sign-in was canceled');
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? userDetail = result.user;

      if (userDetail != null) {
        Map<String, dynamic> userInfoMap = {
          'email': userDetail.email,
          'fullName': userDetail.displayName,
        };

        await FirebaseFirestore.instance
            .collection('User')
            .doc(userDetail.uid)
            .set(userInfoMap, SetOptions(merge: true));

        return const Right('Successfully signed in with Google');
      } else {
        return const Left('Failed to sign in with Google');
      }
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'Google Sign-In failed');
    } catch (e) {
      return Left(e.toString());
    }
  }
}

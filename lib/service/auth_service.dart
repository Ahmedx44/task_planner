import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/model/login_model.dart';
import 'package:todo_app/model/signup_model.dart';

abstract class AuthService {
  Future<Either<String, String>> login(LoginModel loginModel);
  Future<Either<String, String>> signup(SignupModel signupModel);
  Future<Either<String, String>> signinWithGoogle();
  Future<Either<String, String>> logout();
  Future<Either<String, String>> deleteAccount();
  Future<Either<String, String>> reauthenticateUser(String password);
}

@LazySingleton(as: AuthService)
class AuthServiceImpl extends AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Either<String, String>> login(LoginModel loginModel) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: loginModel.email, password: loginModel.password);

      return const Right('Successfully logged in');
    } catch (e) {
      return const Left('Something went wrong, try again');
    }
  }

  @override
  Future<Either<String, String>> signup(SignupModel signupModel) async {
    try {
      final UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: signupModel.email, password: signupModel.password);

      await _firestore.collection('User').doc(user.user!.uid).set({
        'username': signupModel.username,
        'email': signupModel.email,
        'phone_number': signupModel.phonenumber
      });

      return const Right('User successfully created');
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

      UserCredential result = await _auth.signInWithCredential(credential);
      User? userDetail = result.user;

      if (userDetail != null) {
        Map<String, dynamic> userInfoMap = {
          'email': userDetail.email,
          'fullName': userDetail.displayName,
        };

        await _firestore
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

  @override
  Future<Either<String, String>> logout() async {
    try {
      await _auth.signOut();
      return const Right('Successfully logged out');
    } catch (e) {
      return Left('Logout failed: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, String>> deleteAccount() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) return const Left('No user logged in');

      final userId = user.uid;

      await _firestore.collection('User').doc(userId).delete();

      await user.delete();

      return const Right('Account deleted successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        return const Left('Please reauthenticate and try again');
      }
      return Left('Error deleting account: ${e.message}');
    } catch (e) {
      return Left('Error deleting account: ${e.toString()}');
    }
  }

  Future<Either<String, String>> reauthenticateUser(String password) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) return const Left('No user logged in');

      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );

      await user.reauthenticateWithCredential(credential);

      return const Right('Reauthenticated successfully');
    } on FirebaseAuthException catch (e) {
      return Left('Reauthentication failed: ${e.message}');
    }
  }
}

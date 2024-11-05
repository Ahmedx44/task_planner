import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class AuthGateViewModel extends BaseViewModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Stream of the current user
  Stream<User?> get userStream => _firebaseAuth.authStateChanges();

  Future<bool> getFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('started') ?? false;
  }
}

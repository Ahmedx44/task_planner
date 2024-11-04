import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class AuthService {
  Future<Either<String, String>> login();
  Future<Either<String, String>> signup();
}

@LazySingleton(as: AuthService)
class AuthServiceImpl extends AuthService {
  @override
  Future<Either<String, String>> login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> signup() {
    // TODO: implement signup
    throw UnimplementedError();
  }
}

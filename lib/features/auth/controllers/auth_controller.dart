import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/auth_repository.dart';

class AuthController {
  final AuthRepository repository;

  AuthController(this.repository);

  Future<UserCredential> signInWithGoogle() async {
    return await repository.signInWithGoogle();
  }

  Future<UserCredential> signInAsGuest() async {
    return await repository.signInAsGuest();
  }
}                        
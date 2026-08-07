import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_service.dart';

class AuthRepository {
  final AuthService service;

  AuthRepository(this.service);

  Future<UserCredential> signInWithGoogle() async {
    return await service.signInWithGoogle();
  }

  Future<UserCredential> signInAsGuest() async {
    return await service.signInAsGuest();
  }

  Future<void> signOut() async {
    await service.signOut();
  }
}
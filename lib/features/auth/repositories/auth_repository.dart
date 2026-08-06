import '../services/auth_service.dart';
class AuthRepository {
  final AuthService service;

  AuthRepository(this.service);

  Future<void> signInWithGoogle() async {}

  Future<void> signInAsGuest() async {}

  Future<void> signOut() async {}
}
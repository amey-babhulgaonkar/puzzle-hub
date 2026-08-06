import '../repositories/auth_repository.dart';
class AuthController {
  final AuthRepository repository;

  AuthController(this.repository);

  Future<void> signInWithGoogle() async {}

  Future<void> signInAsGuest() async {}
}
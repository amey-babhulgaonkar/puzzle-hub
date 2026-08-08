import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import '../repositories/auth_repository.dart';
import '../repositories/user_repository.dart';

class AuthController {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  AuthController(
    this.authRepository,
    this.userRepository,
  );

  Future<bool> signInWithGoogle() async {
    await authRepository.signInWithGoogle();

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('Authentication failed.');
    }

    final existingUser = await userRepository.getUser(user.uid);

if (existingUser != null) {
  return existingUser.username != null;
}

    final newUser = UserModel(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
      username: null,
      createdAt: DateTime.now(),
    );

    await userRepository.createUser(newUser);

    return false;
  }

  Future<void> signInAsGuest() async {
    await authRepository.signInAsGuest();
  }

  Future<void> signOut() async {
    await authRepository.signOut();
  }

  Future<void> saveUsername(String username) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('No authenticated user found.');
    }

    final normalizedUsername = username.trim().toLowerCase();

    if (normalizedUsername.isEmpty) {
      throw Exception('Username cannot be empty.');
    }

    final available =
        await userRepository.isUsernameAvailable(normalizedUsername);

    if (!available) {
      throw Exception('Username is already taken.');
    }

    await userRepository.updateUsername(
      user.uid,
      normalizedUsername,
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';

import 'package:puzzle_hub/features/auth/services/user_service.dart';

class SplashController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = UserService();

  Future<SplashDestination> determineDestination() async {
    final user = _auth.currentUser;

    // No authenticated user.
    if (user == null) {
      return SplashDestination.login;
    }

    // User is authenticated, so check their Firestore profile.
    final profile = await _userService.getUser(user.uid);

    // Profile doesn't exist.
    // This shouldn't normally happen, but send them through onboarding.
    if (profile == null) {
      return SplashDestination.username;
    }

    // Profile exists but username hasn't been selected yet.
    if (profile.username == null || profile.username!.isEmpty) {
      return SplashDestination.username;
    }

    // Fully onboarded user.
    return SplashDestination.home;
  }
}

enum SplashDestination {
  login,
  username,
  home,
}
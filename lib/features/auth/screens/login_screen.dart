import 'package:flutter/material.dart';
import 'package:puzzle_hub/app/theme/app_colors.dart';

import 'package:puzzle_hub/features/auth/controllers/auth_controller.dart';
import 'package:puzzle_hub/features/auth/repositories/auth_repository.dart';
import 'package:puzzle_hub/features/auth/services/auth_service.dart';

import 'package:puzzle_hub/features/auth/widgets/google_sign_in_button.dart';
import 'package:puzzle_hub/features/auth/widgets/guest_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:puzzle_hub/shared/widgets/app_animated_entrance.dart';
import 'package:puzzle_hub/shared/widgets/app_logo.dart';
import 'package:puzzle_hub/features/auth/repositories/user_repository.dart';
import 'package:puzzle_hub/features/auth/services/user_service.dart';
import 'package:go_router/go_router.dart';
import 'package:puzzle_hub/app/router/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final AuthController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AuthController(
  AuthRepository(
    AuthService(),
  ),
  UserRepository(
    UserService(),
  ),
);
  }

 Future<void> _handleGoogleSignIn() async {
  try {
    final isExistingUser = await _controller.signInWithGoogle();

    if (!mounted) return;

    if (isExistingUser) {
      context.go(AppRoutes.home);
    } else {
      context.go(AppRoutes.username);
    }
  } on GoogleSignInException catch (e) {
    // User cancelled the Google account picker.
    // Do nothing and remain on the login screen.
    if (e.code == GoogleSignInExceptionCode.canceled) {
      return;
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          e.description ?? 'Google Sign-In failed.',
        ),
      ),
    );
  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Something went wrong. Please try again.'),
      ),
    );
  }
}

  Future<void> _handleGuestSignIn() async {
    try {
      await _controller.signInAsGuest();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Signed in as Guest!"),
        ),
      );


    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF121212),
              Color(0xFF1A1730),
              Color(0xFF121212),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [
                const Spacer(flex: 3),

                const AppAnimatedEntrance(
                  child: AppLogo(),
                ),

                const SizedBox(height: 28),

                AppAnimatedEntrance(
                  delay: 150,
                  child: Text(
                    "Think. Solve. Repeat.",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white70,
                          letterSpacing: 1,
                        ),
                  ),
                ),

                const Spacer(flex: 2),

                AppAnimatedEntrance(
                  delay: 300,
                  child: GoogleSignInButton(
                    onPressed: _handleGoogleSignIn,
                  ),
                ),

                const SizedBox(height: 18),

                AppAnimatedEntrance(
                  delay: 450,
                  child: GuestButton(
                    onPressed: _handleGuestSignIn,
                  ),
                ),

                const SizedBox(height: 40),

                AppAnimatedEntrance(
                  delay: 600,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white54,
                          ),
                      children: const [
                        TextSpan(
                          text: "By continuing you agree to our\n",
                        ),
                        TextSpan(
                          text: "Terms",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: " & ",
                        ),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
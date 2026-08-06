import 'package:flutter/material.dart';
import 'package:puzzle_hub/features/auth/widgets/google_sign_in_button.dart';
import 'package:puzzle_hub/features/auth/widgets/guest_button.dart';
import 'package:puzzle_hub/shared/widgets/app_animated_entrance.dart';
import 'package:puzzle_hub/shared/widgets/app_logo.dart';
import 'package:puzzle_hub/app/theme/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                    onPressed: () {
                      // TODO: Firebase Google Sign-In
                    },
                  ),
                ),

                const SizedBox(height: 18),

                AppAnimatedEntrance(
                  delay: 450,
                  child: GuestButton(
                    onPressed: () {
                      // TODO: Guest Login
                    },
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
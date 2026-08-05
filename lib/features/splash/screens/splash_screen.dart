import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:puzzle_hub/app/theme/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
          child: Column(
  children: [
    const Spacer(flex: 3),

    Image.asset(
      'assets/branding/logo_full.png',
      width: 200,
    ),

    const SizedBox(height: 36),

    Text(
      "Think. Solve. Repeat.",
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white70,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
    ),

    const Spacer(flex: 2),

    LoadingAnimationWidget.staggeredDotsWave(
      color: AppColors.primary,
      size: 45,
    ),

    const SizedBox(height: 70),
  ],
),
        ),
      ),
    );
  }
}
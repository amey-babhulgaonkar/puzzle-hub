import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:puzzle_hub/app/router/app_routes.dart';
import 'package:puzzle_hub/app/theme/app_colors.dart';
import 'package:puzzle_hub/features/splash/controllers/splash_controller.dart';
import 'package:puzzle_hub/shared/widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  final SplashController _splashController = SplashController();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.92,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();

    _initializeSplash();
  }

  Future<void> _initializeSplash() async {
    final destinationFuture =
        _splashController.determineDestination();

    // Keep the splash visible for at least 2.5 seconds.
    final minimumSplashTime = Future.delayed(
      const Duration(milliseconds: 2500),
    );

    try {
      final results = await Future.wait([
        destinationFuture,
        minimumSplashTime,
      ]);

      if (!mounted) return;

      final destination = results[0] as SplashDestination;

      switch (destination) {
        case SplashDestination.login:
          context.go(AppRoutes.login);
          break;

        case SplashDestination.username:
          context.go(AppRoutes.username);
          break;

        case SplashDestination.home:
          context.go(AppRoutes.home);
          break;
      }
    } catch (e) {
      if (!mounted) return;

      // If something goes wrong while checking the user's profile,
      // send them to login rather than leaving the app stuck on splash.
      context.go(AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                children: [
                  const Spacer(flex: 3),

                  const AppLogo(
                    widthFactor: 0.60,
                  ),

                  const SizedBox(height: 36),

                  Text(
                    'Think. Solve. Repeat.',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
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
        ),
      ),
    );
  }
}
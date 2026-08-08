import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:puzzle_hub/app/router/app_routes.dart';
import 'package:puzzle_hub/features/auth/controllers/auth_controller.dart';
import 'package:puzzle_hub/features/auth/repositories/auth_repository.dart';
import 'package:puzzle_hub/features/auth/repositories/user_repository.dart';
import 'package:puzzle_hub/features/auth/services/auth_service.dart';
import 'package:puzzle_hub/features/auth/services/user_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final AuthController _controller;
  bool _isLoggingOut = false;

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

  Future<void> _logout() async {
    setState(() {
      _isLoggingOut = true;
    });

    try {
      await _controller.signOut();

      if (!mounted) return;

      context.go(AppRoutes.login);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoggingOut = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceFirst('Exception: ', ''),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: _isLoggingOut ? null : _logout,
                icon: _isLoggingOut
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.logout_rounded),
                label: Text(
                  _isLoggingOut ? 'Logging out...' : 'Log Out',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:puzzle_hub/app/router/app_routes.dart';
import 'package:puzzle_hub/app/theme/app_colors.dart';
import 'package:puzzle_hub/features/auth/controllers/auth_controller.dart';
import 'package:puzzle_hub/features/auth/repositories/auth_repository.dart';
import 'package:puzzle_hub/features/auth/repositories/user_repository.dart';
import 'package:puzzle_hub/features/auth/services/auth_service.dart';
import 'package:puzzle_hub/features/auth/services/user_service.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  late final AuthController _controller;

  final TextEditingController _usernameController =
      TextEditingController();

  bool _isLoading = false;
  String? _usernameError;

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

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _saveUsername() async {
    final username = _usernameController.text.trim();

    // Clear previous error before checking again.
    setState(() {
      _usernameError = null;
    });

    if (username.isEmpty) {
      setState(() {
        _usernameError = 'Please enter a username.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _controller.saveUsername(username);

      if (!mounted) return;

      context.go(AppRoutes.home);
    } catch (e) {
      if (!mounted) return;

      final message = e.toString().replaceFirst('Exception: ', '');

      if (message == 'Username is already taken.') {
        setState(() {
          _usernameError = 'Username already taken.';
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _goBackToLogin() async {
    await _controller.signOut();

    if (!mounted) return;

    context.go(AppRoutes.login);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),

                IconButton(
                  onPressed: _isLoading ? null : _goBackToLogin,
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),

                const Spacer(flex: 2),

                const Text(
                  'Choose your username',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'This is how other players will see you.',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 36),

                TextField(
                  controller: _usernameController,
                  enabled: !_isLoading,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _saveUsername(),
                  onChanged: (_) {
                    if (_usernameError != null) {
                      setState(() {
                        _usernameError = null;
                      });
                    }
                  },
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter username',
                    hintStyle: const TextStyle(
                      color: Colors.white38,
                    ),
                    filled: true,
                    fillColor: Colors.white10,

                    errorText: _usernameError,
                    errorStyle: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 13,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: _usernameError != null
                            ? Colors.redAccent
                            : AppColors.primary,
                        width: 1.5,
                      ),
                    ),

                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Colors.redAccent,
                        width: 1.5,
                      ),
                    ),

                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Colors.redAccent,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _saveUsername,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor:
                          AppColors.primary.withValues(alpha: 0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),

                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
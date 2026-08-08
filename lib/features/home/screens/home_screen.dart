import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:puzzle_hub/app/router/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            context.go(AppRoutes.settings);
          },
          icon: const Icon(Icons.settings),
          label: const Text('Settings'),
        ),
      ),
    );
  }
}
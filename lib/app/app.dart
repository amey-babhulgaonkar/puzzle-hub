import 'package:flutter/material.dart';

import 'package:puzzle_hub/app/router/app_router.dart';
import 'package:puzzle_hub/app/theme/app_theme.dart';

class PuzzleHubApp extends StatelessWidget {
  const PuzzleHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Puzzle Hub',
      theme: AppTheme.darkTheme,
      routerConfig: AppRouter.router,
    );
  }
}
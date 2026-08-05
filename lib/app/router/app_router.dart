import 'package:go_router/go_router.dart';

import 'package:puzzle_hub/features/auth/screens/login_screen.dart';
import 'package:puzzle_hub/features/auth/screens/username_screen.dart';
import 'package:puzzle_hub/features/home/screens/home_screen.dart';
import 'package:puzzle_hub/features/profile/screens/profile_screen.dart';
import 'package:puzzle_hub/features/settings/screens/settings_screen.dart';
import 'package:puzzle_hub/features/leaderboard/screens/leaderboard_screen.dart';
import 'package:puzzle_hub/features/shop/screens/shop_screen.dart';
import 'package:puzzle_hub/features/daily_rewards/screens/daily_rewards_screen.dart';
import 'package:puzzle_hub/features/games/arrow_escape/screens/game_screen.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/settings',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/username',
        builder: (context, state) => const UsernameScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/leaderboard',
        builder: (context, state) => const LeaderboardScreen(),
      ),
      GoRoute(
        path: '/shop',
        builder: (context, state) => const ShopScreen(),
      ),
      GoRoute(
        path: '/daily-rewards',
        builder: (context, state) => const DailyRewardsScreen(),
      ),
      GoRoute(
        path: '/game',
        builder: (context, state) => const GameScreen(),
      ),
    ],
  );
}
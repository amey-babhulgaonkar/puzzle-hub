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
import 'package:puzzle_hub/features/splash/screens/splash_screen.dart';
import 'package:puzzle_hub/app/router/app_routes.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: AppRoutes.login, builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: AppRoutes.username,
        builder: (context, state) => const UsernameScreen(),
      ),
      GoRoute(path: AppRoutes.home, builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.leaderboard,
        builder: (context, state) => const LeaderboardScreen(),
      ),
      GoRoute(path: AppRoutes.shop, builder: (context, state) => const ShopScreen()),
      GoRoute(
        path: AppRoutes.dailyRewards,
        builder: (context, state) => const DailyRewardsScreen(),
      ),
      GoRoute(path: AppRoutes.game, builder: (context, state) => const GameScreen()),
    ],
  );
}

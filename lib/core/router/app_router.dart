import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/rules/presentation/screens/rules_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/game_setup/presentation/screens/game_setup_screen.dart';
import '../../features/categories/presentation/screens/categories_screen.dart';
import '../../features/custom_words/presentation/screens/custom_words_screen.dart';
import '../../features/gameplay/presentation/screens/gameplay_screen.dart';
import '../../features/scores/presentation/screens/round_score_screen.dart';
import '../../features/scores/presentation/screens/final_results_screen.dart';
import '../providers/global_providers.dart';

/// Route paths
class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String onboarding = '/onboarding';
  static const String rules = '/rules';
  static const String settings = '/settings';
  static const String setup = '/setup';
  static const String categories = '/setup/categories';
  static const String customWords = '/setup/custom-words';
  static const String game = '/game';
  static const String roundScore = '/game/round-score';
  static const String results = '/game/results';
}

/// GoRouter provider
final routerProvider = Provider<GoRouter>((ref) {
  final hasSeenOnboarding = ref.watch(hasSeenOnboardingProvider);

  return GoRouter(
    initialLocation: AppRoutes.home,
    redirect: (context, state) {
      if (!hasSeenOnboarding && state.matchedLocation != AppRoutes.onboarding) {
        return AppRoutes.onboarding;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.rules,
        builder: (context, state) => const RulesScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.setup,
        builder: (context, state) => const GameSetupScreen(),
      ),
      GoRoute(
        path: AppRoutes.categories,
        builder: (context, state) => const CategoriesScreen(),
      ),
      GoRoute(
        path: AppRoutes.customWords,
        builder: (context, state) => const CustomWordsScreen(),
      ),
      GoRoute(
        path: AppRoutes.game,
        builder: (context, state) => const GameplayScreen(),
      ),
      GoRoute(
        path: AppRoutes.roundScore,
        builder: (context, state) => const RoundScoreScreen(),
      ),
      GoRoute(
        path: AppRoutes.results,
        builder: (context, state) => const FinalResultsScreen(),
      ),
    ],
  );
});

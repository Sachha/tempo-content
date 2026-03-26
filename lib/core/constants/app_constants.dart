/// Application-wide constants
class AppConstants {
  AppConstants._();

  // App info
  static const String appName = 'Tempo';

  // SharedPreferences keys
  static const String keyHasSeenOnboarding = 'has_seen_onboarding';
  static const String keyLocale = 'locale';
  static const String keySoundEnabled = 'sound_enabled';
  static const String keyVibrationEnabled = 'vibration_enabled';
  static const String keyGameHistory = 'game_history';
  static const String keyCustomWords = 'custom_words';

  // Game defaults
  static const int defaultTimerDuration = 30; // seconds
  static const int defaultWordCount = 40;
  static const int defaultTeamCount = 2;
  static const int defaultRounds = 3;
  static const int minTeams = 2;
  static const int maxTeams = 8;

  // Picker options
  static const List<int> timerOptions = [15, 30, 45, 60, 90];
  static const List<int> roundOptions = [1, 2, 3, 4, 5];
  static const List<int> wordCountOptions = [20, 30, 40, 50];
  static const List<int> passPenaltyOptions = [0, 2, 3, 5, 10];
  static const int defaultPassPenalty = 0; // seconds

  // Round names (keys for i18n)
  static const List<String> roundTypes = [
    'describe', // Round 1: describe freely
    'oneWord', // Round 2: one word only
    'mime', // Round 3: mime / no words
  ];
}

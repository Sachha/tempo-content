import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import '../theme/app_theme.dart';

/// SharedPreferences instance — override in ProviderScope
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Initialize SharedPreferences in ProviderScope');
});

/// Theme data provider
final themeDataProvider = Provider<ThemeData>((ref) => AppTheme.darkTheme);

/// Current locale provider
final localeProvider = NotifierProvider<LocaleNotifier, Locale>(
  LocaleNotifier.new,
);

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    final prefs = ref.read(sharedPreferencesProvider);
    final code = prefs.getString(AppConstants.keyLocale) ?? 'fr';
    return Locale(code);
  }

  void setLocale(Locale locale) {
    final prefs = ref.read(sharedPreferencesProvider);
    prefs.setString(AppConstants.keyLocale, locale.languageCode);
    state = locale;
  }
}

/// Sound enabled provider
final soundEnabledProvider =
    NotifierProvider<SoundEnabledNotifier, bool>(SoundEnabledNotifier.new);

class SoundEnabledNotifier extends Notifier<bool> {
  @override
  bool build() {
    final prefs = ref.read(sharedPreferencesProvider);
    return prefs.getBool(AppConstants.keySoundEnabled) ?? true;
  }

  void toggle() {
    final prefs = ref.read(sharedPreferencesProvider);
    state = !state;
    prefs.setBool(AppConstants.keySoundEnabled, state);
  }
}

/// Vibration enabled provider
final vibrationEnabledProvider = NotifierProvider<VibrationEnabledNotifier, bool>(
  VibrationEnabledNotifier.new,
);

class VibrationEnabledNotifier extends Notifier<bool> {
  @override
  bool build() {
    final prefs = ref.read(sharedPreferencesProvider);
    return prefs.getBool(AppConstants.keyVibrationEnabled) ?? true;
  }

  void toggle() {
    final prefs = ref.read(sharedPreferencesProvider);
    state = !state;
    prefs.setBool(AppConstants.keyVibrationEnabled, state);
  }
}

/// Onboarding seen provider
final hasSeenOnboardingProvider =
    NotifierProvider<HasSeenOnboardingNotifier, bool>(
  HasSeenOnboardingNotifier.new,
);

class HasSeenOnboardingNotifier extends Notifier<bool> {
  @override
  bool build() {
    final prefs = ref.read(sharedPreferencesProvider);
    return prefs.getBool(AppConstants.keyHasSeenOnboarding) ?? false;
  }

  void markSeen() {
    final prefs = ref.read(sharedPreferencesProvider);
    state = true;
    prefs.setBool(AppConstants.keyHasSeenOnboarding, true);
  }
}

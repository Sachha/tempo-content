// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Tempo';

  @override
  String get homeSubtitle => 'The ultimate party game!';

  @override
  String get newGame => 'New Game';

  @override
  String get rules => 'Rules';

  @override
  String get settings => 'Settings';

  @override
  String get gameSetup => 'Game Setup';

  @override
  String get categories => 'Categories';

  @override
  String get customWords => 'Custom Words';

  @override
  String get game => 'Game';

  @override
  String get roundScore => 'Round Score';

  @override
  String get finalResults => 'Final Results';

  @override
  String get onboardingTitle => 'Welcome to Tempo!';

  @override
  String get onboardingDescription =>
      'Make your friends guess words through 3 rounds: describe, one word, and mime!';

  @override
  String get getStarted => 'Let\'s Go!';

  @override
  String get language => 'Language';

  @override
  String get sound => 'Sound';

  @override
  String get vibration => 'Vibration';

  @override
  String get teams => 'Teams';

  @override
  String get words => 'Words';

  @override
  String get timer => 'Timer';

  @override
  String get start => 'Start';

  @override
  String get next => 'Next';

  @override
  String get pass => 'Pass';

  @override
  String get correct => 'Correct!';

  @override
  String get round1Title => 'Round 1 — Describe';

  @override
  String get round1Description =>
      'Describe the word using as many words as you want, but without saying the word itself or any word from the same family!';

  @override
  String get round2Title => 'Round 2 — One Word';

  @override
  String get round2Description =>
      'You can only say ONE word to make your team guess. Choose wisely!';

  @override
  String get round3Title => 'Round 3 — Mime';

  @override
  String get round3Description =>
      'No words allowed! Use only gestures and mime to make your team guess.';

  @override
  String teamName(int number) {
    return 'Team $number';
  }

  @override
  String seconds(int count) {
    return '${count}s';
  }

  @override
  String wordCount(int count) {
    return '$count words';
  }

  @override
  String get playAgain => 'Play Again';

  @override
  String get backToHome => 'Back to Home';
}

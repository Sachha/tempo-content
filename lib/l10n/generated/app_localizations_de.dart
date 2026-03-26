// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Tempo';

  @override
  String get homeSubtitle => 'Das ultimative Partyspiel!';

  @override
  String get newGame => 'Neues Spiel';

  @override
  String get rules => 'Regeln';

  @override
  String get settings => 'Einstellungen';

  @override
  String get gameSetup => 'Spielkonfiguration';

  @override
  String get categories => 'Kategorien';

  @override
  String get customWords => 'Eigene Wörter';

  @override
  String get game => 'Spiel';

  @override
  String get roundScore => 'Rundenpunktzahl';

  @override
  String get finalResults => 'Endergebnis';

  @override
  String get onboardingTitle => 'Willkommen bei Tempo!';

  @override
  String get onboardingDescription =>
      'Lass deine Freunde Wörter erraten in 3 Runden: Beschreibung, ein Wort und Pantomime!';

  @override
  String get getStarted => 'Los geht\'s!';

  @override
  String get language => 'Sprache';

  @override
  String get sound => 'Ton';

  @override
  String get vibration => 'Vibration';

  @override
  String get teams => 'Teams';

  @override
  String get words => 'Wörter';

  @override
  String get timer => 'Timer';

  @override
  String get start => 'Starten';

  @override
  String get next => 'Weiter';

  @override
  String get pass => 'Passen';

  @override
  String get correct => 'Richtig!';

  @override
  String get round1Title => 'Runde 1 — Beschreibung';

  @override
  String get round1Description =>
      'Beschreibe das Wort mit so vielen Wörtern wie du willst, ohne das Wort selbst oder ein Wort der gleichen Familie zu sagen!';

  @override
  String get round2Title => 'Runde 2 — Ein Wort';

  @override
  String get round2Description =>
      'Du darfst nur EIN Wort sagen, um es erraten zu lassen. Wähle weise!';

  @override
  String get round3Title => 'Runde 3 — Pantomime';

  @override
  String get round3Description =>
      'Keine Wörter erlaubt! Benutze nur Gesten und Pantomime zum Erraten.';

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
    return '$count Wörter';
  }

  @override
  String get playAgain => 'Nochmal Spielen';

  @override
  String get backToHome => 'Zurück zum Start';
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Tempo';

  @override
  String get homeSubtitle => 'Het ultieme feestspel!';

  @override
  String get newGame => 'Nieuw Spel';

  @override
  String get rules => 'Regels';

  @override
  String get settings => 'Instellingen';

  @override
  String get gameSetup => 'Spelconfiguratie';

  @override
  String get categories => 'Categorieën';

  @override
  String get customWords => 'Eigen Woorden';

  @override
  String get game => 'Spel';

  @override
  String get roundScore => 'Rondescore';

  @override
  String get finalResults => 'Eindresultaten';

  @override
  String get onboardingTitle => 'Welkom bij Tempo!';

  @override
  String get onboardingDescription =>
      'Laat je vrienden woorden raden in 3 rondes: beschrijving, één woord en mime!';

  @override
  String get getStarted => 'Laten we gaan!';

  @override
  String get language => 'Taal';

  @override
  String get sound => 'Geluid';

  @override
  String get vibration => 'Vibratie';

  @override
  String get teams => 'Teams';

  @override
  String get words => 'Woorden';

  @override
  String get timer => 'Timer';

  @override
  String get start => 'Starten';

  @override
  String get next => 'Volgende';

  @override
  String get pass => 'Passen';

  @override
  String get correct => 'Correct!';

  @override
  String get round1Title => 'Ronde 1 — Beschrijving';

  @override
  String get round1Description =>
      'Beschrijf het woord met zoveel woorden als je wilt, zonder het woord zelf of een woord van dezelfde familie te zeggen!';

  @override
  String get round2Title => 'Ronde 2 — Eén Woord';

  @override
  String get round2Description =>
      'Je mag slechts ÉÉN woord zeggen om te laten raden. Kies verstandig!';

  @override
  String get round3Title => 'Ronde 3 — Mime';

  @override
  String get round3Description =>
      'Geen woorden toegestaan! Gebruik alleen gebaren en mime om te laten raden.';

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
    return '$count woorden';
  }

  @override
  String get playAgain => 'Opnieuw Spelen';

  @override
  String get backToHome => 'Terug naar Home';
}

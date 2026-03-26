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
  String get partyEdition => 'Feest Editie';

  @override
  String get newGame => 'Nieuw Spel';

  @override
  String get playNow => 'Spelen';

  @override
  String get rules => 'Regels';

  @override
  String get settings => 'Instellingen';

  @override
  String get gameSetup => 'Spelconfiguratie';

  @override
  String get setup => 'Instellingen';

  @override
  String get categories => 'Categorieën';

  @override
  String get category => 'Categorie';

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
  String get addTeam => 'Team toevoegen';

  @override
  String teamsAdded(int count) {
    return '$count Teams toegevoegd';
  }

  @override
  String get words => 'Woorden';

  @override
  String get timer => 'Timer';

  @override
  String get time => 'Tijd';

  @override
  String get rounds => 'Rondes';

  @override
  String get start => 'Starten';

  @override
  String get startGame => 'Spel Starten';

  @override
  String get next => 'Volgende';

  @override
  String get nextRound => 'Volgende Ronde';

  @override
  String get pass => 'Passen';

  @override
  String get skip => 'Overslaan';

  @override
  String get correct => 'Correct';

  @override
  String get paused => 'Gepauzeerd';

  @override
  String get resume => 'Hervatten';

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

  @override
  String get home => 'Home';

  @override
  String get seeResults => 'Resultaten Bekijken';

  @override
  String get winner => 'Winnaar!';

  @override
  String roundComplete(int number) {
    return 'Ronde $number voltooid';
  }

  @override
  String get getReady => 'Maak je klaar!';

  @override
  String roundOf(int current, int total) {
    return 'Ronde $current/$total';
  }

  @override
  String thisRound(int score) {
    return 'Deze ronde: +$score';
  }

  @override
  String get quitGame => 'Spel verlaten?';

  @override
  String get quitGameMessage =>
      'Weet je zeker dat je het huidige spel wilt verlaten?';

  @override
  String get cancel => 'Annuleren';

  @override
  String get quit => 'Verlaten';

  @override
  String get onboardingRoundsTitle => '3 Rondes';

  @override
  String get onboardingRoundsDescription =>
      'Elke ronde wordt moeilijker: vrij beschrijven, dan één woord, dan mime!';

  @override
  String get onboardingReadyTitle => 'Klaar om te spelen?';

  @override
  String get onboardingReadyDescription =>
      'Vorm je teams, kies je categorieën en laat het feest beginnen!';

  @override
  String get passPenalty => 'Passtraf';

  @override
  String get noPenalty => 'Geen';
}

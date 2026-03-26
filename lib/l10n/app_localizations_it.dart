// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Tempo';

  @override
  String get homeSubtitle => 'Il gioco di società definitivo!';

  @override
  String get partyEdition => 'Edizione Festa';

  @override
  String get newGame => 'Nuova Partita';

  @override
  String get playNow => 'Gioca';

  @override
  String get rules => 'Regole';

  @override
  String get settings => 'Impostazioni';

  @override
  String get gameSetup => 'Configurazione';

  @override
  String get setup => 'Configurazione';

  @override
  String get categories => 'Categorie';

  @override
  String get category => 'Categoria';

  @override
  String get customWords => 'Parole Personalizzate';

  @override
  String get game => 'Gioco';

  @override
  String get roundScore => 'Punteggio del Turno';

  @override
  String get finalResults => 'Risultati Finali';

  @override
  String get onboardingTitle => 'Benvenuto su Tempo!';

  @override
  String get onboardingDescription =>
      'Fai indovinare le parole ai tuoi amici in 3 turni: descrizione, una sola parola e mimo!';

  @override
  String get getStarted => 'Iniziamo!';

  @override
  String get language => 'Lingua';

  @override
  String get sound => 'Suono';

  @override
  String get vibration => 'Vibrazione';

  @override
  String get teams => 'Squadre';

  @override
  String get addTeam => 'Aggiungi squadra';

  @override
  String teamsAdded(int count) {
    return '$count Squadre aggiunte';
  }

  @override
  String get words => 'Parole';

  @override
  String get timer => 'Timer';

  @override
  String get time => 'Tempo';

  @override
  String get rounds => 'Turni';

  @override
  String get start => 'Inizia';

  @override
  String get startGame => 'Inizia Partita';

  @override
  String get next => 'Avanti';

  @override
  String get nextRound => 'Prossimo Turno';

  @override
  String get pass => 'Passa';

  @override
  String get skip => 'Salta';

  @override
  String get correct => 'Corretto';

  @override
  String get paused => 'In Pausa';

  @override
  String get resume => 'Riprendi';

  @override
  String get round1Title => 'Turno 1 — Descrizione';

  @override
  String get round1Description =>
      'Descrivi la parola usando tutte le parole che vuoi, senza dire la parola stessa o una della stessa famiglia!';

  @override
  String get round2Title => 'Turno 2 — Una Parola';

  @override
  String get round2Description =>
      'Puoi dire solo UNA parola per far indovinare. Scegli bene!';

  @override
  String get round3Title => 'Turno 3 — Mimo';

  @override
  String get round3Description =>
      'Nessuna parola consentita! Usa solo gesti e mimo per far indovinare.';

  @override
  String teamName(int number) {
    return 'Squadra $number';
  }

  @override
  String seconds(int count) {
    return '${count}s';
  }

  @override
  String wordCount(int count) {
    return '$count parole';
  }

  @override
  String get playAgain => 'Gioca Ancora';

  @override
  String get backToHome => 'Torna alla Home';

  @override
  String get home => 'Home';

  @override
  String get seeResults => 'Vedi Risultati';

  @override
  String get winner => 'Vincitore!';

  @override
  String roundComplete(int number) {
    return 'Turno $number completato';
  }

  @override
  String get getReady => 'Preparati!';

  @override
  String roundOf(int current, int total) {
    return 'Turno $current/$total';
  }

  @override
  String thisRound(int score) {
    return 'Questo turno: +$score';
  }

  @override
  String get quitGame => 'Uscire dal gioco?';

  @override
  String get quitGameMessage =>
      'Sei sicuro di voler uscire dalla partita in corso?';

  @override
  String get cancel => 'Annulla';

  @override
  String get quit => 'Esci';

  @override
  String get onboardingRoundsTitle => '3 Turni';

  @override
  String get onboardingRoundsDescription =>
      'Ogni turno è più difficile: descrivi liberamente, poi una parola, poi mima!';

  @override
  String get onboardingReadyTitle => 'Pronto a giocare?';

  @override
  String get onboardingReadyDescription =>
      'Forma le tue squadre, scegli le categorie e che il divertimento abbia inizio!';

  @override
  String get passPenalty => 'Penalità passo';

  @override
  String get noPenalty => 'Nessuna';
}

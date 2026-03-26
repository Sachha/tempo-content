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
  String get newGame => 'Nuova Partita';

  @override
  String get rules => 'Regole';

  @override
  String get settings => 'Impostazioni';

  @override
  String get gameSetup => 'Configurazione';

  @override
  String get categories => 'Categorie';

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
  String get words => 'Parole';

  @override
  String get timer => 'Timer';

  @override
  String get start => 'Inizia';

  @override
  String get next => 'Avanti';

  @override
  String get pass => 'Passa';

  @override
  String get correct => 'Corretto!';

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
}

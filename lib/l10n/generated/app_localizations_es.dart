// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Tempo';

  @override
  String get homeSubtitle => '¡El juego de fiesta definitivo!';

  @override
  String get newGame => 'Nueva Partida';

  @override
  String get rules => 'Reglas';

  @override
  String get settings => 'Ajustes';

  @override
  String get gameSetup => 'Configuración';

  @override
  String get categories => 'Categorías';

  @override
  String get customWords => 'Palabras Personalizadas';

  @override
  String get game => 'Juego';

  @override
  String get roundScore => 'Puntuación de la Ronda';

  @override
  String get finalResults => 'Resultados Finales';

  @override
  String get onboardingTitle => '¡Bienvenido a Tempo!';

  @override
  String get onboardingDescription =>
      '¡Haz que tus amigos adivinen palabras en 3 rondas: descripción, una sola palabra y mímica!';

  @override
  String get getStarted => '¡Vamos!';

  @override
  String get language => 'Idioma';

  @override
  String get sound => 'Sonido';

  @override
  String get vibration => 'Vibración';

  @override
  String get teams => 'Equipos';

  @override
  String get words => 'Palabras';

  @override
  String get timer => 'Temporizador';

  @override
  String get start => 'Empezar';

  @override
  String get next => 'Siguiente';

  @override
  String get pass => 'Pasar';

  @override
  String get correct => '¡Correcto!';

  @override
  String get round1Title => 'Ronda 1 — Descripción';

  @override
  String get round1Description =>
      '¡Describe la palabra usando todas las palabras que quieras, sin decir la palabra en sí ni ninguna de la misma familia!';

  @override
  String get round2Title => 'Ronda 2 — Una Palabra';

  @override
  String get round2Description =>
      'Solo puedes decir UNA palabra para que adivinen. ¡Elige bien!';

  @override
  String get round3Title => 'Ronda 3 — Mímica';

  @override
  String get round3Description =>
      '¡No se permiten palabras! Usa solo gestos y mímica para que adivinen.';

  @override
  String teamName(int number) {
    return 'Equipo $number';
  }

  @override
  String seconds(int count) {
    return '${count}s';
  }

  @override
  String wordCount(int count) {
    return '$count palabras';
  }

  @override
  String get playAgain => 'Jugar de Nuevo';

  @override
  String get backToHome => 'Volver al Inicio';
}

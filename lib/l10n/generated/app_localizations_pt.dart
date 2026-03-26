// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Tempo';

  @override
  String get homeSubtitle => 'O jogo de festa definitivo!';

  @override
  String get newGame => 'Novo Jogo';

  @override
  String get rules => 'Regras';

  @override
  String get settings => 'Configurações';

  @override
  String get gameSetup => 'Configuração do Jogo';

  @override
  String get categories => 'Categorias';

  @override
  String get customWords => 'Palavras Personalizadas';

  @override
  String get game => 'Jogo';

  @override
  String get roundScore => 'Pontuação da Rodada';

  @override
  String get finalResults => 'Resultados Finais';

  @override
  String get onboardingTitle => 'Bem-vindo ao Tempo!';

  @override
  String get onboardingDescription =>
      'Faça seus amigos adivinharem palavras em 3 rodadas: descrição, uma palavra e mímica!';

  @override
  String get getStarted => 'Vamos Lá!';

  @override
  String get language => 'Idioma';

  @override
  String get sound => 'Som';

  @override
  String get vibration => 'Vibração';

  @override
  String get teams => 'Equipes';

  @override
  String get words => 'Palavras';

  @override
  String get timer => 'Cronômetro';

  @override
  String get start => 'Começar';

  @override
  String get next => 'Próximo';

  @override
  String get pass => 'Passar';

  @override
  String get correct => 'Correto!';

  @override
  String get round1Title => 'Rodada 1 — Descrição';

  @override
  String get round1Description =>
      'Descreva a palavra usando quantas palavras quiser, sem dizer a palavra em si ou da mesma família!';

  @override
  String get round2Title => 'Rodada 2 — Uma Palavra';

  @override
  String get round2Description =>
      'Você só pode dizer UMA palavra para fazer adivinhar. Escolha bem!';

  @override
  String get round3Title => 'Rodada 3 — Mímica';

  @override
  String get round3Description =>
      'Nenhuma palavra permitida! Use apenas gestos e mímica para fazer adivinhar.';

  @override
  String teamName(int number) {
    return 'Equipe $number';
  }

  @override
  String seconds(int count) {
    return '${count}s';
  }

  @override
  String wordCount(int count) {
    return '$count palavras';
  }

  @override
  String get playAgain => 'Jogar Novamente';

  @override
  String get backToHome => 'Voltar ao Início';
}

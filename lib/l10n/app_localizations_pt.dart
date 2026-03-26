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
  String get partyEdition => 'Edição Festa';

  @override
  String get newGame => 'Novo Jogo';

  @override
  String get playNow => 'Jogar';

  @override
  String get rules => 'Regras';

  @override
  String get settings => 'Configurações';

  @override
  String get gameSetup => 'Configuração do Jogo';

  @override
  String get setup => 'Configuração';

  @override
  String get categories => 'Categorias';

  @override
  String get category => 'Categoria';

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
  String get addTeam => 'Adicionar equipe';

  @override
  String teamsAdded(int count) {
    return '$count Equipes adicionadas';
  }

  @override
  String get words => 'Palavras';

  @override
  String get timer => 'Cronômetro';

  @override
  String get time => 'Tempo';

  @override
  String get rounds => 'Rodadas';

  @override
  String get start => 'Começar';

  @override
  String get startGame => 'Iniciar Jogo';

  @override
  String get next => 'Próximo';

  @override
  String get nextRound => 'Próxima Rodada';

  @override
  String get pass => 'Passar';

  @override
  String get skip => 'Pular';

  @override
  String get correct => 'Correto';

  @override
  String get paused => 'Pausado';

  @override
  String get resume => 'Continuar';

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

  @override
  String get home => 'Início';

  @override
  String get seeResults => 'Ver Resultados';

  @override
  String get winner => 'Vencedor!';

  @override
  String roundComplete(int number) {
    return 'Rodada $number concluída';
  }

  @override
  String get getReady => 'Prepare-se!';

  @override
  String roundOf(int current, int total) {
    return 'Rodada $current/$total';
  }

  @override
  String thisRound(int score) {
    return 'Esta rodada: +$score';
  }

  @override
  String get quitGame => 'Sair do jogo?';

  @override
  String get quitGameMessage => 'Tem certeza de que deseja sair do jogo atual?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get quit => 'Sair';

  @override
  String get onboardingRoundsTitle => '3 Rodadas';

  @override
  String get onboardingRoundsDescription =>
      'Cada rodada é mais difícil: descreva livremente, depois uma palavra, depois mímica!';

  @override
  String get onboardingReadyTitle => 'Pronto para jogar?';

  @override
  String get onboardingReadyDescription =>
      'Forme suas equipes, escolha suas categorias e que a diversão comece!';

  @override
  String get passPenalty => 'Penalidade passe';

  @override
  String get noPenalty => 'Nenhuma';
}

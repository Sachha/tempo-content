// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Tempo';

  @override
  String get homeSubtitle => 'Le jeu de soirée ultime !';

  @override
  String get partyEdition => 'Édition Soirée';

  @override
  String get newGame => 'Nouvelle Partie';

  @override
  String get playNow => 'Jouer';

  @override
  String get rules => 'Règles';

  @override
  String get settings => 'Paramètres';

  @override
  String get gameSetup => 'Configuration';

  @override
  String get setup => 'Config';

  @override
  String get categories => 'Catégories';

  @override
  String get category => 'Catégorie';

  @override
  String get customWords => 'Mots Personnalisés';

  @override
  String get game => 'Jeu';

  @override
  String get roundScore => 'Score de la Manche';

  @override
  String get finalResults => 'Résultats Finaux';

  @override
  String get onboardingTitle => 'Bienvenue sur Tempo !';

  @override
  String get onboardingDescription =>
      'Faites deviner des mots à vos amis en 3 manches : description, un seul mot et mime !';

  @override
  String get getStarted => 'C\'est Parti !';

  @override
  String get language => 'Langue';

  @override
  String get sound => 'Son';

  @override
  String get vibration => 'Vibration';

  @override
  String get teams => 'Équipes';

  @override
  String get addTeam => 'Ajouter équipe';

  @override
  String teamsAdded(int count) {
    return '$count Équipes ajoutées';
  }

  @override
  String get words => 'Mots';

  @override
  String get timer => 'Chrono';

  @override
  String get time => 'Temps';

  @override
  String get rounds => 'Manches';

  @override
  String get start => 'Commencer';

  @override
  String get startGame => 'Lancer la Partie';

  @override
  String get next => 'Suivant';

  @override
  String get nextRound => 'Manche Suivante';

  @override
  String get pass => 'Passer';

  @override
  String get skip => 'Passer';

  @override
  String get correct => 'Correct';

  @override
  String get paused => 'Pause';

  @override
  String get resume => 'Reprendre';

  @override
  String get round1Title => 'Manche 1 — Description';

  @override
  String get round1Description =>
      'Décrivez le mot en utilisant autant de mots que vous voulez, sans dire le mot lui-même ni un mot de la même famille !';

  @override
  String get round2Title => 'Manche 2 — Un Seul Mot';

  @override
  String get round2Description =>
      'Vous ne pouvez dire qu\'UN SEUL mot pour faire deviner. Choisissez bien !';

  @override
  String get round3Title => 'Manche 3 — Mime';

  @override
  String get round3Description =>
      'Aucun mot autorisé ! Utilisez uniquement les gestes et le mime pour faire deviner.';

  @override
  String teamName(int number) {
    return 'Équipe $number';
  }

  @override
  String seconds(int count) {
    return '${count}s';
  }

  @override
  String wordCount(int count) {
    return '$count mots';
  }

  @override
  String get playAgain => 'Rejouer';

  @override
  String get backToHome => 'Retour à l\'Accueil';

  @override
  String get home => 'Accueil';

  @override
  String get seeResults => 'Voir Résultats';

  @override
  String get winner => 'Vainqueur !';

  @override
  String roundComplete(int number) {
    return 'Manche $number terminée';
  }

  @override
  String get getReady => 'Préparez-vous !';

  @override
  String roundOf(int current, int total) {
    return 'Manche $current/$total';
  }

  @override
  String thisRound(int score) {
    return 'Cette manche : +$score';
  }

  @override
  String get quitGame => 'Quitter la partie ?';

  @override
  String get quitGameMessage =>
      'Êtes-vous sûr de vouloir quitter la partie en cours ?';

  @override
  String get cancel => 'Annuler';

  @override
  String get quit => 'Quitter';

  @override
  String get onboardingRoundsTitle => '3 Manches';

  @override
  String get onboardingRoundsDescription =>
      'Chaque manche est plus difficile : décrivez librement, puis un seul mot, puis mimez !';

  @override
  String get onboardingReadyTitle => 'Prêt à jouer ?';

  @override
  String get onboardingReadyDescription =>
      'Formez vos équipes, choisissez vos catégories et que la fête commence !';

  @override
  String get passPenalty => 'Pénalité passe';

  @override
  String get noPenalty => 'Aucune';
}

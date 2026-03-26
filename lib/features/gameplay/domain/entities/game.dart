import '../../../game_setup/domain/entities/team.dart';
import 'word.dart';

enum GameStatus { setup, playing, roundEnd, finished }

class Game {
  final String id;
  final List<Team> teams;
  final int currentRound;
  final int totalRounds;
  final int timerDuration;
  final List<Word> words;
  final int currentTeamIndex;
  final GameStatus status;

  const Game({
    required this.id,
    required this.teams,
    this.currentRound = 0,
    this.totalRounds = 3,
    this.timerDuration = 30,
    required this.words,
    this.currentTeamIndex = 0,
    this.status = GameStatus.setup,
  });

  Game copyWith({
    String? id,
    List<Team>? teams,
    int? currentRound,
    int? totalRounds,
    int? timerDuration,
    List<Word>? words,
    int? currentTeamIndex,
    GameStatus? status,
  }) =>
      Game(
        id: id ?? this.id,
        teams: teams ?? this.teams,
        currentRound: currentRound ?? this.currentRound,
        totalRounds: totalRounds ?? this.totalRounds,
        timerDuration: timerDuration ?? this.timerDuration,
        words: words ?? this.words,
        currentTeamIndex: currentTeamIndex ?? this.currentTeamIndex,
        status: status ?? this.status,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'teams': teams.map((t) => t.toMap()).toList(),
        'currentRound': currentRound,
        'totalRounds': totalRounds,
        'timerDuration': timerDuration,
        'words': words.map((w) => w.toMap()).toList(),
        'currentTeamIndex': currentTeamIndex,
        'status': status.name,
      };

  factory Game.fromMap(Map<String, dynamic> map) => Game(
        id: map['id'] as String,
        teams: (map['teams'] as List).map((t) => Team.fromMap(t as Map<String, dynamic>)).toList(),
        currentRound: map['currentRound'] as int,
        totalRounds: map['totalRounds'] as int,
        timerDuration: map['timerDuration'] as int,
        words: (map['words'] as List).map((w) => Word.fromMap(w as Map<String, dynamic>)).toList(),
        currentTeamIndex: map['currentTeamIndex'] as int,
        status: GameStatus.values.byName(map['status'] as String),
      );
}

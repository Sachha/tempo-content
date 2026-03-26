import '../../../game_setup/domain/entities/team.dart';

class GameResult {
  final String id;
  final List<Team> finalRanking;
  final DateTime playedAt;
  final int totalWords;

  const GameResult({
    required this.id,
    required this.finalRanking,
    required this.playedAt,
    required this.totalWords,
  });

  GameResult copyWith({
    String? id,
    List<Team>? finalRanking,
    DateTime? playedAt,
    int? totalWords,
  }) =>
      GameResult(
        id: id ?? this.id,
        finalRanking: finalRanking ?? this.finalRanking,
        playedAt: playedAt ?? this.playedAt,
        totalWords: totalWords ?? this.totalWords,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'finalRanking': finalRanking.map((t) => t.toMap()).toList(),
        'playedAt': playedAt.toIso8601String(),
        'totalWords': totalWords,
      };

  factory GameResult.fromMap(Map<String, dynamic> map) => GameResult(
        id: map['id'] as String,
        finalRanking: (map['finalRanking'] as List)
            .map((t) => Team.fromMap(t as Map<String, dynamic>))
            .toList(),
        playedAt: DateTime.parse(map['playedAt'] as String),
        totalWords: map['totalWords'] as int,
      );
}

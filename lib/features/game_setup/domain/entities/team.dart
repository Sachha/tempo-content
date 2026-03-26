class Team {
  final String id;
  final String name;
  final String color;
  final Map<int, int> scoreByRound;
  final int totalScore;

  const Team({
    required this.id,
    required this.name,
    required this.color,
    this.scoreByRound = const {},
    this.totalScore = 0,
  });

  Team copyWith({
    String? id,
    String? name,
    String? color,
    Map<int, int>? scoreByRound,
    int? totalScore,
  }) =>
      Team(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
        scoreByRound: scoreByRound ?? this.scoreByRound,
        totalScore: totalScore ?? this.totalScore,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'color': color,
        'scoreByRound': scoreByRound.map((k, v) => MapEntry(k.toString(), v)),
        'totalScore': totalScore,
      };

  factory Team.fromMap(Map<String, dynamic> map) => Team(
        id: map['id'] as String,
        name: map['name'] as String,
        color: map['color'] as String,
        scoreByRound: (map['scoreByRound'] as Map<String, dynamic>)
            .map((k, v) => MapEntry(int.parse(k), v as int)),
        totalScore: map['totalScore'] as int,
      );
}

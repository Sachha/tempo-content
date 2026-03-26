enum WordDifficulty { easy, medium, hard }

class Word {
  final String id;
  final String text;
  final String categoryId;
  final String language;
  final WordDifficulty difficulty;

  const Word({
    required this.id,
    required this.text,
    required this.categoryId,
    required this.language,
    required this.difficulty,
  });

  Word copyWith({
    String? id,
    String? text,
    String? categoryId,
    String? language,
    WordDifficulty? difficulty,
  }) =>
      Word(
        id: id ?? this.id,
        text: text ?? this.text,
        categoryId: categoryId ?? this.categoryId,
        language: language ?? this.language,
        difficulty: difficulty ?? this.difficulty,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'text': text,
        'categoryId': categoryId,
        'language': language,
        'difficulty': difficulty.name,
      };

  factory Word.fromMap(Map<String, dynamic> map) => Word(
        id: map['id'] as String,
        text: map['text'] as String,
        categoryId: map['categoryId'] as String,
        language: map['language'] as String,
        difficulty: WordDifficulty.values.byName(map['difficulty'] as String),
      );
}

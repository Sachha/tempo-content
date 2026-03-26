class Category {
  final String id;
  final String nameKey;
  final String emoji;
  final int wordCount;

  const Category({
    required this.id,
    required this.nameKey,
    required this.emoji,
    required this.wordCount,
  });

  Category copyWith({
    String? id,
    String? nameKey,
    String? emoji,
    int? wordCount,
  }) =>
      Category(
        id: id ?? this.id,
        nameKey: nameKey ?? this.nameKey,
        emoji: emoji ?? this.emoji,
        wordCount: wordCount ?? this.wordCount,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'nameKey': nameKey,
        'emoji': emoji,
        'wordCount': wordCount,
      };

  factory Category.fromMap(Map<String, dynamic> map) => Category(
        id: map['id'] as String,
        nameKey: map['nameKey'] as String,
        emoji: map['emoji'] as String,
        wordCount: map['wordCount'] as int,
      );
}

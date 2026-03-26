import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/word_repository.dart';
import '../../domain/entities/word.dart';

/// Repository provider
final wordRepositoryProvider = Provider<WordRepository>((ref) {
  return const WordRepository();
});

/// Provides all available words for a specific category and language.
final wordsByCategoryProvider =
    Provider.family<List<Word>, ({String categoryId, String language})>(
        (ref, params) {
  final repo = ref.read(wordRepositoryProvider);
  return repo.getWords(
    categoryIds: [params.categoryId],
    language: params.language,
    count: 999, // return all
  );
});

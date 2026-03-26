import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/category_repository.dart';
import '../../domain/entities/category.dart';

/// Repository provider
final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return const CategoryRepository();
});

/// Provides the full list of available categories
final categoriesProvider = Provider<List<Category>>((ref) {
  final repo = ref.read(categoryRepositoryProvider);
  return repo.getCategories();
});

/// Provides a single category by id
final categoryByIdProvider =
    Provider.family<Category?, String>((ref, id) {
  final repo = ref.read(categoryRepositoryProvider);
  return repo.getCategoryById(id);
});

/// Tracks which categories the user has selected for a game session
final selectedCategoryIdsProvider =
    NotifierProvider<SelectedCategoryIdsNotifier, List<String>>(
  SelectedCategoryIdsNotifier.new,
);

class SelectedCategoryIdsNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    // All categories selected by default
    final categories = ref.read(categoriesProvider);
    return categories.map((c) => c.id).toList();
  }

  void toggle(String categoryId) {
    if (state.contains(categoryId)) {
      state = state.where((id) => id != categoryId).toList();
    } else {
      state = [...state, categoryId];
    }
  }

  void selectAll() {
    final categories = ref.read(categoriesProvider);
    state = categories.map((c) => c.id).toList();
  }

  void clearAll() {
    state = [];
  }
}

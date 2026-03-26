import '../../domain/entities/category.dart';

class CategoryRepository {
  const CategoryRepository();

  List<Category> getCategories() {
    return const [
      Category(
        id: 'actors',
        nameKey: 'category_actors',
        emoji: '\uD83C\uDFAC',
        wordCount: 20,
      ),
      Category(
        id: 'animals',
        nameKey: 'category_animals',
        emoji: '\uD83D\uDC3E',
        wordCount: 20,
      ),
      Category(
        id: 'sports',
        nameKey: 'category_sports',
        emoji: '\u26BD',
        wordCount: 20,
      ),
      Category(
        id: 'food',
        nameKey: 'category_food',
        emoji: '\uD83C\uDF55',
        wordCount: 20,
      ),
      Category(
        id: 'history',
        nameKey: 'category_history',
        emoji: '\uD83D\uDCDC',
        wordCount: 20,
      ),
      Category(
        id: 'music',
        nameKey: 'category_music',
        emoji: '\uD83C\uDFB5',
        wordCount: 20,
      ),
      Category(
        id: 'science',
        nameKey: 'category_science',
        emoji: '\uD83D\uDD2C',
        wordCount: 20,
      ),
      Category(
        id: 'geography',
        nameKey: 'category_geography',
        emoji: '\uD83C\uDF0D',
        wordCount: 20,
      ),
    ];
  }

  Category? getCategoryById(String id) {
    final categories = getCategories();
    try {
      return categories.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }
}

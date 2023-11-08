import 'package:models/models.dart';

abstract class CategoryApiService {
  Future<Category> getCategoryByName(String name);

  Future<List<Category>> getAllCategoryList();

  Future<void> createCategory(Category category);

  Future<void> updateCategoryDescription(String name, String description);

  Future<void> updateCategoryName(String name, String newName);

  Future<void> deleteCategory(String name);

  Stream<Category> streamCategory(String name);
}

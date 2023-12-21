// ignore_for_file: public_member_api_docs

import 'package:models/models.dart';

abstract interface class CategoryApiService<T extends Category> {
  Future<T> getCategoryByName(String name);

  Future<List<T>> getAllCategoryList();

  Future<void> createCategory(Category category);

  Future<void> updateCategoryDescription(String name, String description);

  Future<void> updateCategoryName(String name, String newName);

  Future<void> deleteCategory(String name);

  Stream<T> streamCategory(String name);
}

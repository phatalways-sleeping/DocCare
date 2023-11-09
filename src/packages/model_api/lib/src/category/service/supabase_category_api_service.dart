import 'package:models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'category_api_service.dart';

class CategoryApi implements CategoryApiService<Category> {
  const CategoryApi({
    required this.supabase,
  });

  final SupabaseClient supabase;

  @override
  Future<Category> getCategoryByName(String name) => supabase
      .from('category')
      .select<PostgrestList>()
      .eq('name', name)
      .then(
        (value) => value.isEmpty
            ? throw Exception('No Category with name = $name found')
            : Category.fromJson(value.first),
      )
      .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<List<Category>> getAllCategoryList() => supabase
      .from('category')
      .select<PostgrestList>()
      .then(
        (value) => value.isEmpty
            ? throw Exception('No category found')
            : value.map(Category.fromJson).toList(),
      )
      .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> createCategory(Category Category) => supabase
      .from('category')
      .insert(
        Category.toJson(),
      )
      .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> updateCategoryDescription(String name, String description) =>
      supabase
          .from('category')
          .update({
            'description': description,
          })
          .eq('name', name)
          .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> updateCategoryName(String name, String newName) => supabase
      .from('category')
      .update({
        'name': newName,
      })
      .eq('name', name)
      .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> deleteCategory(String name) => supabase
      .from('category')
      .delete()
      .eq('name', name)
      .onError((error, stackTrace) => throw Exception(error));

  //Stream of a single Working Shift
  @override
  Stream<Category> streamCategory(String name) => supabase
      .from('category')
      .stream(primaryKey: ['name'])
      .eq('name', name)
      .map((event) => Category.fromJson(event.first));
}

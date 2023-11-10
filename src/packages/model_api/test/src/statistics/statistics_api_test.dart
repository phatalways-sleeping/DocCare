import 'package:flutter_test/flutter_test.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';


void main() {
  group('StatisticsApi', () {
    // Create a Supabase instance
    // final supabase = Supabase.instance.client;




    
    // final statisticsApi = StatisticsApi(supabase: supabase);

    // test('Initialize Supabase', () {
    //   // Can be created with a Supabase instance
    //   expect(StatisticsApi(supabase: supabase), isNotNull);
    // });

    // test('Initialize Statistics API', () {
    //   // The StatisticsApi should be created with a Supabase instance
    //   expect(statisticsApi, isNotNull);
    // });

    // // This test may change Database
    // test('Create and Retrieve Category', () async {
    //   // Sample data
    //   final name = 'TestCategory';
    //   final description = 'Test category description';

    //   // Create a category
    //   final category = Category(name: name, description: description);

    //   // Create the category
    //   await categoryApi.createCategory(category);

    //   // Retrieve the category by name
    //   final retrievedCategory = await categoryApi.getCategoryByName(name);

    //   // Verify that the retrieved category matches the created one
    //   expect(retrievedCategory.name, equals(name));
    //   expect(retrievedCategory.description, equals(description));
    // });

    // // This test may change Database
    // test('Update Category Description', () async {
    //   // Sample data for updating the category
    //   final name = 'TestCategory'; // Use an existing name for testing
    //   final updatedDescription = 'Updated category description';

    //   // Update the category description
    //   await categoryApi.updateCategoryDescription(name, updatedDescription);

    //   // Retrieve the updated category
    //   final updatedCategory = await categoryApi.getCategoryByName(name);

    //   // Verify that the updated category description matches the new data
    //   expect(updatedCategory.name, equals(name));
    //   expect(updatedCategory.description, equals(updatedDescription));
    // });

    // // This test may change Database
    // test('Update Category Name', () async {
    //   // Sample data for updating the category name
    //   final name = 'TestCategory'; // Use an existing name for testing
    //   final newName = 'NewTestCategory';

    //   // Update the category name
    //   await categoryApi.updateCategoryName(name, newName);

    //   // Retrieve the category with the new name
    //   final updatedCategory = await categoryApi.getCategoryByName(newName);

    //   // Verify that the updated category has the new name
    //   expect(updatedCategory.name, equals(newName));
    // });

    // // This test may change Database
    // test('Delete Category', () async {
    //   // Sample data for deleting the category
    //   final name =
    //       'NewTestCategory'; // Use the name created in the previous test

    //   // Delete the category
    //   await categoryApi.deleteCategory(name);

    //   // Try to retrieve the deleted category by name
    //   try {
    //     await categoryApi.getCategoryByName(name);
    //     fail('Category should have been deleted.');
    //   } catch (error) {
    //     // Expect an exception to be thrown as the category is deleted
    //     expect(error, isA<Exception>());
    //   }
    // });
  });
}
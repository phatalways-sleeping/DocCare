// ignore_for_file: public_member_api_docs

import 'package:controllers/src/customer/customer_repository_service.dart';
import 'package:models/models.dart';
import 'package:services/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class SupabaseCustomerRepository implements CustomerRepositoryService {
  SupabaseCustomerRepository();
  late String _customerId;

  final SupabaseCustomerApiService _supabaseCustomerApiService =
      SupabaseCustomerApiService(
    supabase: Supabase.instance.client,
  );

  @override
  Future<String> createCustomer(
    String fullName,
    String email,
    String phone,
    DateTime birthday,
  ) async {
    final id = const Uuid().v7();
    final customer = Customer(
      id: id,
      fullname: fullName,
      email: email,
      phone: phone,
      birthday: birthday,
    );
    await _supabaseCustomerApiService.createUser(customer);
    return id;
  }

  @override
  void initializeCustomerId(String id) {
    _customerId = id;
  }

  @override
  Future<bool> isCustomerExist(String email) async {
    final customer =
        await _supabaseCustomerApiService.getAllUserEmail().catchError(
              (error) => <String>[],
            );
    return customer.contains(email);
  }
}

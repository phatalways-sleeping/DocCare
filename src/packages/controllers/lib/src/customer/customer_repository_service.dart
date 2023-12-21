// ignore_for_file: public_member_api_docs

abstract interface class CustomerRepositoryService {
  Future<String> createCustomer(
    String fullName,
    String email,
    String phone,
    DateTime birthday,
  );

  void initializeCustomerId(String id);

  Future<bool> isCustomerExist(String email);
}

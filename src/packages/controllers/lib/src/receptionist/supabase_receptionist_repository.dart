// ignore_for_file: public_member_api_docs
import 'package:controllers/src/receptionist/receptionist_repository_service.dart';

class SupabaseReceptionistRepository implements ReceptionistRepositoryService {
  SupabaseReceptionistRepository();

  late String _receptionistId;

  @override
  void initializeReceptionistId(String id) {
    _receptionistId = id;
  }

  @override
  void clear() {
    _receptionistId = '';
  }
}

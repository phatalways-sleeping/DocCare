/// Package for A.P.I related operations on models
library model_api;

// Absent Request
export 'src/absent_request/absent_request_api_service.dart';
export 'src/absent_request/supabase_absent_request_api_service.dart';
// Appointment
export 'src/appointment/appointment_api_service.dart';
export 'src/appointment/supabase_appointment_api_service.dart';
// Authentication
export 'src/authentication/auth_email_api_service.dart';
export 'src/authentication/supabase_auth_email_api_service.dart';
// Category
export 'src/category/category_api_service.dart';
export 'src/category/supabase_category_api_service.dart';
// Intake
export 'src/intake/intake_api_service.dart';
export 'src/intake/supabase_intake_api_service.dart';
// Medicine
export 'src/medicine/medicine_api_service.dart';
export 'src/medicine/supabase_medicine_api_service.dart';
// Prescription
export 'src/prescription/prescription_api_service.dart';
export 'src/prescription/supabase_prescription_api.dart';
// Response
export 'src/response/response.dart';
// Specialization
export 'src/specialization/specialization_api_service.dart';
export 'src/specialization/supabase_specialization_api_service.dart';
// Statistics
export 'src/statistics/statistics_api_service.dart';
export 'src/statistics/supabase_statistics_api_service.dart';
export 'src/storage/storage_api/firebase_storage_api_service.dart';
// Storage
export 'src/storage/storage_api/supabase_storage_api_service.dart';
export 'src/storage/storage_api_service.dart';
export 'src/users/customer/supabase_patient_api_service.dart';
// Users: Doctor, Patient, Receptionist
export 'src/users/doctor/supabase_doctor_api_service.dart';
export 'src/users/receptionist/supabase_receptionist_api_service.dart';
export 'src/users/user_api_service.dart';
// Working Shift
export 'src/working_shift/supabase_working_shift_api.dart';
export 'src/working_shift/working_shift_api_service.dart';

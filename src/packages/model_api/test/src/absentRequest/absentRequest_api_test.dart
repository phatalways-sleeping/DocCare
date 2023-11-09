import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:model_api/src/absentRequest/service/supabase_absentRequest_api_service.dart';




void main() //async 
{ 


  // await Future.wait([

  //   /// Initialize Supabase
  //   Supabase.initialize(
  //     url : 'https://bdxhcbmciknwrjjyqvzi.supabase.co',
  //     anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJkeGhjYm1jaWtud3JqanlxdnppIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTcyNjA4NDgsImV4cCI6MjAxMjgzNjg0OH0.tkRJxXBMI4gw5YvAV6wMhsYQmMkYO8ykYL8BI_osCik',
  //     authFlowType: AuthFlowType.pkce,
  //   )
  // ]);
  
  group('AbsentRequestApi', () { 

    // Create a Supabase instance
    // SupabaseAbsentRequestApiService service = SupabaseAbsentRequestApiService(supabase: Supabase.instance.client);
    // final data = service.getAbsentRequest('D001', DateTime(2023, 11, 1, 0, 0));
    // final absentRequest = AbsentRequest(
    //     doctorID: 'D001',
    //     date: DateTime(2023, 11, 1, 0, 0),
    //     doctorName: 'John Doe',
    //     dateRequest: DateTime(2023, 10, 20, 0, 0),
    //     reason: 'Medical Conference',
    //     isApproved: true,);      
    // expect(data, absentRequest);
  });
}

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/src/prescription_customer/controller/prescription_bloc.dart';
import 'package:screens/src/prescription_customer/widget/dc_medicines_screen.dart';
import 'package:screens/src/prescription_customer/widget/dc_prescription_screen.dart';
import 'package:utility/utility.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:model_api/model_api.dart';

class DCPrescriptionGeneral extends StatefulWidget {
  const DCPrescriptionGeneral({
    required this.customerID,
    super.key,
  });

  final String customerID;

  @override
  State<DCPrescriptionGeneral> createState() => _DCPrescriptionGeneralState();
}

class _DCPrescriptionGeneralState extends State<DCPrescriptionGeneral> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrescriptionBloc(
        widget.customerID,
        SupabasePrescriptionApiService(supabase: Supabase.instance.client),
        SupabaseDoctorApiService(supabase: Supabase.instance.client),
        SupabaseIntakeAPIService(supabase: Supabase.instance.client),
      )..add(
          const PrescriptionInitialEvent(),
        ),
      child: BlocConsumer<PrescriptionBloc, PrescriptionState>(
        listener: (context, state) {
          print(state.doctorName.length);
        },
        builder: (context, state) {
          return DCPrescriptionScreen(customerID: widget.customerID);
        },
      ),
    );
  }
}

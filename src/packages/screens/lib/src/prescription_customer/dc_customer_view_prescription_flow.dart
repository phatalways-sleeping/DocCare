// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/src/prescription_customer/controller/prescription_bloc.dart';
import 'package:screens/src/prescription_customer/screens/dc_medicine_screen.dart';
import 'package:screens/src/prescription_customer/screens/dc_prescription_screen.dart';
import 'package:utility/utility.dart';

class DCCustomerViewPrescriptionFlow extends StatefulWidget {
  const DCCustomerViewPrescriptionFlow({
    super.key,
  });

  @override
  State<DCCustomerViewPrescriptionFlow> createState() =>
      _DCCustomerViewPrescriptionFlowState();
}

class _DCCustomerViewPrescriptionFlowState
    extends State<DCCustomerViewPrescriptionFlow> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrescriptionBloc(
        NotificationManager.instance,
      ),
      child: BlocConsumer<PrescriptionBloc, PrescriptionState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is PrescriptionViewState ||
              state is PrescriptionViewLoadingState ||
              state is IntakeViewState ||
              state is IntakeViewRatingResultState) {
            return const DCPrescriptionScreen();
          } else if (state is MedicinesViewState ||
              state is MedicinesViewLoadingState) {
            return const DCMedicineScreen();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

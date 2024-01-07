// ignore_for_file: public_member_api_docs

import 'package:controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utility/utility.dart';
import 'package:views/src/screens/users/prescription/controller/prescription_bloc.dart';
import 'package:views/src/screens/users/prescription/screens/dc_empty_screen.dart';
import 'package:views/src/screens/users/prescription/screens/dc_medicine_screen.dart';
import 'package:views/src/screens/users/prescription/screens/dc_prescription_screen.dart';

class DCCustomerViewPrescriptionFlow extends StatefulWidget {
  const DCCustomerViewPrescriptionFlow({required this.navigatorKey, super.key});

  final GlobalKey<NavigatorState> navigatorKey;

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
        widget.navigatorKey,
        NotificationManager.instance,
        context.read<CustomerRepositoryService>(),
      ),
      child: BlocConsumer<PrescriptionBloc, PrescriptionState>(
        key: widget.navigatorKey,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is PrescriptionViewState ||
              state is IntakeViewState ||
              state is IntakeViewRatingResultState ||
              state is PrescriptionViewLoadingState ||
              state is IntakeViewRatingResultState) {
            return const DCPrescriptionScreen();
          } else if (state is MedicinesViewState ||
              state is MedicinesViewLoadingState) {
            return const DCMedicineScreen();
          } else if (state is PrescriptionEmptyState) {
            return const DCEmptyScreen();
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

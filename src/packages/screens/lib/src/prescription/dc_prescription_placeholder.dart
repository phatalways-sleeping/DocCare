// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/src/prescription/controller/prescription_bloc.dart';
import 'package:screens/src/prescription/dc_add_medicine_screen.dart';
import 'package:screens/src/prescription/dc_medical_stat_screen.dart';
import 'package:screens/src/prescription/dc_prescription_screen.dart';
import 'package:utility/utility.dart';

class DCPrescriptionPlaceholder extends StatefulWidget {
  const DCPrescriptionPlaceholder({
    required this.customerName,
    super.key,
  });

  final String customerName;

  @override
  State<DCPrescriptionPlaceholder> createState() =>
      _DCPrescriptionPlaceholderState();
}

class _DCPrescriptionPlaceholderState extends State<DCPrescriptionPlaceholder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // TODO: Change to custom AppBar
      appBar: AppBar(
        title: const Text('Prescription'),
      ),
      body: BlocProvider(
        create: (_) => PrescriptionBloc(
          NotificationManager.instance,
        ),
        child: BlocBuilder<PrescriptionBloc, PrescriptionState>(
          builder: (context, state) {
            if (state is PrescriptionMedicalInitial) {
              return GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: DCMedicalStatScreen(customerName: widget.customerName),
              );
            } else if (state is PrescriptionMedicalSuccess) {
              return DCPrescriptionScreen(customerName: widget.customerName);
            } else if (state is PrescriptionAddMedicine) {
              return GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: const DCAddMedicineScreen(),
              );
            }
            // TODO(phucchuhoang): Navigate back to home screen
            else if (state is PrescriptionSuccess) {
              return Container();
            }
            return Container();
          },
        ),
      ),
    );
  }
}

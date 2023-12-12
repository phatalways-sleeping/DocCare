// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/src/prescription/controller/prescription_bloc.dart';
import 'package:screens/src/prescription/dc_medical_stat_screen.dart';
import 'package:utility/utility.dart';

class DCPrescriptionPlaceholder extends StatefulWidget {
  const DCPrescriptionPlaceholder({super.key});

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
            if (state is PrescriptionInitial) {
              return GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: const DCMedicalStatScreen(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

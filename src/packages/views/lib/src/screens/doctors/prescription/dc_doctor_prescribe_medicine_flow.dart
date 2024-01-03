// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utility/utility.dart';
import 'package:views/src/screens/doctors/prescription/controller/prescription_bloc.dart';
import 'package:views/src/screens/doctors/prescription/dc_add_medicine_screen.dart';
import 'package:views/src/screens/doctors/prescription/dc_medical_stat_screen.dart';
import 'package:views/src/screens/doctors/prescription/dc_prescription_screen.dart';

class DCDoctorPrescibeMedicineFlow extends StatefulWidget {
  const DCDoctorPrescibeMedicineFlow({
    required this.navigatorKey,
    required this.arguments,
    super.key,
  });

  final Map<String, dynamic> arguments;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<DCDoctorPrescibeMedicineFlow> createState() =>
      _DCDoctorPrescibeMedicineFlowState();
}

class _DCDoctorPrescibeMedicineFlowState
    extends State<DCDoctorPrescibeMedicineFlow> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PrescriptionBloc(
        widget.navigatorKey,
        NotificationManager.instance,
        context.read<DoctorRepositoryService>(),
        widget.arguments,
      ),
      child: BlocConsumer<PrescriptionBloc, PrescriptionState>(
        listener: (context, state) {
          if (state is PrescriptionMedicalInitial) {
            BlocProvider.of<PrescriptionBloc>(context).add(
              const RetrieveMedicineEvent(),
            );
          }
          if (state is PrescriptionSuccess) {
            Navigator.of(context, rootNavigator: true)
                .pushNamed('/doctor/home');
          }
        },
        builder: (context, state) {
          if (state is PrescriptionSuccess) return Container();
          final screen = state is PrescriptionMedicalLoading
              ? const Center(child: CircularProgressIndicator())
              : state is PrescriptionMedicalInitial
                  ? DCMedicalStatScreen(
                      customerName: widget.arguments['customerName'] as String,
                    )
                  : state is PrescriptionMedicalSuccess
                      ? DCPrescriptionScreen(
                          customerName:
                              widget.arguments['customerName'] as String,
                        )
                      : state is PrescriptionAddMedicine
                          ? const DCAddMedicineScreen()
                          : state is PrescriptionSuccess
                              ? Container()
                              : Container();
          return Scaffold(
            key: widget.navigatorKey,
            resizeToAvoidBottomInset: true,
            appBar: DCDoctorHeaderBar(
              title: '',
              allowNavigateBack: true,
              onLeadingIconPressed: (context) {
                if (state is PrescriptionMedicalInitial) {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed('/doctor/home');
                }
                BlocProvider.of<PrescriptionBloc>(context).add(
                  const PrescriptionBackEvent(),
                );
              },
            ),
            body: GestureDetector(
              onTap: FocusScope.of(context).unfocus,
              child: screen,
            ),
          );
        },
      ),
    );
  }
}

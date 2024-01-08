// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/src/screens/doctors/prescription/controller/prescription_bloc.dart';
import 'package:views/src/screens/doctors/prescription/widgets/medical_stat_widget.dart';

class DCMedicalStatScreen extends StatefulWidget {
  const DCMedicalStatScreen({
    required this.customerName,
    super.key,
  });

  final String customerName;

  @override
  State<DCMedicalStatScreen> createState() => _DCMedicalStatScreenState();
}

class _DCMedicalStatScreenState extends State<DCMedicalStatScreen> {
  late TextEditingController _controller1;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  late TextEditingController _controller4;
  late TextEditingController _controller5;

  void setText() {
    final currentState = BlocProvider.of<PrescriptionBloc>(context).state;
    _controller1.text = currentState.bloodPressure;
    _controller2.text = currentState.heartRate;
    _controller3.text = currentState.choresterol;
    _controller4.text = currentState.bloodSugar;
    _controller5.text = currentState.doctorNote[0];
  }

  @override
  void initState() {
    super.initState();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    _controller4 = TextEditingController();
    _controller5 = TextEditingController();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _controller5.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setText();
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.94,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        child: Text(
                          widget.customerName,
                          style: context.textTheme.h6BoldPoppins.copyWith(
                            fontSize: 30,
                            color: context.colorScheme.tertiary,
                          ),
                        ),
                      ),
                      DCMedicalStat(
                        textController: _controller1,
                        statName: 'Blood Pressure (mmHg)',
                        hintValue: '120/80',
                        icon: DCSVGIcons.bloodDrop,
                        onChanged: (value) {
                          BlocProvider.of<PrescriptionBloc>(
                            context,
                          ).add(
                            BloodPressureInputEvent(
                              value,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      DCMedicalStat(
                        textController: _controller2,
                        statName: 'Heart Rate (bpm)',
                        hintValue: '80',
                        icon: DCSVGIcons.heart,
                        onChanged: (value) {
                          BlocProvider.of<PrescriptionBloc>(
                            context,
                          ).add(
                            HeartRateInputEvent(
                              value,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      DCMedicalStat(
                        textController: _controller3,
                        statName: 'Cholesterol (mg/dl)',
                        hintValue: '80',
                        icon: DCSVGIcons.cholesterol,
                        onChanged: (value) {
                          BlocProvider.of<PrescriptionBloc>(
                            context,
                          ).add(
                            ChoresterolInputEvent(
                              value,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      DCMedicalStat(
                        textController: _controller4,
                        statName: 'Glucose (mg/dl)',
                        hintValue: '80',
                        icon: DCSVGIcons.glucometer,
                        onChanged: (value) {
                          BlocProvider.of<PrescriptionBloc>(
                            context,
                          ).add(
                            BloodSugarInputEvent(
                              value,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(
                          bottom: 5,
                        ),
                        child: Text(
                          "Diagnosis",
                          style: context.textTheme.h6BoldPoppins
                              .copyWith(fontSize: 20),
                        ),
                      ),
                      DCOutlinedTextFormField(
                        controller: _controller5,
                        keyboardType: TextInputType.multiline,
                        borderRadius: 12,
                        maxLines: 5,
                        hintText: "Please specify the medical condition or issue...",
                        onChanged: (context, controller) =>
                            BlocProvider.of<PrescriptionBloc>(context)
                                .add(DoctorNoteInputEvent(controller.text)),
                      ),
                      const SizedBox(height: 16),
                      DCFilledButton(
                        backgroundColor: context.colorScheme.surface,
                        fixedSize: Size(
                          context.width * 0.8,
                          context.height * 0.05,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        onPressed: (context) {
                          BlocProvider.of<PrescriptionBloc>(
                            context,
                          ).add(
                            const NextButtonPressedEvent(),
                          );
                        },
                        child: Text(
                          'Next',
                          style: context.textTheme.h6RegularPoppins.copyWith(
                            fontSize: 20,
                            color: context.colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

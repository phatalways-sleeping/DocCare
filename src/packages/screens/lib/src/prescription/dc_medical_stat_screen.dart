// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:screens/src/prescription/controller/prescription_bloc.dart';
import 'package:screens/src/prescription/widgets/medical_stat_widget.dart';

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
        widthFactor: 0.9,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.customerName,
                          style: context.textTheme.h6BoldPoppins.copyWith(
                            fontSize: 30,
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
                        child: Text(
                          "Doctor's Notes",
                          style: context.textTheme.h6BoldPoppins
                              .copyWith(fontSize: 20),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: context.colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: context.colorScheme.secondary),
                        ),
                        child: TextField(
                          maxLines: 3,
                          decoration: const InputDecoration(
                            hintText: 'Write some note for the patient...',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(12),
                          ),
                          style: const TextStyle(fontSize: 16),
                          onChanged: (value) =>
                              BlocProvider.of<PrescriptionBloc>(context)
                                  .add(DoctorNoteInputEvent(value)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      DCFilledButton(
                        backgroundColor: context.colorScheme.surface,
                        fixedSize: Size(
                          context.width * 0.4,
                          context.height * 0.06,
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

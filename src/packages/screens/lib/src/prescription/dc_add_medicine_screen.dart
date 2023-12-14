// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/src/prescription/controller/prescription_bloc.dart';
import 'package:screens/src/prescription/widgets/time_of_day_selector.dart';
import 'package:screens/src/prescription/widgets/to_be_taken_selector.dart';

class DCAddMedicineScreen extends StatefulWidget {
  const DCAddMedicineScreen({
    super.key,
  });

  @override
  State<DCAddMedicineScreen> createState() => _DCAddMedicineScreenState();
}

class _DCAddMedicineScreenState extends State<DCAddMedicineScreen> {
  @override
  Widget build(BuildContext context) {
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
                          'Add a medicine',
                          style: context.textTheme.h6BoldPoppins.copyWith(
                            fontSize: 26,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Name',
                          style: context.textTheme.h6BoldPoppins.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      DCOutlinedTextFormField(
                        hintText: 'Enter medicine name',
                        onChanged: (context, controller) {
                          context.read<PrescriptionBloc>().add(
                                MedicineNameInputEvent(
                                  controller.text,
                                ),
                              );
                        },
                      ),
                      const SizedBox(height: 8),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Duration (days)',
                          style: context.textTheme.h6BoldPoppins.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      DCOutlinedTextFormField(
                        hintText: 'Number of days',
                        onChanged: (context, controller) {
                          context.read<PrescriptionBloc>().add(
                                MedicineDurationInputEvent(
                                  controller.text,
                                ),
                              );
                        },
                      ),
                      const SizedBox(height: 8),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Dose per time',
                          style: context.textTheme.h6BoldPoppins.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      DCOutlinedTextFormField(
                        hintText: 'Number of pills per time',
                        onChanged: (context, controller) {
                          context.read<PrescriptionBloc>().add(
                                MedicineDoseInputEvent(
                                  controller.text,
                                ),
                              );
                        },
                      ),
                      const SizedBox(height: 8),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Time of the day',
                          style: context.textTheme.h6BoldPoppins.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const TimeOfDaySelector(),
                      const SizedBox(height: 8),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'To be taken',
                          style: context.textTheme.h6BoldPoppins.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const ToBeTakenSelector(),
                      const SizedBox(height: 20),
                      DCFilledButton(
                        backgroundColor: context.colorScheme.surface,
                        fixedSize: Size(
                          context.width * 0.8,
                          context.height * 0.07,
                        ),
                        onPressed: (context) {
                          BlocProvider.of<PrescriptionBloc>(context)
                              .add(const AddIntakeButtonPressedEvent());
                        },
                        child: Text(
                          'Add this to intake',
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

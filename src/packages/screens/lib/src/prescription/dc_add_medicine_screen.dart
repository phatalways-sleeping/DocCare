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
  List<String> _availableMedicines = [];
  late TextEditingController _medicineNameController;

  @override
  void initState() {
    super.initState();
    _medicineNameController = TextEditingController();
  }

  @override
  void dispose() {
    _medicineNameController.dispose();
    super.dispose();
  }

  void filterMedicines(String value) {
    var res = <String>[];
    if (value.isEmpty) {
      res = BlocProvider.of<PrescriptionBloc>(context).state.availableMedicines;
    } else {
      res = BlocProvider.of<PrescriptionBloc>(context)
          .state
          .availableMedicines
          .where(
            (element) => element.toLowerCase().startsWith(value.toLowerCase()),
          )
          .toList();
    }

    setState(() {
      _availableMedicines = res;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                          'Add a medicine',
                          style: context.textTheme.h6BoldPoppins.copyWith(
                            fontSize: 30,
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
                        controller: _medicineNameController,
                        hintText: 'Enter medicine name',
                        onChanged: (context, controller) {
                          context.read<PrescriptionBloc>().add(
                                MedicineNameInputEvent(
                                  controller.text,
                                ),
                              );
                          filterMedicines(controller.text);
                        },
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: _availableMedicines.isEmpty ? 0 : 200,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _availableMedicines.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ), // Add a border here
                              ),
                              child: ListTile(
                                title: Text(_availableMedicines[index]),
                                onTap: () {
                                  context.read<PrescriptionBloc>().add(
                                        MedicineNameInputEvent(
                                          _availableMedicines[index],
                                        ),
                                      );
                                  _medicineNameController.text =
                                      _availableMedicines[index];
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    _availableMedicines = [];
                                  });
                                },
                              ),
                            );
                          },
                        ),
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
                        maxLines: 1,
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
                        maxLines: 1,
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
                          context.height * 0.05,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        onPressed: (context) {
                          BlocProvider.of<PrescriptionBloc>(context)
                              .add(const AddIntakeButtonPressedEvent());
                        },
                        child: Text(
                          'Add this to prescription',
                          style: context.textTheme.h6RegularPoppins.copyWith(
                            fontSize: 16,
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

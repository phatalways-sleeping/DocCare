// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/src/screens/doctors/prescription/controller/prescription_bloc.dart';
import 'package:views/src/screens/doctors/prescription/widgets/time_of_day_selector.dart';
import 'package:views/src/screens/doctors/prescription/widgets/to_be_taken_selector.dart';

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
                      Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          context.read<PrescriptionBloc>().add(
                                MedicineNameInputEvent(textEditingValue.text),
                              );
                          if (textEditingValue.text == '') {
                            return const Iterable<String>.empty();
                          }
                          return BlocProvider.of<PrescriptionBloc>(context)
                              .state
                              .availableMedicines
                              .where(
                            (String option) {
                              return option.toLowerCase().contains(
                                    textEditingValue.text.toLowerCase(),
                                  );
                            },
                          );
                        },
                        optionsViewBuilder: (
                          BuildContext context,
                          AutocompleteOnSelected<String> onSelected,
                          Iterable<String> options,
                        ) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                Material(
                                  child: SizedBox(
                                    width: context.width * 0.94,
                                    height: context.height * 0.3,
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: options.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final option = options.elementAt(index);
                                        return Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: context.theme.colorScheme
                                                    .secondary,
                                              ),
                                            ),
                                          ),
                                          child: ListTile(
                                            title: Text(
                                              option,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                            onTap: () {
                                              onSelected(option);
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        onSelected: (String selection) {
                          context.read<PrescriptionBloc>().add(
                                MedicineNameInputEvent(
                                  selection,
                                ),
                              );
                          FocusScope.of(context).unfocus();
                        },
                        fieldViewBuilder: (
                          BuildContext context,
                          TextEditingController textEditingController,
                          FocusNode focusNode,
                          VoidCallback onFieldSubmitted,
                        ) {
                          return TextField(
                            controller: textEditingController,
                            focusNode: focusNode,
                            onSubmitted: (String value) {
                              onFieldSubmitted();
                            },
                            style: context.textTheme.h6RegularPoppins.copyWith(
                              color: context.theme.colorScheme.onSecondary,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Medicine name',
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: BorderSide(
                                  color: context.theme.colorScheme.secondary,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: BorderSide(
                                  color: context.theme.colorScheme.secondary,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: context.theme.colorScheme.secondary,
                                ),
                              ),
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

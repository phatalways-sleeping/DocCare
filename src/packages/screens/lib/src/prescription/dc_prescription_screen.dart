// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/src/prescription/controller/prescription_bloc.dart';
import 'package:screens/src/prescription/widgets/medicine_widget.dart';

class DCPrescriptionScreen extends StatefulWidget {
  const DCPrescriptionScreen({
    required this.customerName,
    super.key,
  });

  final String customerName;

  @override
  State<DCPrescriptionScreen> createState() => _DCPrescriptionScreenState();
}

List<String> separateMedicineTimeTaken(String timeTaken) {
  final parts = timeTaken.split('/'); // Split the string by '/'

  // Filter out any empty strings resulting from trailing slashes
  final filteredParts = parts.where((part) => part.isNotEmpty).toList();

  return filteredParts;
}

class _DCPrescriptionScreenState extends State<DCPrescriptionScreen> {
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listMedicines = context.watch<PrescriptionBloc>().state.medicines;
    _noteController.text =
        context.watch<PrescriptionBloc>().state.doctorNote[1];

    final List<Widget> medicineWidgets = listMedicines.entries.map((entry) {
      final timesTaken = separateMedicineTimeTaken(entry.value[2]);

      final buffer = StringBuffer('${entry.value[0]} day(s), ');
      for (final time in timesTaken) {
        buffer.write('$time, ');
      }
      buffer
        ..write('${entry.value[1]} pill(s) per time, ')
        ..write(entry.value[3]);

      final details = buffer.toString();

      return DCMedicine(
        medicineName: entry.key,
        details: details,
      );
    }).toList();

    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.94,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                child: Text(
                  widget.customerName,
                  style: context.textTheme.h6BoldPoppins.copyWith(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(medicineWidgets),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  DCMedicine(
                    medicineName: 'Add Medicine',
                    details: 'Add Medicine',
                    isAddMedicine: true,
                    onPressed: () =>
                        BlocProvider.of<PrescriptionBloc>(context).add(
                      const AddMedicineButtonPressedEvent(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(
                      bottom: 5,
                    ),
                    child: Text(
                      "Doctor's Notes",
                      style: context.textTheme.h6BoldPoppins.copyWith(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  DCOutlinedTextFormField(
                    controller: _noteController,
                    maxLines: 7,
                    hintText: 'Write some note for the patient...',
                    borderRadius: 12,
                    onChanged: (context, controller) =>
                        BlocProvider.of<PrescriptionBloc>(context).add(
                      DoctorNoteMedicineInputEvent(
                        controller.text,
                      ),
                    ),
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
                    onPressed: (context) {},
                    child: Text(
                      'Add prescription',
                      style: context.textTheme.h6BoldPoppins.copyWith(
                        fontSize: 18,
                        color: context.colorScheme.onSecondary,
                      ),
                    ),
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

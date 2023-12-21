// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/src/screens/users/prescription/controller/prescription_bloc.dart';
import 'package:views/src/screens/users/prescription/widgets/dc_prescription_item.dart';

class DCAsyncItems extends StatefulWidget {
  const DCAsyncItems({
    required this.future,
    required this.isDone,
    this.medicine = false,
    super.key,
  });

  final Future<List<Map<String, dynamic>>> future;
  final bool isDone;
  final bool medicine;

  @override
  State<DCAsyncItems> createState() => _DCAsyncItemsState();
}

class _DCAsyncItemsState extends State<DCAsyncItems> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (widget.medicine) {
            assert(
              snapshot.data!.isEmpty ||
                  (snapshot.data!.first.containsKey('medicineName') &&
                      snapshot.data!.first.containsKey('quantity') &&
                      snapshot.data!.first.containsKey('time') &&
                      snapshot.data!.first.containsKey('toBeTaken')),
              'Medicine data must contain medicineName, quantity, time, toBeTaken',
            );
          } else {
            assert(
              snapshot.data!.isEmpty ||
                  (snapshot.data!.first.containsKey('doctorName') &&
                      snapshot.data!.first.containsKey('date') &&
                      snapshot.data!.first.containsKey('Note') &&
                      snapshot.data!.first.containsKey('id')),
              'Prescription data must contain doctorName, date, Note and id',
            );
          }
          final children = snapshot.data!
                .map(
                  (e) => !widget.medicine
                      ? DCPrescriptionItem(
                          title: 'Dr. ${e['doctorName'] as String}',
                          bottomLeft: Text(
                            e['date'].toString().substring(0, 10),
                          ),
                          color: context.colorScheme.error,
                          onSelected: (context) =>
                              context.read<PrescriptionBloc>().add(
                                    PrescriptionCheckEvent(
                                      prescriptionId: e['id'] as String,
                                    ),
                                  ),
                          onPressed: (context) =>
                              context.read<PrescriptionBloc>().add(
                                    PrescriptionOpenMedicinesViewEvent(
                                      prescriptionId: e['id'] as String,
                                    ),
                                  ),
                          bottomRight: Text(
                            e['Note'] as String,
                          ),
                          isDone: widget.isDone,
                        )
                      : DCPrescriptionItem(
                          title: '${e['medicineName']}',
                          bottomLeft: Text(
                            (e['time'] as String).split(',').join(', '),
                          ),
                          color: context.colorScheme.error,
                          onSelected: (context) =>
                              context.read<PrescriptionBloc>().add(
                                    MedicineCheckEvent(
                                      medineName: e['medicineName'] as String,
                                    ),
                                  ),
                          onPressed: (context) {},
                          bottomRight: Text(
                            '${e['quantity']} pills - ${e['toBeTaken'] as int == 0 ? 'Before meal' : 'After meal'}',
                          ),
                          isDone: widget.isDone,
                        ),
                )
                .toList();
          return ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: children.length,
            itemBuilder: (context, index) => children[index],
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
          );
        } else if (snapshot.hasError) {
          return ElevatedButton(
            onPressed: () => setState(() {}),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                context.colorScheme.error,
              ),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              elevation: const MaterialStatePropertyAll(4),
              shadowColor: MaterialStatePropertyAll(
                context.colorScheme.onSurface.withOpacity(0.5),
              ),
              fixedSize: MaterialStatePropertyAll(
                Size(
                  context.width * 0.94,
                  50,
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'An eror occured.',
                  style: context.textTheme.bodyRegularPoppins.copyWith(
                    color: context.colorScheme.tertiary,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.refresh,
                  color: context.colorScheme.tertiary,
                  size: 20,
                ),
              ],
            ),
          );
        }
        return Center(
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              color: context.colorScheme.secondary,
            ),
          ),
        );
      },
    );
  }
}

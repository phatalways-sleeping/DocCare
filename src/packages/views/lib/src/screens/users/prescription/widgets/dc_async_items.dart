// ignore_for_file: public_member_api_docs
import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/src/screens/users/prescription/controller/prescription_bloc.dart';
import 'package:views/src/screens/users/prescription/widgets/dc_async_pop_up.dart';
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
    //Color list
    final List<Color> _colors = [
      context.colorScheme.error,
      context.colorScheme.secondary,
      context.colorScheme.primary,
      context.colorScheme.secondary,
    ];

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (widget.medicine) {
            assert(
              snapshot.data!.isEmpty ||
                  (snapshot.data!.first.containsKey('medicineName') &&
                      snapshot.data!.first.containsKey('quantity') &&
                      snapshot.data!.first.containsKey('timeOfTheDay') &&
                      snapshot.data!.first.containsKey('toBeTaken')),
              'Medicine data must contain medicineName, quantity, timeOfTheDay, toBeTaken',
            );
          } else {
            assert(
              snapshot.data!.isEmpty ||
                  (snapshot.data!.first.containsKey('doctorName') &&
                      snapshot.data!.first.containsKey('date') &&
                      snapshot.data!.first.containsKey('note') &&
                      snapshot.data!.first.containsKey('id')),
              'Prescription data must contain doctorName, date, note and id',
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
                        //Color is random
                        color: _colors[
                            (e['id'] as String).hashCode % _colors.length],
                        onSelected: (context) =>
                            context.read<PrescriptionBloc>().add(
                                  PrescriptionCheckEvent(
                                    done: !widget.isDone,
                                    prescriptionId: e['id'] as String,
                                  ),
                                ),
                        onLongPressed: (context) async {
                          //Move state to IntakeRating, has problem with how the dialog is shown
                          final results = await showDialog<int>(
                            context: context,
                            builder: (bcontext) => DCAsyncPopUp(
                              future: context
                                  .read<PrescriptionBloc>()
                                  .getCurrentPrescriptions(
                                    e['id'] as String,
                                  ),
                            ),
                          );

                          if (results != null) {
                            context.read<PrescriptionBloc>().add(
                                  IntakeRatingEvent(
                                    prescriptionId: e['id'] as String,
                                    rating: results,
                                  ),
                                );
                          }
                        },
                        onPressed: (context) =>
                            context.read<PrescriptionBloc>().add(
                                  PrescriptionOpenMedicinesViewEvent(
                                    prescriptionId: e['id'] as String,
                                  ),
                                ),

                        bottomRight: Text(
                          e['note'] as String,
                        ),
                        isDone: widget.isDone,
                      )
                    : DCPrescriptionItem(
                        title: '${e['medicineName']}',
                        bottomLeft: Text(
                          (e['timeOfTheDay'] as String).split('/').join(', '),
                        ),
                        color: _colors[(e['medicineName'] as String).hashCode %
                            _colors.length],
                        onSelected: (context) =>
                            context.read<PrescriptionBloc>().add(
                                  MedicineCheckEvent(
                                    prescriptionId: '',
                                    medicineName: e['medicineName'] as String,
                                    done: !widget.isDone,
                                  ),
                                ),
                        onLongPressed: (context) => {},
                        onPressed: (context) {},
                        bottomRight: Text(
                          '${e['quantity']} pills - ${e['toBeTaken'] as int == 0 ? 'Before meal' : 'After meal'}',
                        ),
                        isDone: widget.isDone,
                      ),
              )
              .toList();
          return ListView.separated(
            physics: NeverScrollableScrollPhysics(),
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

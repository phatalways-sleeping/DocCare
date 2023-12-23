import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:screens/src/doctor_home/new_doctor_home/controller/doctor_home_bloc.dart';
import 'package:views/src/screens/doctors/home/widgets/dc_appointment_item.dart';
//import 'package:views/src/screens/users/prescription/widgets/dc_prescription_item.dart';

class DCDoctorAsyncItem extends StatefulWidget {
  const DCDoctorAsyncItem({
    required this.future,
    required this.isDone,
    required this.isPast,
    //this.medicine = false,
    super.key,
  });

  final Future<List<Map<String, dynamic>>> future;
  final bool isDone;
  final bool isPast;

  @override
  State<DCDoctorAsyncItem> createState() => _DCDoctorAsyncItemState();
}

class _DCDoctorAsyncItemState extends State<DCDoctorAsyncItem> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          assert(
            snapshot.data!.isEmpty ||
                (snapshot.data!.first.containsKey('customerName') &&
                    snapshot.data!.first.containsKey('time') &&
                    snapshot.data!.first.containsKey('symptom') &&
                    snapshot.data!.first.containsKey('id')),
            'Appointment data must contain customerName, time, symptom, id',
          );

          final children = snapshot.data!
              .map(
                (e) => DCAppointmentItem(
                  isPast: widget.isPast,
                  title: '${e['customerName']}',
                  bottomLeft: Text(
                    '${e['time']}',
                  ),
                  color: context.colorScheme.error,
                  
                  onSelected: (context) => {},
                  // context.read<DoctorHomeBloc>().add(
                  //       MedicineCheckEvent(
                  //         medineName: e['customerName'] as String,
                  //       ),
                  //     ),}
                  onPressed: (context) {},
                  bottomRight: Text(
                    '${e['symptom']}',
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

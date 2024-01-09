import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/src/screens/doctors/home/controller/doctor_home_bloc.dart';
import 'package:views/src/screens/doctors/home/widgets/dc_appointment_item.dart';
import 'package:views/src/screens/doctors/home/widgets/dc_doctor_async_pop_up.dart';
class DCDoctorAsyncItem extends StatefulWidget {
  const DCDoctorAsyncItem({
    required this.future,
    required this.isDone,
    required this.isPast,
    super.key,
  });

  final Future<List<dynamic>> future;
  final bool isDone;
  final bool isPast;

  @override
  State<DCDoctorAsyncItem> createState() => _DCDoctorAsyncItemState();
}

String mapPeriod(String period) {
  switch (period) {
    case '1':
      return '7:00 AM';
    case '2':
      return '8:00 AM';
    case '3':
      return '8:30 AM';
    case '4':
      return '9:00 AM';
    case '5':
      return '9:30 AM';
    case '6':
      return '10:00 AM';
    case '7':
      return '10:30 AM';
    case '8':
      return '11:00 AM';
    case '9':
      return '11:30 AM';
    case '10':
      return '12:00 PM';
    case '11':
      return '12:30 PM';
    case '12':
      return '1:00 PM';
    case '13':
      return '1:30 PM';
    case '14':
      return '2:00 PM';
    case '15':
      return '2:30 PM';
    case '16':
      return '3:00 PM';
    case '17':
      return '3:30 PM';
    case '18':
      return '4:00 PM';
    case '19':
      return '4:30 PM';

    default:
      return '5:00 PM';
  }
}

bool canPrescribe(String dateString) {
  final date = DateTime.parse(dateString);
  final now = DateTime.now();
  final diff = date.difference(now).inDays;
  return diff == 0;
}

class _DCDoctorAsyncItemState extends State<DCDoctorAsyncItem> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          assert(
            snapshot.data!.isEmpty ||
                ((snapshot.data!.first.containsKey('customerName').toString() ==
                            'true'
                        ? true
                        : false) &&
                    (snapshot.data!.first.containsKey('period').toString() ==
                            'true'
                        ? true
                        : false) &&
                    (snapshot.data!.first.containsKey('diagnosis').toString() ==
                            'true'
                        ? true
                        : false)),
            'Appointment data must contain customerName, period, diagnosis',
          );

          final children = snapshot.data!
              .map(
                (e) => DCAppointmentItem(
                  isPast: widget.isPast,
                  title: '${e['customerName']}',
                  bottomLeft: Text(
                    mapPeriod(e['period'].toString()),
                  ),
                  color: context.colorScheme.error,
                  onSelected: (context) => {},

                  onPressed: e['done'] == true
                      ? (context) async {
                      //Move state to IntakeRating, has problem with how the dialog is shown
                      final results = await showDialog<int>(
                        context: context,
                        builder: (bcontext) => DCDoctorAsyncPopUp(
                          future: context.read<DoctorHomeBloc>().
                          getCurrentPrescriptions(e['prescriptionID'].toString(), e['customerID'].toString()),
                          customerName: e['customerName'].toString(),


                              // .read<DoctorHomeBloc>()
                              // .getCurrentPrescriptions(
                              //   e['id'] as String,
                              // ),
                        ),
                      );
                      }
                      : (context) {
                          if (!canPrescribe(e['date'].toString())) return;
                          
                          final data = {
                            'customerID': e['customerID'].toString(),
                            'customerName': e['customerName'].toString(),
                            'date': DateTime.parse(e['date'].toString()),
                            'period': (e['period'].toString()),
                            'doctorID': e['doctorID'].toString(),
                            'rating': e['rating'].toString(),
                            'customerComment': e['customerComment'].toString(),
                            'dateDone': (e['dateDone'].toString()),
                            'prescriptionDone':
                                e['prescriptionDone'].toString(),
                          };

                          Navigator.of(context, rootNavigator: true)
                              .pushNamed('/doctor/prescribe', arguments: data);
                        },
                  bottomRight: const Text(
                    //'${e['diagnosis']}',
                    '',
                  ),
                  isDone: widget.isDone,
                ),
              )
              .toList();
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: children.length,
            itemBuilder: (context, index) => children[index],
            separatorBuilder: (context, index) => const SizedBox(
              height: 30,
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

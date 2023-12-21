import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:screens/src/doctor_home/controller/doctor_home_bloc.dart';

class DCDoctorScheduleScreen extends StatefulWidget {
  const DCDoctorScheduleScreen(
      {required this.day,required this.month, required this.year, required this.doctorID, super.key});

  final int day;
  final int month;
  final int year;
  final String doctorID;

  @override
  _DCDoctorScheduleScreenState createState() => _DCDoctorScheduleScreenState();
}

class _DCDoctorScheduleScreenState extends State<DCDoctorScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Color> colorList = <Color>[
      context.colorScheme.surface,
      context.colorScheme.secondary,
      context.colorScheme.error,
      context.colorScheme.onBackground,
    ];

    //Medicine message string
    var medicineMessage = '';

    List<String> customerName = [];
    List<String?> symptom = [];

    //Get the list of customer name, quantity and symptom
    for (var i = 0;
        i <
            (context.watch<PrescriptionBloc>().state as MedicineInitial)
                .customerName
                .length;
        i++) {
      customerName.add(
        (context.watch<PrescriptionBloc>().state as MedicineInitial)
            .customerName[i],
      );
      symptom.add(
        (context.watch<PrescriptionBloc>().state as MedicineInitial)
            .symptom[i],
      );
    }

    for (int i = 0; i < customerName.length; i++) {
      medicineMessage += customerName[i] +
          ': ' +
          (symptom[i] == "0" ? 'headache' : 'headache') +
          ((i < customerName.length - 1) ? '\n' : '');
    }

    return Scaffold(
      appBar: DCCustomerHeaderBar(
        allowNavigateBack: true,
        //Call the event to go back to the previous screen
        onLeadingIconPressed: (context) {
          context.read<PrescriptionBloc>().add(
                const MedicineBackEvent(),
              );
        },
        title: 'DocCare',
      ),
      //TODO(nmvinhdl1215): Change to FractionallySizedBox after the bug is fixed
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: DefaultTextStyle.merge(
                      style: context.textTheme.h4BoldPoppins.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onBackground,
                      ),
                      textAlign: TextAlign.left,
                      child: const Text('Your Schedule'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: DefaultTextStyle.merge(
                      style: context.textTheme.h4BoldPoppins.copyWith(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onBackground,
                      ),
                      textAlign: TextAlign.left,
                      child: const Text('Next Customer'),
                    ),
                  ),

                  //Display the list of current prescription

                  //On tap return the index of the list in child
                  Column(
                    children: List.generate(
                      (context.watch<PrescriptionBloc>().state
                              as MedicineInitial)
                          .customerName
                          .length,
                      (index) => InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        //On tap called pop-up intake rating screen
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            left: 10,
                            right: 10,
                          ),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: context.colorScheme.background,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: context.colorScheme.onSurface
                                      .withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(
                                    0,
                                    6,
                                  ), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                //Thick vertical line
                                const SizedBox(
                                  width: 0.2,
                                ),
                                Container(
                                  height: 80,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    color: colorList[index % colorList.length],
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(30),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    DefaultTextStyle.merge(
                                      style: context.textTheme.h4BoldPoppins
                                          .copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color: context.colorScheme.onBackground,
                                      ),
                                      textAlign: TextAlign.start,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Text(
                                          (context
                                                  .watch<PrescriptionBloc>()
                                                  .state as MedicineInitial)
                                              .customerName[index],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10,
                                              ),
                                              child: Transform.scale(
                                                scale: 0.8,
                                                child: SvgPicture.string(
                                                  DCSVGIcons.clock,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            DefaultTextStyle(
                                              style: context
                                                  .textTheme.h4RegularPoppins
                                                  .copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                color: context
                                                    .colorScheme.onBackground,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 5,
                                                ),
                                                child: Text(
                                                  (context
                                                          .watch<
                                                              PrescriptionBloc>()
                                                          .state as MedicineInitial)
                                                      .timeOfTheDay[index]!,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 10,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              RoundCheckBox(
                                                checkedColor: context
                                                    .colorScheme.secondary,
                                                animationDuration:
                                                    // ignore: use_named_constants
                                                    const Duration(),
                                                size: 30,
                                                onTap: (selected) {},
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 20,
                                                ),
                                                child: DefaultTextStyle.merge(
                                                  style: context.textTheme
                                                      .h4RegularPoppins
                                                      .copyWith(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: context.colorScheme
                                                        .onBackground,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                  child: Text(
                                                    '${(context.watch<PrescriptionBloc>().state as MedicineInitial).quantity[index]} pill' +
                                                        ((context.watch<PrescriptionBloc>().state
                                                                            as MedicineInitial)
                                                                        .quantity[
                                                                    index]! >
                                                                1
                                                            ? 's'
                                                            : '') +
                                                        ' - ' +
                                                        ((context.watch<PrescriptionBloc>().state
                                                                            as MedicineInitial)
                                                                        .symptom[
                                                                    index] ==
                                                                0
                                                            ? 'headache'
                                                            : 'headache'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: DefaultTextStyle.merge(
                      style: context.textTheme.h4BoldPoppins.copyWith(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onBackground,
                      ),
                      textAlign: TextAlign.left,
                      child: const Text('Past Appointment'),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

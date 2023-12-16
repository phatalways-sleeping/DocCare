import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/src/prescription_customer/controller/prescription_bloc.dart';

class DCPrescriptionScreen extends StatefulWidget {
  const DCPrescriptionScreen({
    required this.customerID,
    super.key,
  });

  final String customerID;

  @override
  _DCPrescriptionScreenState createState() => _DCPrescriptionScreenState();
}

class _DCPrescriptionScreenState extends State<DCPrescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    //List of color for the prescription
    final List<Color> colorList = <Color>[
      context.colorScheme.surface,
      context.colorScheme.secondary,
      context.colorScheme.error,
      context.colorScheme.onBackground,
    ];

    return Scaffold(
      appBar: const DCCustomerHeaderBar(
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
                      style: context.textTheme.h2BoldPoppins.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onBackground,
                      ),
                      textAlign: TextAlign.left,
                      child: const Text('Your history'),
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
                      child: const Text('Current Prescription'),
                    ),
                  ),

                  //Display the list of current prescription

                  Column(
                    children: List.generate(
                      context.watch<PrescriptionBloc>().state.doctorName.length,
                      (index) => (context
                              .watch<PrescriptionBloc>()
                              .state
                              .done[index])
                          ? InkWell(
                              onTap: () => context.read<PrescriptionBloc>().add(
                                    PrescriptionTapEvent(
                                      context
                                          .read<PrescriptionBloc>()
                                          .state
                                          .prescriptionID[index],
                                    ),
                                  ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                  left: 10,
                                  right: 10,
                                ),
                                child: DecoratedBox(
                                  //Decorate the box with shadow in the bottom border
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: context.colorScheme.onSurface,
                                    ),
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
                                          color: colorList[
                                              index % colorList.length],
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            bottomLeft: Radius.circular(30),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          DefaultTextStyle.merge(
                                            style: context
                                                .textTheme.h4BoldPoppins
                                                .copyWith(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              color: context
                                                  .colorScheme.onBackground,
                                            ),
                                            textAlign: TextAlign.start,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10,
                                              ),
                                              child: Text(
                                                context
                                                    .watch<PrescriptionBloc>()
                                                    .state
                                                    .doctorName[index],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                    style: context.textTheme
                                                        .h4RegularPoppins
                                                        .copyWith(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: context.colorScheme
                                                          .onBackground,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 5,
                                                      ),
                                                      child: Text(
                                                        context
                                                            .watch<
                                                                PrescriptionBloc>()
                                                            .state
                                                            .datePrescribed[
                                                                index]
                                                            .toString()
                                                            .substring(
                                                              0,
                                                              10,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      //Text at the end
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              right: 10,
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                DefaultTextStyle.merge(
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
                                                    context
                                                                .watch<
                                                                    PrescriptionBloc>()
                                                                .state
                                                                .note[index]
                                                                .length >
                                                            3
                                                        ? context
                                                            .watch<
                                                                PrescriptionBloc>()
                                                            .state
                                                            .note[index]
                                                            .substring(3)
                                                        : 'empty',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
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
                      child: const Text('Past Prescription'),
                    ),
                  ),
                  Column(
                    children: List.generate(
                      context.watch<PrescriptionBloc>().state.doctorName.length,
                      (index) => (context
                                  .watch<PrescriptionBloc>()
                                  .state
                                  .done[index] ==
                              false)
                          ? InkWell(
                              onTap: () => context.read<PrescriptionBloc>().add(
                                    PrescriptionTapEvent(
                                      context
                                          .read<PrescriptionBloc>()
                                          .state
                                          .prescriptionID[index],
                                    ),
                                  ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                  left: 10,
                                  right: 10,
                                ),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: context.colorScheme.onSurface,
                                    ),
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
                                          color: colorList[
                                              index % colorList.length],
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            bottomLeft: Radius.circular(30),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          DefaultTextStyle.merge(
                                            style: context
                                                .textTheme.h4BoldPoppins
                                                .copyWith(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              color: context
                                                  .colorScheme.onBackground,
                                            ),
                                            textAlign: TextAlign.start,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10,
                                              ),
                                              child: Text(
                                                context
                                                    .watch<PrescriptionBloc>()
                                                    .state
                                                    .doctorName[index],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                    style: context.textTheme
                                                        .h4RegularPoppins
                                                        .copyWith(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: context.colorScheme
                                                          .onBackground,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 5,
                                                      ),
                                                      child: Text(
                                                        context
                                                            .watch<
                                                                PrescriptionBloc>()
                                                            .state
                                                            .datePrescribed[
                                                                index]
                                                            .toString()
                                                            .substring(
                                                              0,
                                                              10,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      //Text at the end
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              right: 10,
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                DefaultTextStyle.merge(
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
                                                    context
                                                                .watch<
                                                                    PrescriptionBloc>()
                                                                .state
                                                                .note[index]
                                                                .length >
                                                            3
                                                        ? context
                                                            .watch<
                                                                PrescriptionBloc>()
                                                            .state
                                                            .note[index]
                                                            .substring(3)
                                                        : 'empty',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
      // bottomNavigationBar: DCCustomerNavigationBar(
      //   onItemSelected: (context, index) {
      //     print('index: $index');
      //   },
      // ),
    );
  }
}

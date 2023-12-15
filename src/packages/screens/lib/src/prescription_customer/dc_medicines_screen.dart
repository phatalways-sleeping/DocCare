import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:components/src/widgets/header_bar/dc_customer_header_bar.dart';
import 'package:components/src/widgets/navigation_bar/dc_customer_navigation_bar.dart';
import 'package:model_api/model_api.dart';
import 'package:screens/src/prescription_customer/controller/prescription_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DCMedicineScreen extends StatefulWidget {
  const DCMedicineScreen({required this.prescriptionID, super.key});

  final String prescriptionID;

  @override
  _DCMedicineScreenState createState() => _DCMedicineScreenState();
}

class _DCMedicineScreenState extends State<DCMedicineScreen> {
  @override
  Widget build(BuildContext context) {
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
                  DefaultTextStyle.merge(
                    style: context.textTheme.h4BoldPoppins.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onBackground,
                    ),
                    textAlign: TextAlign.left,
                    child: const Text('Your medicines'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultTextStyle.merge(
                    style: context.textTheme.h4BoldPoppins.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onBackground,
                    ),
                    textAlign: TextAlign.left,
                    child: const Text('Next Medicine'),
                  ),

                  //Display the list of current prescription

                  //On tap return the index of the list in child
                  Column(
                    children: List.generate(
                      (context.watch<PrescriptionBloc>().state
                              as MedicineInitial)
                          .medicineName
                          .length,
                      (index) => InkWell(
                        onTap: () => print('kkk'),
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
                                  height: 55,
                                  width: 12,
                                  decoration: BoxDecoration(
                                    color: context.colorScheme.secondary,
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
                                        fontSize: 18,
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
                                              .medicineName[index],
                                        ),
                                      ),
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
                                              child: SvgPicture.string(
                                                DCSVGIcons.clock,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            DefaultTextStyle(
                                              style: context
                                                  .textTheme.h4RegularPoppins
                                                  .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: context
                                                    .colorScheme.onBackground,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 10,
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
                                //Text at the end
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 10,
                                      ),
                                      child: DefaultTextStyle.merge(
                                        style: context
                                            .textTheme.h4RegularPoppins
                                            .copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          color:
                                              context.colorScheme.onBackground,
                                        ),
                                        textAlign: TextAlign.start,
                                        child: Text(
                                          '${(context.watch<PrescriptionBloc>().state as MedicineInitial).quantity[index]} pills - ${(context.watch<PrescriptionBloc>().state as MedicineInitial).toBeTaken[index]}' ==
                                                  '0'
                                              ? 'Before eating'
                                              : 'After eating',
                                        ),
                                      ),
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
                    height: 20,
                  ),
                  DefaultTextStyle.merge(
                    style: context.textTheme.h4BoldPoppins.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onBackground,
                    ),
                    textAlign: TextAlign.left,
                    child: const Text('Past Medicines'),
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
    );
  }
}

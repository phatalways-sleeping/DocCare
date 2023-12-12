// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:screens/src/prescription/controller/prescription_bloc.dart';

class DCMedicalStatScreen extends StatefulWidget {
  const DCMedicalStatScreen({
    required this.customerName,
    super.key,
  });

  final String customerName;

  @override
  State<DCMedicalStatScreen> createState() => _DCMedicalStatScreenState();
}

class _DCMedicalStatScreenState extends State<DCMedicalStatScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.customerName,
                          style: context.textTheme.h6BoldPoppins.copyWith(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: context.colorScheme.surface,
                          ),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Row(
                            children: <Widget>[
                              SvgPicture.string(
                                DCSVGIcons.bloodDrop,
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Blood Pressure (mmHg)',
                                      style: context.textTheme.h6RegularPoppins
                                          .copyWith(
                                        fontSize: 20,
                                        color: context.colorScheme.onSecondary
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(width: 2),
                                        ),
                                      ),
                                      child: TextField(
                                        style: context.textTheme.h6BoldPoppins
                                            .copyWith(
                                          fontSize: 16,
                                          color:
                                              context.colorScheme.onSecondary,
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '120/80',
                                          hintStyle: context
                                              .textTheme.h6RegularPoppins
                                              .copyWith(
                                            fontSize: 16,
                                            color: context
                                                .colorScheme.onSecondary
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          BlocProvider.of<PrescriptionBloc>(
                                            context,
                                          ).add(
                                            BloodPressureInputEvent(
                                              value,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: context.colorScheme.surface,
                          ),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Row(
                            children: <Widget>[
                              SvgPicture.string(
                                DCSVGIcons.heart,
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Heart Rate (beats/minute)',
                                      style: context.textTheme.h6RegularPoppins
                                          .copyWith(
                                        fontSize: 20,
                                        color: context.colorScheme.onSecondary
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(width: 2)),
                                      ),
                                      child: TextField(
                                        style: context.textTheme.h6BoldPoppins
                                            .copyWith(
                                          fontSize: 16,
                                          color:
                                              context.colorScheme.onSecondary,
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '69',
                                          hintStyle: context
                                              .textTheme.h6RegularPoppins
                                              .copyWith(
                                            fontSize: 16,
                                            color: context
                                                .colorScheme.onSecondary
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          BlocProvider.of<PrescriptionBloc>(
                                            context,
                                          ).add(
                                            HeartRateInputEvent(
                                              value,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: context.colorScheme.surface,
                          ),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Row(
                            children: <Widget>[
                              SvgPicture.string(
                                DCSVGIcons.cholesterol,
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Choresterol (mg/dl)',
                                      style: context.textTheme.h6RegularPoppins
                                          .copyWith(
                                        fontSize: 20,
                                        color: context.colorScheme.onSecondary
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(width: 2)),
                                      ),
                                      child: TextField(
                                        style: context.textTheme.h6BoldPoppins
                                            .copyWith(
                                          fontSize: 16,
                                          color:
                                              context.colorScheme.onSecondary,
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '100',
                                          hintStyle: context
                                              .textTheme.h6RegularPoppins
                                              .copyWith(
                                            fontSize: 16,
                                            color: context
                                                .colorScheme.onSecondary
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          BlocProvider.of<PrescriptionBloc>(
                                            context,
                                          ).add(
                                            ChoresterolInputEvent(
                                              value,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: context.colorScheme.surface,
                          ),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Row(
                            children: <Widget>[
                              SvgPicture.string(
                                DCSVGIcons.glucometer,
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Glucose (mg/dl)',
                                      style: context.textTheme.h6RegularPoppins
                                          .copyWith(
                                        fontSize: 20,
                                        color: context.colorScheme.onSecondary
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(width: 2)),
                                      ),
                                      child: TextField(
                                        style: context.textTheme.h6BoldPoppins
                                            .copyWith(
                                          fontSize: 16,
                                          color:
                                              context.colorScheme.onSecondary,
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '80',
                                          hintStyle: context
                                              .textTheme.h6RegularPoppins
                                              .copyWith(
                                            fontSize: 16,
                                            color: context
                                                .colorScheme.onSecondary
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          BlocProvider.of<PrescriptionBloc>(
                                            context,
                                          ).add(
                                            BloodSugarInputEvent(
                                              value,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Doctor's Notes",
                          style: context.textTheme.h6BoldPoppins.copyWith(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                          border:
                              Border.all(color: context.colorScheme.secondary),
                        ),
                        child: const TextField(
                          maxLines: null, // Makes it expandable
                          decoration: InputDecoration(
                            hintText: 'Write some note for the patient...',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(12),
                          ),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      DCFilledButton(
                        fixedSize: Size(
                          context.width * 0.3,
                          context.height * 0.06,
                        ),
                        onPressed: (context) {
                          BlocProvider.of<PrescriptionBloc>(
                            context,
                          ).add(
                            const NextButtonPressedEvent(),
                          );
                        },
                        child: Text(
                          'Next',
                          style: context.textTheme.h6RegularPoppins.copyWith(
                            fontSize: 20,
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

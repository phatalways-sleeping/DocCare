// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DCMedicalStatScreen extends StatefulWidget {
  const DCMedicalStatScreen({super.key});

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
                          'John Gaylord',
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
                              horizontal: 16, vertical: 8),
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
                                      'Blood Pressure',
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
                                          hintText: '120/80 mmHg',
                                          hintStyle: context
                                              .textTheme.h6RegularPoppins
                                              .copyWith(
                                            fontSize: 16,
                                            color: context
                                                .colorScheme.onSecondary
                                                .withOpacity(0.5),
                                          ),
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
                              horizontal: 16, vertical: 8),
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
                                      'Heart Rate',
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
                                          hintText: '69 beats/minute',
                                          hintStyle: context
                                              .textTheme.h6RegularPoppins
                                              .copyWith(
                                            fontSize: 16,
                                            color: context
                                                .colorScheme.onSecondary
                                                .withOpacity(0.5),
                                          ),
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
                              horizontal: 16, vertical: 8),
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
                                      'Choresterol',
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
                                          hintText: '100mg/dl',
                                          hintStyle: context
                                              .textTheme.h6RegularPoppins
                                              .copyWith(
                                            fontSize: 16,
                                            color: context
                                                .colorScheme.onSecondary
                                                .withOpacity(0.5),
                                          ),
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
                              horizontal: 16, vertical: 8),
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
                                      'Glucose',
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
                                          hintText: '80mg/dl',
                                          hintStyle: context
                                              .textTheme.h6RegularPoppins
                                              .copyWith(
                                            fontSize: 16,
                                            color: context
                                                .colorScheme.onSecondary
                                                .withOpacity(0.5),
                                          ),
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
                        onPressed: (context) {},
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

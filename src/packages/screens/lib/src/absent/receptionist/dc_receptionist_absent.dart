// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/src/absent/receptionist/controller/receptionist_absent_bloc.dart';
import 'package:screens/src/absent/receptionist/doctor_card.dart';

class DCReceptionistAbsentScreen extends StatefulWidget {
  const DCReceptionistAbsentScreen({super.key});

  @override
  State<DCReceptionistAbsentScreen> createState() =>
      _DCReceptionistAbsentScreenState();
}

class _DCReceptionistAbsentScreenState
    extends State<DCReceptionistAbsentScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReceptionistAbsentBloc(),
      child: const BodyReceptionistWidget(),
    );
  }
}

class BodyReceptionistWidget extends StatelessWidget {
  const BodyReceptionistWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receptionist Absent'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.03,
                ),
                child: Row(
                  children: [
                    Text('Requests', style: context.textTheme.h1BoldPoppins),
                    const SizedBox(width: 8),
                    SvgPicture.string(
                      DCSVGIcons.absentRequest,
                      height: 35,
                      width: 35,
                    ),
                  ],
                ),
              ),
              BlocBuilder<ReceptionistAbsentBloc, ReceptionistAbsentState>(
                builder: (context, state) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return DoctorCard(
                        imageSrc: 'https://picsum.photos/200',
                        name: 'John Doe',
                        dateAbsent: DateTime.now(),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

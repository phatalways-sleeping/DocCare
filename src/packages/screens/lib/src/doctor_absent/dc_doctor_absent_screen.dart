import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/src/doctor_absent/controller/doctor_absent_bloc.dart';
import 'package:screens/src/doctor_absent/doctor_card.dart';

class DCDoctorAbsentScreen extends StatefulWidget {
  const DCDoctorAbsentScreen({super.key});

  @override
  State<DCDoctorAbsentScreen> createState() => _DCDoctorAbsentScreenState();
}

class _DCDoctorAbsentScreenState extends State<DCDoctorAbsentScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorAbsentBloc(),
      child: const BodyWidget(),
    );
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Doctor Absent'),
          ),
          const SliverToBoxAdapter(
            child: DoctorCard(
              imageSrc: 'https://picsum.photos/200',
              name: 'John Doe',
              speciality: 'Dentist',
              rating: 4,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.03,
            ),
            sliver: SliverToBoxAdapter(
              child: DCOutlinedWithHeadingTextFormField(
                borderRadius: 16,
                initialText: 'John Doe',
                headingColor: context.colorScheme.onSecondary,
                heading: const Text(
                  'Full Name',
                ),
                textAlign: TextAlign.center,
                enabled: false,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.03,
            ),
            sliver: SliverToBoxAdapter(
              child: DCOutlinedWithHeadingTextFormField(
                borderRadius: 16,
                onChanged: (context, controller) {
                  context.read<DoctorAbsentBloc>().add(
                        DoctorAbsentDateInputEvent(
                          controller.text,
                        ),
                      );
                },
                headingColor: context.colorScheme.onSecondary,
                keyboardType: TextInputType.datetime,
                heading: const Text(
                  'Absent Date',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.03,
            ),
            sliver: SliverToBoxAdapter(
              child: DCOutlinedWithHeadingTextFormField(
                onChanged: (context, controller) {
                  context.read<DoctorAbsentBloc>().add(
                        DoctorAbsentDescriptionInputEvent(
                          controller.text,
                        ),
                      );
                },
                borderRadius: 16,
                headingColor: context.colorScheme.onSecondary,
                keyboardType: TextInputType.text,
                heading: const Text(
                  'Reasons',
                ),
                textAlign: TextAlign.start,
                minLines: 7,
                maxLines: 10,
                hintText: 'Explain the reasons for absence',
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.03,
            ),
            sliver: SliverToBoxAdapter(
              child: BlocBuilder<DoctorAbsentBloc, DoctorAbsentState>(
                buildWhen: (previous, current) =>
                    previous.agreeTerms != current.agreeTerms,
                builder: (context, state) {
                  return Row(
                    children: [
                      Checkbox(
                        value: state.agreeTerms,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        onChanged: (value) {
                          context.read<DoctorAbsentBloc>().add(
                                DoctorAbsentAgreementCheckboxEvent(
                                  value ?? false,
                                ),
                              );
                        },
                      ),
                      Text(
                        'I agree to the terms and conditions',
                        style: context.textTheme.bodyRegularPoppins
                            .copyWith(fontSize: 16),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.03,
            ),
            sliver: SliverToBoxAdapter(
              child: BlocBuilder<DoctorAbsentBloc, DoctorAbsentState>(
                buildWhen: (previous, current) =>
                    previous.arrangeAnotherDoctor !=
                    current.arrangeAnotherDoctor,
                builder: (context, state) {
                  return Row(
                    children: [
                      Checkbox(
                        value: state.arrangeAnotherDoctor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        onChanged: (value) {
                          context.read<DoctorAbsentBloc>().add(
                                DoctorAbsentArrangeAnotherDoctorEvent(
                                  value ?? false,
                                ),
                              );
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Please help me arrange alternative',
                            style: context.textTheme.bodyRegularPoppins
                                .copyWith(fontSize: 16),
                          ),
                          Text(
                            'appointments for my patients',
                            style: context.textTheme.bodyRegularPoppins
                                .copyWith(fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.03,
              vertical: context.height * 0.02,
            ),
            sliver: SliverToBoxAdapter(
              child: DCFilledButton(
                onPressed: (context) {
                  context.read<DoctorAbsentBloc>().add(
                        const DoctorAbsentButtonPressedEvent(),
                      );
                },
                backgroundColor: context.colorScheme.secondary,
                fixedSize: Size(
                  context.width * 0.94,
                  context.height * 0.06,
                ),
                child: Text(
                  'Submit',
                  style: context.textTheme.bodyRegularPoppins.copyWith(
                    fontSize: 16,
                    color: context.colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

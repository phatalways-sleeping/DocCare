// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/src/absent/doctor/controller/doctor_absent_bloc.dart';
import 'package:screens/src/absent/doctor/dc_loading_view.dart';
import 'package:screens/src/absent/doctor/doctor_card.dart';
import 'package:screens/src/absent/doctor/showResultDialog.dart';

class DCDoctorAbsentScreen extends StatefulWidget {
  const DCDoctorAbsentScreen({super.key});

  @override
  State<DCDoctorAbsentScreen> createState() => _DCDoctorAbsentScreenState();
}

class _DCDoctorAbsentScreenState extends State<DCDoctorAbsentScreen> {
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorAbsentBloc(),
      child: BlocConsumer<DoctorAbsentBloc, DoctorAbsentState>(
        listener: (context, state) async {
          if (state is DoctorAbsentSuccess) {
            await showSuccessDialog(context: context).then((value) {
              context.read<DoctorAbsentBloc>().add(
                    const DoctorAbsentResetEvent(),
                  );
            });
          } else if (state is DoctorAbsentError) {
            final errorMessage =
                state.errorMessage.isNotEmpty ? state.errorMessage : null;
            await showErrorDialog(
              context: context,
              errorMessage: errorMessage,
            ).then((value) {
              context.read<DoctorAbsentBloc>().add(
                    const DoctorAbsentResetEvent(),
                  );
            });
          }
        },
        builder: (context, state) => Stack(
          children: [
            Scaffold(
              appBar: DCDoctorHeaderBar(
                allowNavigateBack: true,
                onLeadingIconPressed: (context) {
                  // TODO: Navigate back to home screen
                },
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.03,
                    vertical: context.height * 0.03,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const DoctorCard(
                        imgPath: 'https://picsum.photos/200',
                        name: 'John Doe',
                        speciality: 'Dentist',
                        rating: 4,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      DCOutlinedWithHeadingTextFormField(
                        borderRadius: 16,
                        initialText: 'John Doe',
                        headingColor: context.colorScheme.onSecondary,
                        heading: const Text(
                          'Full Name',
                        ),
                        textAlign: TextAlign.center,
                        enabled: false,
                      ),
                      DCOutlinedWithHeadingTextFormField(
                        controller: _controller1,
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
                      DCOutlinedWithHeadingTextFormField(
                        controller: _controller2,
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
                      BlocBuilder<DoctorAbsentBloc, DoctorAbsentState>(
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
                      BlocBuilder<DoctorAbsentBloc, DoctorAbsentState>(
                        buildWhen: (previous, current) =>
                            previous.arrangeAnotherDoctor !=
                            current.arrangeAnotherDoctor,
                        builder: (context, state) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              Flexible(
                                child: Wrap(
                                  children: [
                                    Text(
                                      'Please help me arrange alternative appointments for my patients',
                                      style: context
                                          .textTheme.bodyRegularPoppins
                                          .copyWith(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      DCFilledButton(
                        onPressed: (context) {
                          context.read<DoctorAbsentBloc>().add(
                                const DoctorAbsentButtonPressedEvent(),
                              );
                          _controller1.clear();
                          _controller2.clear();
                        },
                        backgroundColor: context.colorScheme.secondary,
                        fixedSize: Size(
                          context.width * 0.94,
                          context.height * 0.06,
                        ),
                        child: Text(
                          'Submit',
                          style: context.textTheme.bodyRegularPoppins.copyWith(
                            fontSize: 18,
                            color: context.colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (state is DoctorAbsentLoading) const DCLoadingView(),
          ],
        ),
      ),
    );
  }
}

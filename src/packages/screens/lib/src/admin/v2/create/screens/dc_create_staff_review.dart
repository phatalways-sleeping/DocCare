// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/src/absent/doctor/dc_loading_view.dart';
import 'package:screens/src/admin/v2/create/controllers/create_staff/create_staff_bloc.dart';
import 'package:screens/src/admin/v2/create/controllers/screen/screen_bloc.dart';
import 'package:screens/src/admin/v2/create/widgets/config.dart';
import 'package:screens/src/admin/v2/create/widgets/dc_content_line.dart';

class DCCreateStaffReview extends StatefulWidget {
  const DCCreateStaffReview({super.key});

  @override
  State<DCCreateStaffReview> createState() => _DCCreateStaffReviewState();
}

class _DCCreateStaffReviewState extends State<DCCreateStaffReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DCAdminHeaderBar(
        allowNavigationBack: true,
        onLeadingIconPressed: (context) {
          if (context.read<StaffCreationBloc>().state.role == 'Doctor') {
            context.read<ScreenBloc>().add(
                  const NavigateToSecondScreen(),
                );
          } else {
            context.read<ScreenBloc>().add(
                  const NavigateToFirstScreen(),
                );
          }
        },
      ),
      body: BlocConsumer<StaffCreationBloc, CreateStaffState>(
        listener: (context, state) async {
          if (state is CreateStaffSuccess) {
          } else if (state is CreateStaffFailure) {}
        },
        builder: (context, state) {
          if (state is CreateStaffSuccess) {
            return const SizedBox.shrink();
          }
          return Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.05,
                  ).copyWith(
                    bottom: context.height * 0.08,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/pic_4.png',
                        fit: BoxFit.cover,
                      ),
                      DCContentLine(
                        title: 'Full name',
                        content: state.fullName,
                      ),
                      gap,
                      DCContentLine(
                        title: 'Email',
                        content: state.email,
                      ),
                      gap,
                      DCContentLine(
                        title: 'Birthday',
                        content: state.birthdate,
                      ),
                      gap,
                      DCContentLine(
                        title: 'Phone number',
                        content: state.phoneNumber,
                      ),
                      gap,
                      DCContentLine(
                        title: 'Role',
                        content: state.role,
                      ),
                      gap,
                      if (state.role == 'Doctor') ...[
                        DCContentLine(
                          title: 'Speciality',
                          content: state.specialization,
                        ),
                        gap,
                        DCContentLine.title(
                          title: 'Working shifts',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: context.width * 0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: state.workingShifts
                                .where(
                              (element) =>
                                  element['weekDay'] != null &&
                                  element['startPeriod'] != null &&
                                  element['endPeriod'] != null,
                            )
                                .map((shift) {
                              final weekDay = shift['weekDay'] as String;
                              final startPeriod =
                                  shift['startPeriod'] as String;
                              final endPeriod = shift['endPeriod'] as String;
                              return DCContentLine(
                                title: weekDay,
                                content: '$startPeriod - $endPeriod',
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                      SizedBox(
                        height: context.height * 0.05,
                      ),
                      Material(
                        color: context.colorScheme.background,
                        elevation: 4,
                        borderRadius: BorderRadius.circular(20),
                        child: DCFilledButton(
                          onPressed: (context) => context
                              .read<StaffCreationBloc>()
                              .add(const CreateStaffSubmitEvent()),
                          fixedSize: Size(
                            context.width * 0.9,
                            50,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          backgroundColor: context.colorScheme.secondary,
                          child: Text(
                            'Create',
                            style:
                                context.textTheme.bodyRegularPoppins.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: context.colorScheme.tertiary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (state is CreateStaffLoading) const DCLoadingView(),
            ],
          );
        },
      ),
    );
  }
}

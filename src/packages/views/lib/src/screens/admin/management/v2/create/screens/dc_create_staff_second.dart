// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/src/screens/admin/management/v2/config.dart';
import 'package:views/src/screens/admin/management/v2/create/controllers/create_staff/create_staff_bloc.dart';
import 'package:views/src/screens/admin/management/v2/create/controllers/screen/screen_bloc.dart';
import 'package:views/src/screens/admin/management/v2/widgets/dc_working_shift_widget.dart';

class DCCreateStaffSecond extends StatefulWidget {
  const DCCreateStaffSecond({super.key});

  @override
  State<DCCreateStaffSecond> createState() => _DCCreateStaffSecondState();
}

class _DCCreateStaffSecondState extends State<DCCreateStaffSecond> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DCAdminHeaderBar(
        allowNavigationBack: true,
        onLeadingIconPressed: (context) => context.read<ScreenBloc>().add(
              const NavigateToFirstScreen(),
            ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.05,
          ).copyWith(
            bottom: context.height * 0.08,
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/images/pic_5.png',
                fit: BoxFit.cover,
              ),
              Text(
                'Working shifts',
                style: context.textTheme.h1RegularPoppins.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: context.colorScheme.tertiary,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocSelector<StaffCreationBloc, CreateStaffState,
                  List<Map<String, dynamic>>>(
                selector: (state) => state.workingShifts,
                builder: (context, state) {
                  if (state.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  final children = state.map((shift) {
                    final weekDay = shift['weekDay'] as String?;
                    final startPeriod = shift['startPeriod'] as String?;
                    final endPeriod = shift['endPeriod'] as String?;
                    final index = state.indexOf(shift);
                    return DCWorkingShiftWidget(
                      initialWeekDay: weekDay,
                      initialStartPeriod: startPeriod,
                      initialEndPeriod: endPeriod,
                      onChangedWeekDay: (context, value) => context
                          .read<StaffCreationBloc>()
                          .add(CreateStaffChangeWeekdayEvent(index, value)),
                      onChangedStartPeriod: (context, value) => context
                          .read<StaffCreationBloc>()
                          .add(CreateStaffChangeStartPeriodEvent(index, value)),
                      onChangedEndPeriod: (context, value) => context
                          .read<StaffCreationBloc>()
                          .add(CreateStaffChangeEndPeriodEvent(index, value)),
                      onRemove: (context) => context
                          .read<StaffCreationBloc>()
                          .add(CreateStaffRemoveWorkingShiftEvent(index)),
                    );
                  }).toList();
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => children[index],
                    separatorBuilder: (context, index) => gap,
                    itemCount: children.length,
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DCFilledButton(
                onPressed: (context) => context.read<StaffCreationBloc>().add(
                      const CreateStaffAddNewWorkingShiftEvent(),
                    ),
                fixedSize: Size(
                  context.width * 0.9,
                  50,
                ),
                borderRadius: BorderRadius.circular(20),
                backgroundColor: context.colorScheme.secondary,
                child: Text(
                  'Add more',
                  style: context.textTheme.bodyRegularPoppins.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.tertiary,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Material(
                color: context.colorScheme.background,
                elevation: 4,
                borderRadius: BorderRadius.circular(20),
                child: DCFilledButton(
                  onPressed: (context) => context.read<ScreenBloc>().add(
                        const NavigateToThirdScreen(),
                      ),
                  fixedSize: Size(
                    context.width * 0.9,
                    50,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  backgroundColor: context.colorScheme.secondary,
                  child: Text(
                    'Next',
                    style: context.textTheme.bodyRegularPoppins.copyWith(
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
    );
  }
}

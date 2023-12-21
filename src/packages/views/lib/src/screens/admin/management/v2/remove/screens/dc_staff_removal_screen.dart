// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/src/screens/admin/management/v2/config.dart';
import 'package:views/src/screens/admin/management/v2/remove/controller/staff_removal_bloc.dart';
import 'package:views/src/screens/admin/management/v2/show_dialog.dart';
import 'package:views/src/screens/admin/management/v2/widgets/dc_async_input.dart';
import 'package:views/src/screens/admin/management/v2/widgets/dc_speciality_button.dart';
import 'package:views/src/widgets/dc_loading_view.dart';

class DCStaffRemovalScreen extends StatelessWidget {
  const DCStaffRemovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StaffRemovalBloc(),
      child: BlocConsumer<StaffRemovalBloc, StaffRemovalState>(
        buildWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType,
        listener: (context, state) async {
          if (state is StaffRemovalSuccess) {
            await showStaffAddedDialog(
              context: context,
              role: state.role,
              message: 'Staff removed successfully.',
            ).then(
              (value) => context.read<StaffRemovalBloc>().add(
                    const StaffRemovalResetEvent(),
                  ),
            );
          } else if (state is StaffRemovalFailure) {
            await showAddingOperationFailure(
              context: context,
              message: 'Staff removal failed.',
            ).then(
              (value) => context.read<StaffRemovalBloc>().add(
                    const StaffRemovalResetEvent(),
                  ),
            );
          }
        },
        builder: (context, state) {
          print('State: $state from BLOCPROVIDER');
          return Scaffold(
            appBar: const DCAdminHeaderBar(),
            drawer: const DCAdminDrawer(),
            resizeToAvoidBottomInset: true,
            body: Stack(
              alignment: Alignment.center,
              children: [
                SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.width * 0.05,
                    ).copyWith(
                      bottom: context.height * 0.05,
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/pic_2.png',
                          fit: BoxFit.cover,
                        ),
                        gap,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Delete Account',
                            style: context.textTheme.h1BoldPoppins.copyWith(
                              fontSize: 30,
                              color: context.colorScheme.tertiary,
                            ),
                          ),
                        ),
                        gap,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Role',
                            style:
                                context.textTheme.bodyRegularPoppins.copyWith(
                              fontSize: 18,
                              color: context.colorScheme.tertiary,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BlocSelector<StaffRemovalBloc, StaffRemovalState,
                            String>(
                          selector: (state) => state.role,
                          builder: (context, state) {
                            return DCSpecialityButton(
                              future: Future.value(['Doctor', 'Receptionist']),
                              onPressed: (context, value) => context
                                  .read<StaffRemovalBloc>()
                                  .add(
                                    StaffRemovalRoleChangedEvent(role: value),
                                  ),
                              borderColor: context.colorScheme.secondary,
                              width: context.width * 0.9,
                              initialValue: state,
                              hintText: '',
                            );
                          },
                        ),
                        gap,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Email',
                            style:
                                context.textTheme.bodyRegularPoppins.copyWith(
                              fontSize: 18,
                              color: context.colorScheme.tertiary,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BlocSelector<StaffRemovalBloc, StaffRemovalState,
                            String>(
                          selector: (state) => state.email,
                          builder: (context, state) {
                            return DCAsyncInput(
                              initialValue: state.isEmpty ? null : state,
                              onChanged: (context, value) => context
                                  .read<StaffRemovalBloc>()
                                  .add(
                                    StaffRemovalEmailChangedEvent(
                                      email: value,
                                    ),
                                  ),
                            );
                          },
                        ),
                        for (int i = 0; i < 5; i++) gap,
                        DCFilledButton(
                          onPressed: (
                            context,
                          ) =>
                              context.read<StaffRemovalBloc>().add(
                                    const StaffRemovalSubmitEvent(),
                                  ),
                          backgroundColor: const Color(0xFFD82626),
                          fixedSize: Size(
                            context.width * 0.9,
                            50,
                          ),
                          shadowColor: const Color(
                            0xFFD82626,
                          ).withOpacity(
                            0.4,
                          ),
                          child: Text(
                            'Delete',
                            style:
                                context.textTheme.bodyRegularPoppins.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: context.colorScheme.background,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (state is StaffRemovalLoading) const DCLoadingView(),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:controllers/controllers.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utility/utility.dart';
import 'package:views/src/profile/controller/profile_bloc.dart';
import 'package:views/src/profile/widgets/show_confirmation_dialog.dart';
import 'package:views/src/screens/admin/management/v2/config.dart';
import 'package:views/src/widgets/dc_loading_view.dart';

class DCProfileScreen extends StatefulWidget {
  const DCProfileScreen({
    required this.navigatorKey,
    super.key,
  });

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<DCProfileScreen> createState() => _DCProfileScreenState();
}

class _DCProfileScreenState extends State<DCProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final role = context.read<AuthenticationRepositoryService>().role;
    final link = role == 'customer'
        ? '/home'
        : role == 'doctor'
            ? '/doctor/home'
            : role == 'receptionist'
                ? '/receptionist/home'
                : '/admin/home';
    return BlocProvider(
      create: (context) => ProfileBloc(
        widget.navigatorKey,
        NotificationManager.instance,
        authenticationRepositoryService:
            context.read<AuthenticationRepositoryService>(),
        customerRepositoryService: role == 'customer'
            ? context.read<CustomerRepositoryService>()
            : null,
        doctorRepositoryService:
            role == 'doctor' ? context.read<DoctorRepositoryService>() : null,
        receptionistRepositoryService: role == 'receptionist'
            ? context.read<ReceptionistRepositoryService>()
            : null,
        role: role,
      )..add(
          const ProfileLoadEvent(),
        ),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        key: widget.navigatorKey,
        listener: (context, state) async {
          if (state is ProfileWaitingForConfirmState) {
            await showConfirmationDialog(context).then(
              (value) {
                if (value ?? false) {
                  context.read<ProfileBloc>().add(
                        const ProfileSubmitted(),
                      );
                } else {
                  Navigator.of(context, rootNavigator: true).pushNamed(
                    link,
                  );
                }
              },
            );
          } else if (state is ProfileChangePasswordState) {
            await showPasswordChangeDialog(context).then(
              (value) {
                if (value != null) {
                  context.read<ProfileBloc>().add(
                        ProfilePasswordChanged(
                          password: value[0],
                          confirmPassword: value[1],
                        ),
                      );
                } else {
                  context.read<ProfileBloc>().add(
                        const ProfileResetEvent(),
                      );
                }
              },
            );
          } else if (state is ProfileUpdatedSuccess) {
            await Navigator.of(context, rootNavigator: true).pushNamed(
              link,
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileInitial) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: context.colorScheme.background,
                elevation: 0,
                leading: IconButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    link,
                  ),
                  icon: Icon(
                    Icons.arrow_back_outlined,
                    color: context.colorScheme.tertiary,
                    size: 30,
                  ),
                ),
              ),
              extendBodyBehindAppBar: true,
              body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.03,
                ).copyWith(
                  bottom: context.height * 0.03,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/pic_3.png',
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: context.height * 0.03,
                    ),
                  ],
                ),
              ),
            );
          }

          return Scaffold(
            resizeToAvoidBottomInset: true,
            extendBody: true,
            appBar: AppBar(
              backgroundColor: context.colorScheme.background,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  if (!state.hasChanged) {
                    Navigator.pushNamed(
                      context,
                      link,
                    );
                  } else {
                    context.read<ProfileBloc>().add(
                          const ProfileAskForConfirmation(),
                        );
                  }
                },
                icon: Icon(
                  Icons.arrow_back_outlined,
                  color: context.colorScheme.tertiary,
                  size: 30,
                ),
              ),
            ),
            bottomNavigationBar: (role == 'receptionist')
                ? const DCReceptionistNavigationBar(
                    selectedIndex: 1,
                  )
                : null,
            body: Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.03,
                  ).copyWith(
                    bottom: context.height * 0.03,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/pic_3.png',
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: context.height * 0.03,
                      ),
                      BlocSelector<ProfileBloc, ProfileState, String>(
                        selector: (state) => state.fullName,
                        builder: (context, state) {
                          return DCOutlinedWithHeadingTextFormField(
                            borderRadius: 12,
                            color: context.colorScheme.tertiary,
                            initialText: state,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.name,
                            heading: Text(
                              'Full name',
                              style:
                                  context.textTheme.bodyRegularPoppins.copyWith(
                                fontSize: 18,
                                color: context.colorScheme.tertiary,
                              ),
                            ),
                            onChanged: (context, controller) =>
                                context.read<ProfileBloc>().add(
                                      ProfileFullNameChanged(
                                        controller.text,
                                      ),
                                    ),
                          );
                        },
                      ),
                      gap,
                      BlocSelector<ProfileBloc, ProfileState, String>(
                        selector: (state) => state.email,
                        builder: (context, state) {
                          return DCOutlinedWithHeadingTextFormField(
                            borderRadius: 12,
                            color: context.colorScheme.tertiary,
                            initialText: state,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.emailAddress,
                            enabled: false,
                            heading: Text(
                              'Email',
                              style:
                                  context.textTheme.bodyRegularPoppins.copyWith(
                                fontSize: 18,
                                color: context.colorScheme.tertiary,
                              ),
                            ),
                            onChanged: (context, controller) {},
                          );
                        },
                      ),
                      gap,
                      BlocSelector<ProfileBloc, ProfileState, DateTime>(
                        selector: (state) => state.birthday,
                        builder: (context, state) {
                          return DCOutlinedWithHeadingTextFormField(
                            borderRadius: 12,
                            color: context.colorScheme.tertiary,
                            initialText: state.toString().substring(
                                  0,
                                  10,
                                ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.datetime,
                            heading: Text(
                              'Birthday',
                              style:
                                  context.textTheme.bodyRegularPoppins.copyWith(
                                fontSize: 18,
                                color: context.colorScheme.tertiary,
                              ),
                            ),
                            onChanged: (context, controller) =>
                                context.read<ProfileBloc>().add(
                                      ProfileBirthdayChanged(
                                        controller.text,
                                      ),
                                    ),
                          );
                        },
                      ),
                      gap,
                      BlocSelector<ProfileBloc, ProfileState, String>(
                        selector: (state) => state.phone,
                        builder: (context, state) {
                          return DCOutlinedWithHeadingTextFormField(
                            borderRadius: 12,
                            color: context.colorScheme.tertiary,
                            initialText: state,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.phone,
                            heading: Text(
                              'Phone',
                              style:
                                  context.textTheme.bodyRegularPoppins.copyWith(
                                fontSize: 18,
                                color: context.colorScheme.tertiary,
                              ),
                            ),
                            onChanged: (context, controller) =>
                                context.read<ProfileBloc>().add(
                                      ProfilePhoneChanged(
                                        controller.text,
                                      ),
                                    ),
                          );
                        },
                      ),
                      gap,
                      if (state.role == 'doctor') ...[
                        BlocSelector<ProfileBloc, ProfileState, String>(
                          selector: (state) => state.specialization,
                          builder: (context, state) {
                            return DCOutlinedWithHeadingTextFormField(
                              borderRadius: 12,
                              color: context.colorScheme.tertiary,
                              initialText: state,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.datetime,
                              heading: Text(
                                'Specialization',
                                style: context.textTheme.bodyRegularPoppins
                                    .copyWith(
                                  fontSize: 18,
                                  color: context.colorScheme.tertiary,
                                ),
                              ),
                            );
                          },
                        ),
                        gap,
                        BlocSelector<ProfileBloc, ProfileState, int>(
                          selector: (state) => state.startWorkingFrom,
                          builder: (context, state) {
                            return DCOutlinedWithHeadingTextFormField(
                              borderRadius: 12,
                              color: context.colorScheme.tertiary,
                              initialText: state.toString(),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              heading: Text(
                                'Starting year',
                                style: context.textTheme.bodyRegularPoppins
                                    .copyWith(
                                  fontSize: 18,
                                  color: context.colorScheme.tertiary,
                                ),
                              ),
                              onChanged: (context, controller) =>
                                  context.read<ProfileBloc>().add(
                                        ProfileStartWorkingFromChanged(
                                          int.parse(controller.text),
                                        ),
                                      ),
                            );
                          },
                        ),
                        gap,
                      ],
                      DCFilledButton(
                        onPressed: (context) => context.read<ProfileBloc>().add(
                              const ProfilePasswordChangedClickEvent(),
                            ),
                        backgroundColor: context.colorScheme.secondary,
                        fixedSize: Size(
                          context.width * 0.94,
                          context.height * 0.06,
                        ),
                        child: Text(
                          'Change password',
                          style: context.textTheme.bodyRegularPoppins.copyWith(
                            color: context.colorScheme.tertiary,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: context.height * 0.08,
                      ),
                    ],
                  ),
                ),
                if (state is ProfileLoadingState) const DCLoadingView(),
              ],
            ),
          );
        },
      ),
    );
  }
}

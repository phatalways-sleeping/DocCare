// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/src/profile/controller/profile_bloc.dart';
import 'package:views/src/screens/admin/management/v2/config.dart';

class DCProfileScreen extends StatelessWidget {
  const DCProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
        role: 'customer',
      )..add(
          const ProfileLoadEvent(),
        ),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final role = context.read<ProfileBloc>().state.role;
          final link = role == 'customer'
              ? '/home'
              : role == 'doctor'
                  ? '/doctor/home'
                  : role == 'receptionist'
                      ? '/receptionist/home'
                      : '/admin/home';
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
            appBar: AppBar(
              backgroundColor: context.colorScheme.background,
              elevation: 0,
              leading: IconButton(
                onPressed: () async {
                  await Future.delayed(
                    const Duration(milliseconds: 200),
                    () => true,
                  ).then(
                    (value) async {
                      if (value) {
                        // calling the bloc to save the data
                      }
                    },
                  ).then(
                    (value) => Navigator.pushNamed(
                      context,
                      link,
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_back_outlined,
                  color: context.colorScheme.tertiary,
                  size: 30,
                ),
              ),
            ),
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
                          style: context.textTheme.bodyRegularPoppins.copyWith(
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
                        heading: Text(
                          'Email',
                          style: context.textTheme.bodyRegularPoppins.copyWith(
                            fontSize: 18,
                            color: context.colorScheme.tertiary,
                          ),
                        ),
                        onChanged: (context, controller) =>
                            context.read<ProfileBloc>().add(
                                  ProfileEmailChanged(
                                    controller.text,
                                  ),
                                ),
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
                          style: context.textTheme.bodyRegularPoppins.copyWith(
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
                          style: context.textTheme.bodyRegularPoppins.copyWith(
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
                            style:
                                context.textTheme.bodyRegularPoppins.copyWith(
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
                            style:
                                context.textTheme.bodyRegularPoppins.copyWith(
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_api/model_api.dart';
import 'package:screens/src/profile/controller/profile_bloc.dart';
import 'package:utility/utility.dart';
import 'package:components/src/widgets/pop_up/dc_pop_up_confirm_change.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DCDoctorProfile extends StatefulWidget {
  const DCDoctorProfile({
    required this.doctorID,
    super.key,
  });

  final String doctorID;

  @override
  _DCDoctorProfileState createState() => _DCDoctorProfileState();
}

class _DCDoctorProfileState extends State<DCDoctorProfile> {
  late double height = context.height * 0.5;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //Create the initial state with initial event
      create: (context) => ProfileBloc(
        widget.doctorID,
        NotificationManager.instance,
        SupabaseDoctorApiService(
          supabase: Supabase.instance.client,
        ),
      )..add(
          const InitialEvent(),
        ),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) => {print(state)},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: context.colorScheme.background,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  if (state is ProfileInitial) {
                    Navigator.of(context).pop();
                    return;
                  }
                  showDialog(
                    context: context,
                    builder: (acontext) => DCPopupConfirmChange(
                      title: 'Confirm change',
                      message:
                          'Look like you have made some changes to your profile',
                      boldMessage: 'Confirm these changes?',
                      onConfirmButtonClicked: (bcontext) {
                        context.read<ProfileBloc>().add(
                              const ConfirmButtonPressedEvent(),
                            );
                        Navigator.of(bcontext).pop();
                      },
                      onCancelButtonClicked: (bcontext) {
                        context.read<ProfileBloc>().add(
                              const CancelButtonPressedEvent(),
                            );
                        Navigator.of(bcontext).pop();
                      },
                    ),
                  );
                },
              ),
            ),
            body: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    Image(
                      image: AssetImage('assets/images/pic_5.png'),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.width * 0.05,
                        vertical: context.height * 0.05,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DCOutlinedWithHeadingTextFormField(
                            heading: DefaultTextStyle.merge(
                              style:
                                  context.textTheme.h6RegularPoppins.copyWith(
                                color: context.colorScheme.tertiary,
                              ),
                              child: const Text('Fullname'),
                            ),
                            textAlign: TextAlign.center,
                            hintText: state.fullName,
                            textFormFieldConstraints: BoxConstraints(
                              maxWidth: context.width * 0.9,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: context.width * 0.03,
                              vertical: context.height * 0.02,
                            ),
                            onChanged: (context, controller) => context
                                .read<ProfileBloc>()
                                .add(FullNameInputEvent(controller.text)),
                          ),
                          SizedBox(
                            height: context.height * 0.02,
                          ),
                          DCOutlinedWithHeadingTextFormField(
                            heading: DefaultTextStyle.merge(
                              style:
                                  context.textTheme.h6RegularPoppins.copyWith(
                                color: context.colorScheme.tertiary,
                              ),
                              child: const Text('Email'),
                            ),
                            textAlign: TextAlign.center,
                            hintText: state.email,
                            textFormFieldConstraints: BoxConstraints(
                              maxWidth: context.width * 0.9,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: context.width * 0.03,
                              vertical: context.height * 0.02,
                            ),
                            onChanged: (context, controller) => context
                                .read<ProfileBloc>()
                                .add(EmailInputEvent(controller.text)),
                          ),
                          SizedBox(
                            height: context.height * 0.02,
                          ),
                          DCOutlinedWithHeadingTextFormField(
                            heading: DefaultTextStyle.merge(
                              style:
                                  context.textTheme.h6RegularPoppins.copyWith(
                                color: context.colorScheme.tertiary,
                              ),
                              child: const Text('Birthday'),
                            ),
                            textAlign: TextAlign.center,
                            hintText: state.birthday.toString(),
                            textFormFieldConstraints: BoxConstraints(
                              maxWidth: context.width * 0.9,
                            ),
                            keyboardType: TextInputType.datetime,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: context.width * 0.03,
                              vertical: context.height * 0.02,
                            ),
                            onChanged: (context, controller) =>
                                context.read<ProfileBloc>().add(
                                      BirthdayInputEvent(controller.text),
                                    ),
                            onFocusChange: (context, focusNode) {
                              if (state.tempBirthday == '') {
                                return;
                              }
                              if (!focusNode.hasFocus) {
                                context.read<ProfileBloc>().add(
                                      ValidateBirthdayInputEvent(
                                        state.tempBirthday,
                                      ),
                                    );
                              }
                            },
                          ),
                          SizedBox(
                            height: context.height * 0.02,
                          ),
                          DCOutlinedWithHeadingTextFormField(
                            heading: DefaultTextStyle.merge(
                              style:
                                  context.textTheme.h6RegularPoppins.copyWith(
                                color: context.colorScheme.tertiary,
                              ),
                              child: const Text('Phone Number'),
                            ),
                            textAlign: TextAlign.center,
                            hintText: state.phone,
                            textFormFieldConstraints: BoxConstraints(
                              maxWidth: context.width * 0.9,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: context.width * 0.03,
                              vertical: context.height * 0.02,
                            ),
                            onChanged: (context, controller) => context
                                .read<ProfileBloc>()
                                .add(PhoneNumberInputEvent(controller.text)),
                          ),
                          SizedBox(
                            height: context.height * 0.02,
                          ),
                          DCOutlinedWithHeadingTextFormField(
                            heading: DefaultTextStyle.merge(
                              style:
                                  context.textTheme.h6RegularPoppins.copyWith(
                                color: context.colorScheme.tertiary,
                              ),
                              child: const Text('Specialization'),
                            ),
                            textAlign: TextAlign.center,
                            hintText: state.specializationId,
                            textFormFieldConstraints: BoxConstraints(
                              maxWidth: context.width * 0.9,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: context.width * 0.03,
                              vertical: context.height * 0.02,
                            ),
                            onChanged: (context, controller) => context
                                .read<ProfileBloc>()
                                .add(SpecializationInputEvent(controller.text)),
                          ),
                          SizedBox(
                            height: context.height * 0.02,
                          ),
                          DCOutlinedWithHeadingTextFormField(
                            heading: DefaultTextStyle.merge(
                              style:
                                  context.textTheme.h6RegularPoppins.copyWith(
                                color: context.colorScheme.tertiary,
                              ),
                              child: const Text('Starting year'),
                            ),
                            textAlign: TextAlign.center,
                            hintText: state.startWorkingFrom.toString(),
                            textFormFieldConstraints: BoxConstraints(
                              maxWidth: context.width * 0.9,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: context.width * 0.03,
                              vertical: context.height * 0.02,
                            ),
                            onChanged: (context, controller) =>
                                context.read<ProfileBloc>().add(
                                      StartingYearInputEvent(
                                        int.parse(controller.text),
                                      ),
                                    ),
                          ),
                          SizedBox(
                            height: context.height * 0.05,
                          ),
                          DCOutlinedButton(
                            onPressed: (context) {},
                            padding: EdgeInsets.symmetric(
                              horizontal: context.width * 0.05,
                              vertical: 8,
                            ),
                            fixedSize: Size(
                              context.width * 0.9,
                              context.height * 0.07,
                            ),
                            borderSide: BorderSide(
                              color: context.colorScheme.onBackground,
                            ),
                            foregroundColor: context.colorScheme.background,
                            child: DefaultTextStyle.merge(
                              style:
                                  context.textTheme.bodyRegularPoppins.copyWith(
                                color: context.colorScheme.background,
                                fontSize: 16,
                              ),
                              child: const Text('Change password'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

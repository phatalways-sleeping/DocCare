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
            showDialog(
              context: context,
              builder: (context) => DCPopupConfirmChange(
                title: 'Confirm change',
                message:
                    'Look like you have made some changes to your profile.',
                boldMessage: 'Confirm these changes?',
                onConfirmButtonClicked: (context) =>
                    Navigator.of(context).pop(),
                onCancelButtonClicked: (context) => Navigator.of(context).pop(),
              ),
            );
          },
        ),
      ),
      body: BlocProvider(
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
          listener: (context, state) => {},
          builder: (context, state) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
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
                            initialText: state.fullName,
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
                            initialText: state.email,
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
                            initialText: state.birthday.toString(),
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
                            initialText: state.phone,
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
                            initialText: state.specializationId,
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
                            initialText: state.startWorkingFrom.toString(),
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
                                context.width * 0.9, context.height * 0.07),
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
            );
          },
        ),
      ),
    );
  }
}

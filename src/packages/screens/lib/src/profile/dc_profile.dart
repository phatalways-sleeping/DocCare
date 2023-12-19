import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_api/model_api.dart';
import 'package:screens/src/profile/controller/profile_bloc.dart';
import 'package:utility/utility.dart';
import 'package:components/src/widgets/pop_up/dc_pop_up_confirm_change.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DCProfile extends StatefulWidget {
  const DCProfile({
    required this.ID,
    super.key,
  });

  final String ID;

  @override
  _DCProfileState createState() => _DCProfileState();
}

class _DCProfileState extends State<DCProfile> {
  late double height = context.height * 0.5;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //Create the initial state with initial event
      create: (context) => ProfileBloc(
        widget.ID,
        NotificationManager.instance,
        SupabaseDoctorApiService(
          supabase: Supabase.instance.client,
        ),
        SupabaseCustomerApiService(
          supabase: Supabase.instance.client,
        ),
        SupabaseReceptionistApiService(
          supabase: Supabase.instance.client,
        ),
      )..add(
          const InitialEvent(),
        ),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) => {},
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
                onPressed: () async {
                  if (state is! DoctorProfileOnChange &&
                      state is! ProfileOnChange) {
                    Navigator.of(context).pop();
                    return;
                  }
                  await showDialog<bool>(
                    context: context,
                    builder: (acontext) => DCPopupConfirmChange(
                      title: 'Confirm change',
                      message:
                          'Look like you have made some changes to your profile',
                      boldMessage: 'Confirm these changes?',
                      onConfirmButtonClicked: (bcontext) {
                        Navigator.of(bcontext).pop(true);
                      },
                      onCancelButtonClicked: (bcontext) {
                        Navigator.of(bcontext).pop(false);
                      },
                    ),
                  ).then(
                    (value) => {
                      if (value == true)
                        {
                          context.read<ProfileBloc>().add(
                                ConfirmButtonPressedEvent(),
                              ),
                        }
                      else
                        {
                          context.read<ProfileBloc>().add(
                                CancelButtonPressedEvent(),
                              ),
                        },
                    },
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
                          if (getIDType(widget.ID) == 'DOCTOR')
                            DCOutlinedWithHeadingTextFormField(
                              heading: DefaultTextStyle.merge(
                                style:
                                    context.textTheme.h6RegularPoppins.copyWith(
                                  color: context.colorScheme.tertiary,
                                ),
                                child: const Text('Specialization'),
                              ),
                              textAlign: TextAlign.center,
                              hintText: (state as DoctorProfileInitial)
                                  .specializationId,
                              textFormFieldConstraints: BoxConstraints(
                                maxWidth: context.width * 0.9,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: context.width * 0.03,
                                vertical: context.height * 0.02,
                              ),
                              onChanged: (context, controller) =>
                                  context.read<ProfileBloc>().add(
                                        SpecializationInputEvent(
                                          controller.text,
                                        ),
                                      ),
                            ),
                          SizedBox(
                            height: context.height * 0.02,
                          ),
                          if (getIDType(widget.ID) == 'DOCTOR')
                            DCOutlinedWithHeadingTextFormField(
                              heading: DefaultTextStyle.merge(
                                style:
                                    context.textTheme.h6RegularPoppins.copyWith(
                                  color: context.colorScheme.tertiary,
                                ),
                                child: const Text('Starting year'),
                              ),
                              textAlign: TextAlign.center,
                              hintText: (state as DoctorProfileInitial)
                                  .startWorkingFrom
                                  .toString(),
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
                          //TODO (Vinh): Change password on pressed logic
                          DCFilledButton(
                            onPressed: (context) {},
                            padding: EdgeInsets.symmetric(
                              horizontal: context.width * 0.05,
                              vertical: 8,
                            ),
                            fixedSize: Size(
                              context.width * 0.9,
                              context.height * 0.07,
                            ),
                            backgroundColor: context.colorScheme.secondary,
                            child: DefaultTextStyle.merge(
                              style:
                                  context.textTheme.bodyRegularPoppins.copyWith(
                                color: context.colorScheme.onSecondary,
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

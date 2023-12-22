// ignore_for_file: public_member_api_docs
import 'package:components/components.dart';
import 'package:controllers/controllers.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:utility/utility.dart';
import 'package:views/src/screens/authentication/sign_up/controller/sign_up_bloc.dart';

class DCSignUpScreen extends StatefulWidget {
  const DCSignUpScreen({
    required this.navigatorKey,
    super.key,
  });

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<DCSignUpScreen> createState() => _DCSignUpScreenState();
}

class _DCSignUpScreenState extends State<DCSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.navigatorKey,
      appBar: DCCustomerHeaderBar(
        cornerRadius: 12,
        backgroundColor: context.colorScheme.background,
        allowNavigateBack: true,
        onLeadingIconPressed: (context) => Navigator.of(context).pop(),
      ),
      body: BlocProvider(
        create: (_) => SignUpBloc(
          widget.navigatorKey,
          context.read<AuthenticationRepositoryService>(),
          context.read<CustomerRepositoryService>(),
          NotificationManager.instance,
        ),
        child: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              Navigator.of(context, rootNavigator: true)
                  .pushReplacementNamed('/profile');
            }
          },
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.width * 0.05,
                        vertical: context.height * 0.05,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Set up your profile  ',
                                style: context.textTheme.h6BoldPoppins.copyWith(
                                  fontSize: 30,
                                ),
                              ),
                              SvgPicture.string(
                                DCSVGIcons.signup,
                                height: 34,
                                width: 34,
                              ),
                            ],
                          ),
                          Text(
                            'Create new account to access our service',
                            style: context.textTheme.h1RegularPoppins.copyWith(
                              fontSize: 20,
                            ),
                            overflow: TextOverflow.clip,
                            softWrap: true,
                          ),
                          const SizedBox(height: 8),
                          DCOutlinedWithHeadingTextFormField(
                            heading: const Text('Full Name'),
                            hintText: "What's your name?",
                            headingColor: context.colorScheme.onSurface,
                            borderColor: context.colorScheme.onBackground,
                            color: context.colorScheme.onBackground,
                            borderRadius: 16,
                            keyboardType: TextInputType.name,
                            onChanged: (context, controller) => context
                                .read<SignUpBloc>()
                                .add(FullNameInputEvent(controller.text)),
                          ),
                          const SizedBox(height: 8),
                          BlocBuilder<SignUpBloc, SignUpState>(
                            builder: (context, state) {
                              return DCOutlinedWithHeadingTextFormField(
                                heading: const Text('Birthday'),
                                hintText: 'dd/mm/yyyy',
                                headingColor: context.colorScheme.onSurface,
                                borderColor: context.colorScheme.onBackground,
                                color: context.colorScheme.onBackground,
                                borderRadius: 16,
                                keyboardType: TextInputType.datetime,
                                onChanged: (context, controller) => context
                                    .read<SignUpBloc>()
                                    .add(BirthdayInputEvent(controller.text)),
                                onFocusChange: (context, focusNode) {
                                  if (state.tempBirthday == '') {
                                    return;
                                  }
                                  if (!focusNode.hasFocus) {
                                    context.read<SignUpBloc>().add(
                                          ValidateBirthdayInputEvent(
                                            state.tempBirthday,
                                          ),
                                        );
                                  }
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          DCOutlinedWithHeadingTextFormField(
                            heading: const Text('Email'),
                            hintText: "What's your email?",
                            headingColor: context.colorScheme.onSurface,
                            borderColor: context.colorScheme.onBackground,
                            color: context.colorScheme.onBackground,
                            borderRadius: 16,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (context, controller) => context
                                .read<SignUpBloc>()
                                .add(EmailInputEvent(controller.text)),
                          ),
                          const SizedBox(height: 8),
                          DCOutlinedWithHeadingTextFormField(
                            heading: const Text('Phone'),
                            hintText: "What's your phone number?",
                            headingColor: context.colorScheme.onSurface,
                            borderColor: context.colorScheme.onBackground,
                            color: context.colorScheme.onBackground,
                            borderRadius: 16,
                            keyboardType: TextInputType.phone,
                            onChanged: (context, controller) => context
                                .read<SignUpBloc>()
                                .add(PhoneInputEvent(controller.text)),
                          ),
                          const SizedBox(height: 8),
                          DCOutlinedWithHeadingTextFormField(
                            heading: const Text('Password'),
                            hintText:
                                'Your password should be at least 8 digits',
                            headingColor: context.colorScheme.onSurface,
                            borderColor: context.colorScheme.onBackground,
                            useObscuredTextFormField: true,
                            color: context.colorScheme.onBackground,
                            borderRadius: 16,
                            keyboardType: TextInputType.visiblePassword,
                            onChanged: (context, controller) => context
                                .read<SignUpBloc>()
                                .add(PasswordInputEvent(controller.text)),
                          ),
                          const SizedBox(height: 8),
                          DCOutlinedWithHeadingTextFormField(
                            heading: const Text('Confirm Password'),
                            hintText: 'Confirm your password',
                            headingColor: context.colorScheme.onSurface,
                            borderColor: context.colorScheme.onBackground,
                            useObscuredTextFormField: true,
                            color: context.colorScheme.onBackground,
                            borderRadius: 16,
                            keyboardType: TextInputType.visiblePassword,
                            onChanged: (context, controller) => context
                                .read<SignUpBloc>()
                                .add(
                                    ConfirmPasswordInputEvent(controller.text)),
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runAlignment: WrapAlignment.center,
                            children: [
                              BlocBuilder<SignUpBloc, SignUpState>(
                                buildWhen: (previous, current) =>
                                    previous.checkedTerm != current.checkedTerm,
                                builder: (context, state) {
                                  return Checkbox(
                                    checkColor:
                                        context.colorScheme.onBackground,
                                    fillColor: state.checkedTerm
                                        ? MaterialStateProperty.all(
                                            context.colorScheme.primary,
                                          )
                                        : MaterialStateProperty.all(
                                            context.colorScheme.background,
                                          ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    side: BorderSide(
                                      color: context.colorScheme.onBackground,
                                      width: 1.5,
                                    ),
                                    value: state.checkedTerm,
                                    onChanged: (value) {
                                      context.read<SignUpBloc>().add(
                                            TermsAndConditionsCheckboxChangedEvent(
                                              !state.checkedTerm,
                                            ),
                                          );
                                    },
                                  );
                                },
                              ),
                              ...'I have read and agree to the'.split(' ').map(
                                    (word) => Text(
                                      '$word ',
                                      style: context.textTheme.h1RegularPoppins
                                          .copyWith(
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.clip,
                                      softWrap: true,
                                    ),
                                  ),
                              Text(
                                'Terms',
                                style:
                                    context.textTheme.h1RegularPoppins.copyWith(
                                  fontSize: 16,
                                  color: context.colorScheme.primary,
                                ),
                              ),
                              Text(
                                ' and ',
                                style:
                                    context.textTheme.h1RegularPoppins.copyWith(
                                  fontSize: 16,
                                  color: context.colorScheme.primary,
                                ),
                              ),
                              Text(
                                'Conditions',
                                style:
                                    context.textTheme.h1RegularPoppins.copyWith(
                                  fontSize: 16,
                                  color: context.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: BlocBuilder<SignUpBloc, SignUpState>(
                              builder: (context, state) {
                                if (state is SignUpInitial) {
                                  return DCButton(
                                    text: 'Sign Up',
                                    widthFactor: 0.8,
                                    onPressed: (context) =>
                                        context.read<SignUpBloc>().add(
                                              const SignUpButtonPressedEvent(),
                                            ),
                                  );
                                } else if (state is SignUpSuccess) {
                                  // TODO(phucchuhoang): handle navigate to home screen
                                  return const Text('Sign up success');
                                }
                                return SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: context.colorScheme.primary,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

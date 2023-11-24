// ignore_for_file: public_member_api_docs

import 'package:auth_domain/auth_domain.dart';
import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:screens/src/sign_up/controller/sign_up_bloc.dart';
import 'package:utility/utility.dart';

class DCSignUpScreen extends StatefulWidget {
  const DCSignUpScreen({super.key});

  @override
  State<DCSignUpScreen> createState() => _DCSignUpScreenState();
}

class _DCSignUpScreenState extends State<DCSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO(phucchuhoang): change appBar to custom app bar
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: BlocProvider(
        create: (_) => SignUpBloc(
          SupabaseAuthenticationRepository.instance,
          NotificationManager.instance,
        ),
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
                          headingColor: context.colorScheme.onSurface,
                          borderColor: context.colorScheme.onBackground,
                          useObscuredTextFormField: true,
                          color: context.colorScheme.onBackground,
                          borderRadius: 16,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (context, controller) => context
                              .read<SignUpBloc>()
                              .add(ConfirmPasswordInputEvent(controller.text)),
                        ),
                        Row(
                          children: [
                            BlocBuilder<SignUpBloc, SignUpState>(
                              buildWhen: (previous, current) =>
                                  previous.checkedTerm != current.checkedTerm,
                              builder: (context, state) {
                                return Checkbox(
                                  checkColor: context.colorScheme.onBackground,
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
                            Text(
                              'I have read and agree to the ',
                              style:
                                  context.textTheme.h1RegularPoppins.copyWith(
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.clip,
                              softWrap: true,
                            ),
                            Text.rich(
                              TextSpan(
                                text: 'Terms and Conditions',
                                style:
                                    context.textTheme.h1RegularPoppins.copyWith(
                                  fontSize: 16,
                                  color: context.colorScheme.primary,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // TODO(phucchuhoang): navigate to terms and conditions screen
                                  },
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
    );
  }
}

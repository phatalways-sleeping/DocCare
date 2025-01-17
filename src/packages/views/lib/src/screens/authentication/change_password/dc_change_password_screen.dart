// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:components/components.dart';
import 'package:controllers/controllers.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utility/utility.dart';
import 'package:views/src/screens/authentication/change_password/controller/change_password_bloc.dart';

class DCChangePasswordScreen extends StatefulWidget {
  const DCChangePasswordScreen({
    required this.navigatorKey,
    super.key,
  });

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<DCChangePasswordScreen> createState() => _DCChangePasswordScreenState();
}

class _DCChangePasswordScreenState extends State<DCChangePasswordScreen> {
  Timer? _timer;
  int _start = 10;
  bool _timerStarted = false;

  void startTimer() {
    setState(() {
      _start = 10; // Reset the countdown
      _timerStarted = true;
    });

    const oneSec = Duration(seconds: 1);
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.navigatorKey,
      appBar: AppBar(
        backgroundColor: context.colorScheme.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_sharp,
            color: context.colorScheme.tertiary,
            size: 40,
          ),
        ),
      ),
      body: BlocProvider(
        create: (_) => ChangePasswordBloc(
          widget.navigatorKey,
          NotificationManager.instance,
          context.read<AuthenticationRepositoryService>(),
        ),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.width * 0.03,
                      vertical: context.height * 0.02,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Forgot Password',
                          style: context.textTheme.h6BoldPoppins.copyWith(
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          'Receive password reset link through email.',
                          style: context.textTheme.h1RegularPoppins.copyWith(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 8),
                        BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                          builder: (context, state) {
                            return DCOutlinedWithHeadingTextFormField(
                              heading: const Text('Email'),
                              headingColor: context.colorScheme.onSurface,
                              borderColor: context.colorScheme.onBackground,
                              color: context.colorScheme.onBackground,
                              borderRadius: 16,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (context, controller) {
                                context.read<ChangePasswordBloc>().add(
                                      EmailInputEvent(email: controller.text),
                                    );
                              },
                              onFocusChange: (context, focusNode) {
                                if (!focusNode.hasFocus) {
                                  context
                                      .read<ChangePasswordBloc>()
                                      .add(ValidateEmailEvent(state.email));
                                }
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: BlocConsumer<ChangePasswordBloc,
                              ChangePasswordState>(
                            listener: (context, state) {
                              if (state is ChangePasswordSuccess) {
                                // Navigator.of(context, rootNavigator: true)
                                //     .pushNamed('/splash');
                                Navigator.of(context).pop();
                              }
                            },
                            builder: (context, state) {
                              if (_start > 0 && _timerStarted) {
                                // During cooldown period, show countdown
                                return Text(
                                  'Resend available in $_start seconds',
                                  style: context.textTheme.h1RegularPoppins
                                      .copyWith(fontSize: 16),
                                );
                              } else if (state is ChangePasswordInitial) {
                                // When there is an error
                                return DCFilledButton(
                                  fixedSize: Size(
                                    context.width * 0.94,
                                    context.height * 0.05,
                                  ),
                                  backgroundColor:
                                      context.colorScheme.secondary,
                                  onPressed: (context) {},
                                  child: Text(
                                    state.email.isEmpty
                                        ? 'Enter Email'
                                        : 'Invalid Email',
                                    style: context.textTheme.h1RegularPoppins
                                        .copyWith(
                                      fontSize: 16,
                                      color: context.colorScheme.onSecondary,
                                    ),
                                  ),
                                );
                              } else {
                                // De1ult state - button is enabled
                                return DCFilledButton(
                                  fixedSize: Size(
                                    context.width * 0.94,
                                    context.height * 0.05,
                                  ),
                                  backgroundColor:
                                      context.colorScheme.secondary,
                                  onPressed: (context) {
                                    if (state.email.isEmpty) {
                                      return;
                                    }
                                    context.read<ChangePasswordBloc>().add(
                                          const ChangePasswordButtonPressedEvent(),
                                        );
                                    startTimer(); // Start or restart the timer
                                  },
                                  child: Text(
                                    'Send Password Reset Link',
                                    style: context.textTheme.h1RegularPoppins
                                        .copyWith(
                                      fontSize: 16,
                                      color: context.colorScheme.onSecondary,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        )
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

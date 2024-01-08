import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/src/screens/authentication/login/controller/login_bloc.dart';

/// [_DCLoginModalBottomSheet] is a [StatelessWidget] that displays a modal
/// bottom sheet for logging in.
/// It appears when the user taps the "Get Started" button on the
class _DCLoginModalBottomSheet extends StatefulWidget {
  /// [_DCLoginModalBottomSheet] constructor.
  const _DCLoginModalBottomSheet({
    this.passwordController,
  });

  final TextEditingController? passwordController;

  @override
  State<_DCLoginModalBottomSheet> createState() =>
      __DCLoginModalBottomSheetState();
}

class __DCLoginModalBottomSheetState extends State<_DCLoginModalBottomSheet> {
  late double height = context.height * 0.5;

  late final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: height,
      padding: EdgeInsets.symmetric(
        horizontal: context.width * 0.05,
        vertical: 10,
      ),
      duration: const Duration(milliseconds: 800),
      curve: Curves.decelerate,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: context.width * 0.15,
            height: 3,
            decoration: BoxDecoration(
              color: context.colorScheme.onBackground,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          DCOutlinedTextFormField(
            controller: emailController,
            borderColor: context.colorScheme.onBackground,
            color: context.colorScheme.onBackground,
            borderRadius: 16,
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.width * 0.03,
              vertical: context.height * 0.02,
            ),
            labelText: 'Email',
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            onFocus: (context, focusNode) {
              if (height == context.height * 0.5) {
                setState(() {
                  height = context.height * 0.75;
                });
              }
            },
            onChanged: (context, controller) =>
                context.read<LoginBloc>().add(EmailInputEvent(controller.text)),
          ),
          DCOutlinedObscuredTextFormField(
            controller: widget.passwordController,
            borderColor: context.colorScheme.onBackground,
            color: context.colorScheme.onBackground,
            borderRadius: 16,
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.width * 0.03,
              vertical: context.height * 0.02,
            ),
            labelText: 'Password',
            hintText: 'Enter your password',
            onFocus: (context, focusNode) {
              if (height == context.height * 0.5) {
                setState(() {
                  height = context.height * 0.75;
                });
              }
            },
            onChanged: (context, controller) => context
                .read<LoginBloc>()
                .add(PasswordInputEvent(controller.text)),
          ),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              final body = state is LoginLoading
                  ? SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        color: context.colorScheme.onBackground,
                      ),
                    )
                  : Text(
                      'Login',
                      style: context.textTheme.bodyRegularPoppins.copyWith(
                        color: context.colorScheme.onError,
                        fontSize: 16,
                      ),
                    );
              return DCFilledButton(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.05,
                  vertical: 8,
                ),
                fixedSize: Size(
                  context.width * 0.90,
                  context.height * 0.05,
                ),
                backgroundColor: context.colorScheme.error,
                onPressed: (context) {
                  if (state is LoginLoading) return;
                  widget.passwordController?.clear();
                  context.read<LoginBloc>().add(
                        const LoginButtonPressedEvent(),
                      );
                },
                child: body,
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Divider(
                  color: context.colorScheme.onBackground,
                  thickness: 2,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                'OR',
                style: context.textTheme.bodyRegularPoppins.copyWith(
                  color: context.colorScheme.onBackground,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Divider(
                  color: context.colorScheme.onBackground,
                  thickness: 2,
                ),
              ),
            ],
          ),
          DCFilledButton(
            backgroundColor: context.colorScheme.secondary,
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.05,
              vertical: 8,
            ),
            fixedSize: Size(
              context.width * 0.90,
              context.height * 0.05,
            ),
            onPressed: (context) => Navigator.pushNamed(context, '/sign-up'),
            child: Text(
              'Create new account',
              style: context.textTheme.bodyRegularPoppins.copyWith(
                color: context.colorScheme.onSecondary,
                fontSize: 16,
              ),
            ),
          ),
          DCFilledButton(
            backgroundColor: context.colorScheme.primary,
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.05,
              vertical: 8,
            ),
            fixedSize: Size(
              context.width * 0.90,
              context.height * 0.05,
            ),
            onPressed: (context) =>
                Navigator.pushNamed(context, '/forgot-password'),
            child: Text(
              'I have forgotten my password',
              style: context.textTheme.bodyRegularPoppins.copyWith(
                color: context.colorScheme.onBackground,
                fontSize: 16,
              ),
            ),
          ),
          DCOutlinedButton(
            borderSide: BorderSide(
              color: context.colorScheme.onBackground,
              width: 1.5,
            ),
            splashColor: context.colorScheme.onBackground,
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.05,
              vertical: 8,
            ),
            fixedSize: Size(
              context.width * 0.90,
              context.height * 0.05,
            ),
            onPressed: (context) {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/google.png',
                  width: context.width * 0.05,
                  height: context.height * 0.05,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  'Sign in with Google',
                  style: context.textTheme.bodyRegularPoppins.copyWith(
                    color: context.colorScheme.onSurface,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// [showDCLoginModalBottomSheet] is a function that displays a modal
/// bottom sheet for logging in.
Future<T?> showDCLoginModalBottomSheet<T>(
  BuildContext context,
  AnimationController transitionAnimationController, {
  double borderRaidus = 40,
  TextEditingController? passwordController,
}) {
  final loginBloc = context.read<LoginBloc>();
  return showModalBottomSheet<T>(
    elevation: 0,
    context: context,
    backgroundColor: context.colorScheme.background,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(borderRaidus),
        topRight: Radius.circular(borderRaidus),
      ),
      side: BorderSide(
        color: context.colorScheme.secondary,
        width: 2,
      ),
    ),
    constraints: BoxConstraints(
      maxHeight: context.height * 0.75,
    ),
    transitionAnimationController: transitionAnimationController..forward(),
    // Pass the [LoginBloc] to the [_DCLoginModalBottomSheet]
    // to use it's [LoginState] and [LoginEvent]
    builder: (context) => BlocProvider.value(
      value: loginBloc,
      child: _DCLoginModalBottomSheet(
        passwordController: passwordController,
      ),
    ),
  );
}

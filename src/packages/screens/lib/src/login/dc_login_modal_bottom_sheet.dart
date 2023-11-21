import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/screens.dart' show DCSplashScreen;
import 'package:screens/src/login/controller/login_bloc.dart';

/// [DCLoginModalBottomSheet] is a [StatelessWidget] that displays a modal
/// bottom sheet for logging in.
/// It appears when the user taps the "Get Started" button on the
/// [DCSplashScreen].
class DCLoginModalBottomSheet extends StatefulWidget {
  /// [DCLoginModalBottomSheet] constructor.
  const DCLoginModalBottomSheet({super.key});

  @override
  State<DCLoginModalBottomSheet> createState() =>
      _DCLoginModalBottomSheetState();
}

class _DCLoginModalBottomSheetState extends State<DCLoginModalBottomSheet> {
  late double height = context.height * 0.5;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        /// If the state is [LoginSuccess], we will navigate to the home screen.
        if (state is LoginSuccess) {
          /// TODO: Navigate to home screen
        }
      },
      child: AnimatedContainer(
        height: height,
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.05,
          vertical: context.height * 0.005,
        ),
        duration: const Duration(milliseconds: 800),
        curve: Curves.decelerate,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    height = context.height * 0.6;
                  });
                }
              },
              onChanged: (context, controller) => context
                  .read<LoginBloc>()
                  .add(EmailInputEvent(controller.text)),
            ),
            DCOutlinedObscuredTextFormField(
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
                    height = context.height * 0.6;
                  });
                }
              },
              onChanged: (context, controller) => context
                  .read<LoginBloc>()
                  .add(PasswordInputEvent(controller.text)),
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return SizedBox(
                    width: context.width * 0.10,
                    height: context.height * 0.05,
                    child: CircularProgressIndicator(
                      color: context.colorScheme.error,
                    ),
                  );
                }
                return DCFilledButton(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.05,
                    vertical: 8,
                  ),
                  fixedSize: Size(
                    context.width * 0.80,
                    context.height * 0.05,
                  ),
                  backgroundColor: context.colorScheme.error,
                  onPressed: (context) => context.read<LoginBloc>().add(
                        const LoginButtonPressedEvent(),
                      ),
                  child: Text(
                    'Login',
                    style: context.textTheme.bodyRegularPoppins.copyWith(
                      color: context.colorScheme.onError,
                      fontSize: 16,
                    ),
                  ),
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
              onPressed: (context) {},
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
              onPressed: (context) {},
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
      ),
    );
  }
}

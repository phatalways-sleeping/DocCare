import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

Future<bool?> showConfirmationDialog(BuildContext context) => showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: context.width * 0.9,
            height: context.height * 0.35,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Confirm Change',
                  style: context.textTheme.h1BoldPoppins.copyWith(
                    fontSize: 24,
                    color: context.colorScheme.tertiary,
                  ),
                ),
                Text(
                  'Look like you have made some changes to your profile.',
                  style: context.textTheme.bodyRegularPoppins.copyWith(
                    fontSize: 16,
                    color: context.colorScheme.tertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Confirm these changes?',
                  style: context.textTheme.bodyBoldPoppins.copyWith(
                    fontSize: 16,
                    color: context.colorScheme.tertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DCFilledButton(
                      onPressed: (context) => Navigator.of(context).pop(false),
                      backgroundColor: context.colorScheme.error,
                      fixedSize: Size(
                        context.width * 0.4,
                        50,
                      ),
                      child: Text(
                        'Cancel',
                        style: context.textTheme.bodyRegularPoppins.copyWith(
                          fontSize: 16,
                          color: context.colorScheme.tertiary,
                        ),
                      ),
                    ),
                    DCFilledButton(
                      onPressed: (context) => Navigator.of(context).pop(true),
                      backgroundColor: context.colorScheme.primary,
                      fixedSize: Size(
                        context.width * 0.4,
                        50,
                      ),
                      child: Text(
                        'Confirm',
                        style: context.textTheme.bodyRegularPoppins.copyWith(
                          fontSize: 16,
                          color: context.colorScheme.tertiary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

Future<List<String>?> showPasswordChangeDialog(
  BuildContext context,
) {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  return showDialog<List<String>?>(
    context: context,
    barrierDismissible: false,
    builder: (context) => Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: context.width * 0.9,
          height: context.height * 0.40,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Change Password',
                style: context.textTheme.h1BoldPoppins.copyWith(
                  fontSize: 24,
                  color: context.colorScheme.tertiary,
                ),
              ),
              DCOutlinedWithHeadingTextFormField(
                controller: newPasswordController,
                heading: Text(
                  'New password',
                  style: context.textTheme.bodyBoldPoppins.copyWith(
                    fontSize: 16,
                    color: context.colorScheme.tertiary,
                  ),
                ),
                hintText: 'Enter new password',
                borderColor: context.colorScheme.secondary,
                borderRadius: 16,
                color: context.colorScheme.tertiary,
              ),
              DCOutlinedWithHeadingTextFormField(
                controller: confirmPasswordController,
                heading: Text(
                  'Confirm new password',
                  style: context.textTheme.bodyBoldPoppins.copyWith(
                    fontSize: 16,
                    color: context.colorScheme.tertiary,
                  ),
                ),
                hintText: 'Reenter new password',
                borderColor: context.colorScheme.secondary,
                borderRadius: 16,
                color: context.colorScheme.tertiary,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DCFilledButton(
                    onPressed: (context) {
                      Navigator.of(context).pop();
                    },
                    backgroundColor: context.colorScheme.error,
                    fixedSize: Size(
                      context.width * 0.35,
                      40,
                    ),
                    child: Text(
                      'Cancel',
                      style: context.textTheme.bodyRegularPoppins.copyWith(
                        fontSize: 16,
                        color: context.colorScheme.tertiary,
                      ),
                    ),
                  ),
                  DCFilledButton(
                    onPressed: (context) {
                      final newPassword = newPasswordController.text;
                      final confirmPassword = confirmPasswordController.text;

                      Navigator.of(context).pop([
                        newPassword,
                        confirmPassword,
                      ]);
                    },
                    backgroundColor: context.colorScheme.primary,
                    fixedSize: Size(
                      context.width * 0.35,
                      40,
                    ),
                    child: Text(
                      'Confirm',
                      style: context.textTheme.bodyRegularPoppins.copyWith(
                        fontSize: 16,
                        color: context.colorScheme.tertiary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

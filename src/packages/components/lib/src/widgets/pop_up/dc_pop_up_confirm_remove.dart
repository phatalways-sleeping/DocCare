import 'package:components/components.dart';
import 'package:components/src/widgets/pop_up/base_pop_up.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class DCPopupConfirmRemove extends StatelessWidget {
  const DCPopupConfirmRemove({
    Key? key,
    required this.title,
    required this.message,
    this.titleTextSize,
    this.titleAlignment,
    this.titleTextColor,
    this.cancelButtonText,
    this.agreeButtonText,
    this.messageTextSize,
    this.messageTextColor,
    this.buttonsWidth,
    this.buttonsHeight,
    this.cancelButtonColor,
    this.agreeButtonColor,
    this.buttonsTextSize,
    this.buttonsTextColors,
    this.onCancelButtonClicked,
    this.onConfirmButtonClicked,
  }) : super(key: key);

  final String title;
  final Color? titleTextColor;
  final double? titleTextSize;
  final TextAlign? titleAlignment;

  final String message;
  final Color? messageTextColor;
  final double? messageTextSize;

  final String? cancelButtonText;
  final String? agreeButtonText;
  final Color? cancelButtonColor;
  final Color? agreeButtonColor;
  final double? buttonsWidth;
  final double? buttonsHeight;
  final double? buttonsTextSize;
  final Color? buttonsTextColors;
  final void Function(BuildContext context)? onCancelButtonClicked;
  final void Function(BuildContext context)? onConfirmButtonClicked;

  @override
  Widget build(BuildContext context) {
    //Center everything in the middle column using Alert Dialog

    return BasePopup(
      title: Text(title),
      titleTextColor: titleTextColor ?? context.colorScheme.tertiary,
      titleTextSize: titleTextSize ?? 24,
      titleAlignment: titleAlignment,
      message: [
        DefaultTextStyle.merge(
          style: context.textTheme.h4RegularPoppins.copyWith(
            fontSize: messageTextSize ?? 14,
            fontWeight: FontWeight.normal,
            color: messageTextColor ?? context.colorScheme.onTertiary,
          ),
          textAlign: TextAlign.center,
          child: Text(message),
        ),
      ],
      buttonsText: [
        cancelButtonText ?? 'Cancel',
        agreeButtonText ?? 'Confirm',
      ],
      buttonsColor: [
        cancelButtonColor ?? context.colorScheme.error,
        agreeButtonColor ?? context.colorScheme.primary,
      ],
      buttonsWidth: buttonsWidth,
      buttonsHeight: buttonsHeight,
      buttonsTextSize: buttonsTextSize ?? 14,
      buttonsTextColors: buttonsTextColors ?? context.colorScheme.onBackground,
      onConfirmButtonClicked: (context) =>
          onConfirmButtonClicked ?? Navigator.of(context).pop(),
      onCancelButtonClicked: (context) =>
          onConfirmButtonClicked ?? Navigator.of(context).pop(),
    );
  }
}

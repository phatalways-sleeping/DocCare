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
    this.confirmButtonText,
    this.messageTextSize,
    this.messageTextColor,
    this.buttonsWidth,
    this.buttonsHeight,
    this.cancelButtonColor,
    this.confirmButtonColor,
    this.buttonsTextSize,
    this.cancelButtonTextColor,
    this.confirmButtonTextColor,
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
  final String? confirmButtonText;
  final Color? cancelButtonColor;
  final Color? confirmButtonColor;
  final double? buttonsWidth;
  final double? buttonsHeight;
  final double? buttonsTextSize;
  final Color? cancelButtonTextColor;
  final Color? confirmButtonTextColor;
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
      buttonsHasBorder: const [true, false],
      buttonsText: [
        cancelButtonText ?? 'Cancel',
        confirmButtonText ?? 'Confirm',
      ],
      buttonsColor: [
        cancelButtonColor ?? context.colorScheme.error,
        confirmButtonColor ?? context.colorScheme.secondary,
      ],
      buttonsWidth: buttonsWidth,
      buttonsHeight: buttonsHeight,
      buttonsTextSize: buttonsTextSize ?? 14,
      buttonsTextColors: [
        cancelButtonTextColor ?? context.colorScheme.onBackground,
        confirmButtonTextColor ?? context.colorScheme.onBackground,
      ],
      onConfirmButtonClicked: (context) =>
          onConfirmButtonClicked ?? Navigator.of(context).pop(),
      onCancelButtonClicked: (context) =>
          onConfirmButtonClicked ?? Navigator.of(context).pop(),
    );
  }
}

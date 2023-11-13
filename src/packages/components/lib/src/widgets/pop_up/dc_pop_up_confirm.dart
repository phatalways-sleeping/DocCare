import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:components/src/widgets/pop_up/base_pop_up.dart';

class DCPopupConfirm extends StatelessWidget {
  const DCPopupConfirm({
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
    this.onAgreeButtonClicked,
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
  final void Function(BuildContext contet)? onCancelButtonClicked;
  final void Function(BuildContext contet)? onAgreeButtonClicked;

  @override
  Widget build(BuildContext context) {
    //Center everything in the middle column using Alert Dialog

    return BasePopup(
      title: Text(title),
      titleTextColor: titleTextColor,
      titleTextSize: titleTextSize,
      titleAlignment: titleAlignment,
      message: [
        Text(
          message,
          style: context.textTheme.h4BoldPoppins.copyWith(
            fontSize: messageTextSize ?? 16,
            fontWeight: FontWeight.normal,
            color: messageTextColor ?? const Color.fromRGBO(103, 114, 148, 1),
          ),
          textAlign: TextAlign.center,
        ),
      ],
      buttonsText: [
        cancelButtonText ?? 'Cancel',
        agreeButtonText ?? 'Confirm',
      ],
      buttonsColor: [
        cancelButtonColor ?? const Color.fromRGBO(244, 204, 183, 1),
        agreeButtonColor ?? const Color.fromRGBO(139, 240, 180, 0.78),
      ],
      buttonsWidth: buttonsWidth,
      buttonsHeight: buttonsHeight,
      buttonsTextSize: buttonsTextSize ?? 16,
      buttonsTextColors: buttonsTextColors ?? context.colorScheme.onBackground,
      onPopupButtonClicked: [
        onCancelButtonClicked ?? Navigator.of(context).pop,
        onAgreeButtonClicked ?? Navigator.of(context).pop,
      ],
    );
  }
}

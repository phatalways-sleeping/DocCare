import 'package:components/components.dart';
import 'package:components/src/widgets/pop_up/base_pop_up.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DCPopupSuccess extends StatelessWidget {
  const DCPopupSuccess({
    Key? key,
    required this.boldMessage,
    required this.message,
    this.buttonText,
    this.boldMessageTextSize,
    this.boldMessageTextColor,
    this.messageTextSize,
    this.messageTextColor,
    this.buttonsWidth,
    this.buttonsHeight,
    this.buttonsColor,
    this.buttonsTextSize,
    this.confirmButtonTextColor,
    this.onConfirmButtonClicked,
  }) : super(key: key);

  final String boldMessage;
  final Color? boldMessageTextColor;
  final double? boldMessageTextSize;
  final String message;
  final Color? messageTextColor;
  final double? messageTextSize;

  final String? buttonText;
  final Color? buttonsColor;
  final double? buttonsWidth;
  final double? buttonsHeight;
  final double? buttonsTextSize;
  final Color? confirmButtonTextColor;

  final void Function(BuildContext context)? onConfirmButtonClicked;

  @override
  Widget build(BuildContext context) {
    //Center everything in the middle column using Alert Dialog
    return BasePopup(
      message: [
        DefaultTextStyle.merge(
          style: context.textTheme.h4BoldPoppins.copyWith(
            fontWeight: FontWeight.normal,
            fontSize: boldMessageTextSize ?? 24,
            color: boldMessageTextColor ?? context.colorScheme.onBackground,
          ),
          textAlign: TextAlign.center,
          child: Text(boldMessage),
        ),
        DefaultTextStyle.merge(
          style: context.textTheme.h4RegularPoppins.copyWith(
            fontWeight: FontWeight.normal,
            fontSize: messageTextSize ?? 16,
            color: messageTextColor ?? context.colorScheme.tertiary,
          ),
          textAlign: TextAlign.center,
          child: Text(message),
        ),
      ],
      buttonsText: [
        buttonText ?? 'Confirm',
      ],
      buttonsColor: [buttonsColor ?? context.colorScheme.secondary],
      buttonsWidth: buttonsWidth,
      buttonsHeight: buttonsHeight,
      buttonsTextSize: buttonsTextSize ?? 16,
      buttonsTextColors: [
        confirmButtonTextColor ?? context.colorScheme.onBackground,
      ],
      popupIcon: FractionallySizedBox(
        child: SvgPicture.string(
          DCSVGIcons.success,
          fit: BoxFit.cover,
        ),
      ),
      iconBackgroundColor: const Color.fromRGBO(231, 248, 242, 1),
      onConfirmButtonClicked: (context) =>
          onConfirmButtonClicked ?? Navigator.of(context).pop(),
    );
  }
}

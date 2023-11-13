import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:components/src/widgets/pop_up/base_pop_up.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DCPopupFailed extends StatelessWidget {
  const DCPopupFailed({
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
    this.buttonsTextColors,
    this.onPopupButtonClicked,
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
  final Color? buttonsTextColors;

  final Function? onPopupButtonClicked;

  @override
  Widget build(BuildContext context) {
    //Center everything in the middle column using Alert Dialog
    return BasePopup(
      message: [
        DefaultTextStyle.merge(
          style: context.textTheme.h4BoldPoppins.copyWith(
            fontSize: boldMessageTextSize ?? 24,
            fontWeight: FontWeight.bold,
            color: boldMessageTextColor ?? context.colorScheme.onBackground,
          ),
          textAlign: TextAlign.center,
          child: Text(boldMessage),
        ),
        DefaultTextStyle.merge(
          style: context.textTheme.h4BoldPoppins.copyWith(
            fontSize: messageTextSize ?? 16,
            fontWeight: FontWeight.normal,
            color: messageTextColor ?? const Color.fromRGBO(103, 114, 148, 1),
          ),
          textAlign: TextAlign.center,
          child: Text(message),
        ),
      ],
      buttonsColor: [buttonsColor ?? const Color.fromRGBO(244, 204, 183, 1)],
      buttonsWidth: buttonsWidth,
      buttonsHeight: buttonsHeight,
      buttonsTextSize: buttonsTextSize ?? 16,
      buttonsTextColors: buttonsTextColors ?? context.colorScheme.onBackground,
      popupIcon: Flexible(
        child: FractionallySizedBox(
          child: SvgPicture.string(
            DCSVGIcons.error,
            fit: BoxFit.cover,
          ),
        ),
      ),
      iconBackgroundColor: const Color.fromRGBO(244, 204, 183, 1),
      onPopupButtonClicked: [onPopupButtonClicked ?? Navigator.of(context).pop],
      buttonsText: [
        buttonText ?? 'Confirm',
      ],
    );
  }
}

import 'package:components/components.dart';
import 'package:components/src/widgets/pop_up/base_pop_up.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DCPopupDoctorCancel extends StatelessWidget {
  const DCPopupDoctorCancel({
    Key? key,
    required this.boldMessage,
    required this.message,
    this.cancelButtonText,
    this.agreeButtonText,
    this.boldMessageTextSize,
    this.boldMessageTextColor,
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

  final String boldMessage;
  final Color? boldMessageTextColor;
  final double? boldMessageTextSize;
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
  final void Function(BuildContext context)? onAgreeButtonClicked;

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
          style: context.textTheme.h4RegularPoppins.copyWith(
            fontSize: messageTextSize ?? 16,
            fontWeight: FontWeight.normal,
            color: messageTextColor ?? context.colorScheme.tertiary,
          ),
          textAlign: TextAlign.center,
          child: Text(message),
        ),
      ],
      buttonsText: [
        cancelButtonText ?? 'Cancel',
        agreeButtonText ?? 'Agree',
      ],
      buttonsColor: [
        cancelButtonColor ?? context.colorScheme.error,
        agreeButtonColor ?? context.colorScheme.primary,
      ],
      buttonsWidth: buttonsWidth,
      buttonsHeight: buttonsHeight,
      buttonsTextSize: buttonsTextSize ?? 16,
      buttonsTextColors: buttonsTextColors ?? context.colorScheme.onBackground,
      popupIcon: FractionallySizedBox(
        child: SvgPicture.string(
          DCSVGIcons.sad,
          fit: BoxFit.cover,
        ),
      ),
      iconBackgroundColor:
          const Color.fromRGBO(231, 248, 242, 1), //Add to color scheme later
      onPopupButtonClicked: [
        (context) => onAgreeButtonClicked ?? Navigator.of(context).pop(),
        (context) => onAgreeButtonClicked ?? Navigator.of(context).pop(),
      ],
    );
  }
}
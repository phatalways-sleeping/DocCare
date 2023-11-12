import 'package:components/components.dart';
import 'package:components/src/widgets/pop_up/base_pop_up.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DCPopupDoctorCancel extends StatelessWidget {
  const DCPopupDoctorCancel({
    Key? key,
    required this.message,
    required this.buttonText,
    this.messageTextSize,
    this.messageAlignment,
    this.messageTextColor,
    this.title,
    this.titleTextSize,
    this.titleAlignment,
    this.titleTextColor,
    this.iconWidth,
    this.iconHeight,
    this.iconBackgroundColor,
    this.buttonsWidth,
    this.buttonsHeight,
    this.buttonsColor,
    this.buttonsTextSize,
    this.buttonsTextColors,
    this.onPopupButtonClicked,
  }) : super(key: key);

  final Widget? title;
  final double? titleTextSize;
  final TextAlign? titleAlignment;
  final Color? titleTextColor;

  final List<Widget> message;
  final List<Color>? messageTextColor;
  final List<double>? messageTextSize;
  final List<TextAlign>? messageAlignment;

  final double? iconWidth;
  final double? iconHeight;
  final Color? iconBackgroundColor;

  final List<Text> buttonText;
  final List<Color>? buttonsColor;
  final double? buttonsWidth;
  final double? buttonsHeight;
  final double? buttonsTextSize;
  final Color? buttonsTextColors;

  final List<Function>? onPopupButtonClicked;

  @override
  Widget build(BuildContext context) {
    //Center everything in the middle column using Alert Dialog
    return BasePopup(
      message: message,
      messageTextColor: messageTextColor,
      messageTextSize: messageTextSize,
      messageAlignment: messageAlignment,
      title: title,
      titleTextSize: titleTextSize,
      titleAlignment: titleAlignment,
      titleTextColor: titleTextColor,
      buttonsText: buttonText,
      buttonsColor: buttonsColor,
      buttonsWidth: buttonsWidth,
      buttonsHeight: buttonsHeight,
      buttonsTextSize: buttonsTextSize,
      buttonsTextColors: buttonsTextColors,
      popupIcon: SvgPicture.string(
        DCSVGIcons.sad,
        fit: BoxFit.cover,
        width: iconHeight,
        height: iconWidth,
      ),
      popupIconHeight: iconHeight,
      popupIconWidth: iconWidth,
      iconBackgroundColor: iconBackgroundColor ?? context.colorScheme.primary,
      onPopupButtonClicked: onPopupButtonClicked,
    );
  }
}

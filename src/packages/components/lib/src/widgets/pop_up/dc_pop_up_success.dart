import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:components/src/widgets/pop_up/base_pop_up.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DCPopupSuccess extends StatelessWidget {
  const DCPopupSuccess({
    Key? key,
    required this.boldMessage,
    required this.message,
    required this.buttonText,
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

  final String buttonText;
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
        Text(
          boldMessage,
          style: context.textTheme.h4BoldPoppins.copyWith(
            fontWeight: FontWeight.normal,
            fontSize: boldMessageTextSize ?? 24,
          ),
        ),
        Text(
          message,
          style: context.textTheme.h4BoldPoppins.copyWith(
            fontWeight: FontWeight.normal,
            fontSize: messageTextSize ?? 16,
          ),
        ),
      ],
      messageTextColor: [
        boldMessageTextColor ?? context.colorScheme.onBackground,
        messageTextColor ?? const Color.fromRGBO(103, 114, 148, 1),
      ],
      messageTextSize: [boldMessageTextSize ?? 24, messageTextSize ?? 16],
      buttonsText: [
        Text(
          buttonText,
        ),
      ],
      buttonsColor: [buttonsColor ?? const Color.fromRGBO(139, 240, 180, 0.78)],
      buttonsWidth: buttonsWidth,
      buttonsHeight: buttonsHeight,
      buttonsTextSize: buttonsTextSize ?? 16,
      buttonsTextColors: buttonsTextColors ?? context.colorScheme.background,
      popupIcon: Flexible(
        child: FractionallySizedBox(
          child: SvgPicture.string(
            DCSVGIcons.success,
            fit: BoxFit.cover,
          ),
        ),
      ),
      iconBackgroundColor: const Color.fromRGBO(139, 240, 180, 0.78),
      onPopupButtonClicked: [onPopupButtonClicked ?? Navigator.of(context).pop],
    );
  }
}

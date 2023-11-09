import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:components/src/widgets/pop_up/base_pop_up.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DCPopupFailed extends StatelessWidget {
  const DCPopupFailed({
    Key? key,
    required this.title,
    required this.message,
    required this.buttonText,
    this.iconWidth,
    this.iconHeight,
  }) : super(key: key);

  final String title;
  final String message;
  final String buttonText;
  final double? iconWidth;
  final double? iconHeight;

  @override
  Widget build(BuildContext context) {
    //Center everything in the middle column using Alert Dialog
    return BasePopup(
      title: title,
      message: message,
      buttonText: buttonText,
      buttonColor: context.colorScheme.error,
      popupIcon: SvgPicture.string(
        DCSVGIcons.error,
        fit: BoxFit.cover,
        width: iconHeight ?? 100,
        height: iconWidth ?? 100,
      ),
    );
  }
}

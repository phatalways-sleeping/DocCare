import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:components/src/widgets/button/dc_button.dart';

class BasePopup extends StatelessWidget {
  const BasePopup({
    required this.message,
    required this.buttonsText,
    this.popupPadding,
    this.buttonsWidth,
    this.buttonsHeight,
    this.buttonsColor,
    this.buttonsTextSize,
    this.buttonsTextColors,
    this.buttonsTextStyle,
    this.popupIcon,
    this.popupIconWidth,
    this.popupIconHeight,
    this.iconBackgroundColor,
    this.title,
    this.titleTextSize,
    this.titleAlignment,
    this.titleTextColor,
    this.messageAlligment,
    this.onConfirmButtonClicked,
    this.onCancelButtonClicked,
    super.key,
  });

  final Widget? title;
  final Color? iconBackgroundColor;
  //Message is in a list so that many message can be stack on each other
  final double? popupPadding;
  final List<Widget> message;
  final List<String> buttonsText;
  final List<Color>? buttonsColor;
  final TextStyle? buttonsTextStyle;
  final double? buttonsWidth;
  final double? buttonsHeight;
  final double? buttonsTextSize;
  final Color? buttonsTextColors;
  final Widget? popupIcon;
  final double? popupIconWidth;
  final double? popupIconHeight;
  final Color? titleTextColor;
  final double? titleTextSize;
  final TextAlign? titleAlignment;
  final CrossAxisAlignment? messageAlligment;
  final void Function(BuildContext context)? onConfirmButtonClicked;
  final void Function(BuildContext context)? onCancelButtonClicked;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(popupPadding ?? 10),
      //set up title with title alignment, title text size and title text color
      title: DefaultTextStyle.merge(
        style: context.textTheme.h4ExtraBoldPoppins.copyWith(
          color: titleTextColor ?? context.colorScheme.onBackground,
          fontSize: titleTextSize ?? 24,
          fontWeight: FontWeight.bold,
        ),
        textAlign: titleAlignment ?? TextAlign.center,
        child: title ?? const SizedBox.shrink(),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: (popupIcon == null)
                ? const FractionallySizedBox(
                    heightFactor: 0.01,
                  )
                : FractionallySizedBox(
                    widthFactor: 0.75,
                    heightFactor: 0.5,
                    child: SizedBox(
                      child: Container(
                        decoration: BoxDecoration(
                          color: iconBackgroundColor ??
                              context.colorScheme.background,
                          shape: BoxShape.circle,
                        ),
                        child: Transform.scale(
                          scale: 3,
                          child: Center(child: popupIcon),
                        ),
                      ),
                    ),
                  ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: messageAlligment ?? CrossAxisAlignment.center,
            //chidren containts message with padding from top
            children: List.generate(
              message.length,
              (index) => Padding(
                padding: EdgeInsets.only(
                  top: (index > 0 && index.isEven) ? (popupPadding ?? 10) : 0,
                ),
                child: message[index],
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        //set up button with button alignment
        FractionallySizedBox(
          widthFactor: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              buttonsText.length,
              (index) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  //use dc button to make it easier to customize
                  child: DCButton(
                    fillParentWidth: true,
                    text: buttonsText[index],
                    buttonWidth: buttonsWidth,
                    buttonHeight: buttonsHeight,
                    textStyle: buttonsTextStyle,
                    textSize: buttonsTextSize,
                    textColor: buttonsTextColors,
                    backgroundColor: buttonsColor?[index],
                    borderWidth: 0,
                    borderColor: context.colorScheme.background,
                    onPressed: () {
                      if (index.isOdd || onConfirmButtonClicked == null) {
                        onCancelButtonClicked?.call(context);
                      }
                      if (index.isEven || onCancelButtonClicked == null) {
                        onConfirmButtonClicked?.call(context);
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    );
  }
}

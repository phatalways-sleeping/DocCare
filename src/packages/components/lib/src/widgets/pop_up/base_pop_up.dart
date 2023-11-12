import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class BasePopup extends StatelessWidget {
  const BasePopup({
    required this.message,
    required this.buttonsText,
    this.buttonsWidth,
    this.buttonsHeight,
    this.buttonsColor,
    this.buttonsTextSize,
    this.buttonsTextColors,
    this.popupIcon,
    this.popupIconWidth,
    this.popupIconHeight,
    this.iconBackgroundColor,
    this.title,
    this.titleTextSize,
    this.titleAlignment,
    this.titleTextColor,
    this.messageTextColor,
    this.messageTextSize,
    this.messageAlignment,
    this.onPopupButtonClicked,
    super.key,
  });

  final Widget? title;
  final Color? iconBackgroundColor;
  //Message is in a list so that many message can be stack on each other
  final List<Widget> message;
  final List<Color>? messageTextColor;
  final List<double>? messageTextSize;
  final List<TextAlign>? messageAlignment;
  final List<Text> buttonsText;
  final List<Color>? buttonsColor;
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
  final List<Function>? onPopupButtonClicked;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //set up title with title alignment, title text size and title text color
      title: DefaultTextStyle.merge(
        style: context.textTheme.h4ExtraBoldPoppins.copyWith(
          color: titleTextColor ?? context.colorScheme.primary,
          fontSize: titleTextSize ?? 24,
          fontWeight: FontWeight.bold,
        ),
        textAlign: titleAlignment ?? TextAlign.center,
        child: title ?? Container(),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //Setup icon for popup
          //If has icon size, setup size, else don't do anything
          Flexible(
            //scale the background circle to be a bit bigger than the icon
            child: (popupIcon == null)
                ? FractionallySizedBox(
                    heightFactor: 0.1,
                  )
                : FractionallySizedBox(
                    widthFactor: 0.5,
                    heightFactor: 0.5,
                    child: Container(
                      width: popupIconHeight,
                      height: popupIconWidth,
                      decoration: BoxDecoration(
                        color: iconBackgroundColor ??
                            context.colorScheme.background,
                        shape: BoxShape.circle,
                      ),
                      child: Transform.scale(
                        scale: 2,
                        child: Center(
                          child: popupIcon ?? Container(),
                        ),
                      ),
                    ),
                  ),
          ),
          //Set up message with message alignment, message text size and message text color
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              message.length,
              (index) => DefaultTextStyle.merge(
                style: context.textTheme.h4BoldPoppins.copyWith(
                  color:
                      messageTextColor?[index] ?? context.colorScheme.primary,
                  fontSize: messageTextSize?[index] ?? 16,
                ),
                textAlign: messageAlignment?[index] ?? TextAlign.center,
                child: Column(
                  children: [
                    message[index],
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        //set up button with button alignment
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            buttonsText.length,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 8),
              //Create buttons with different pressed method
              child: SizedBox(
                width: buttonsHeight,
                height: buttonsWidth,
                child: ElevatedButton(
                  onPressed: () {
                    //If there is a pressed method, call it
                    if (onPopupButtonClicked != null &&
                        onPopupButtonClicked?[index] != null) {
                      // ignore: avoid_dynamic_calls
                      onPopupButtonClicked?[index](context);
                    }
                    //Else close the popup
                    else {
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        buttonsColor?[index] ?? context.colorScheme.primary,
                  ),
                  child: DefaultTextStyle.merge(
                    style: context.textTheme.h4ExtraBoldPoppins.copyWith(
                      color: buttonsTextColors ?? context.colorScheme.primary,
                      fontSize: buttonsTextSize ?? 16,
                    ),
                    textAlign: TextAlign.center,
                    child: buttonsText[index],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}

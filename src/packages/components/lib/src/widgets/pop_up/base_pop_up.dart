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
    this.messageAlligment,
    this.onPopupButtonClicked = const [],
    super.key,
  });

  final Widget? title;
  final Color? iconBackgroundColor;
  //Message is in a list so that many message can be stack on each other
  final List<Widget> message;
  final List<String> buttonsText;
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
  final CrossAxisAlignment? messageAlligment;
  final List<void Function(BuildContext context)> onPopupButtonClicked;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
            children: message,
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
                  child: ElevatedButton(
                    onPressed: () => onPopupButtonClicked[index](context),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        buttonsColor![index],
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: DefaultTextStyle.merge(
                      style: context.textTheme.h4BoldPoppins.copyWith(
                        color:
                            buttonsTextColors ?? context.colorScheme.background,
                        fontSize: buttonsTextSize ?? 16,
                      ),
                      child: Text(buttonsText[index]),
                    ),
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

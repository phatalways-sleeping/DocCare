import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

/// [BasePopup] is a popup that can be used to show a message to the user
/// with a title and a list of message.
class BasePopup extends StatelessWidget {
  /// Constructor for [BasePopup]
  const BasePopup({
    required this.message,
    required this.buttonsText,
    this.popupPadding = 10,
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
    this.hasPadding = true,
    super.key,
  });

  /// The title of the popup
  final Widget? title;

  /// The color of the icon background
  final Color? iconBackgroundColor;

  /// The padding of the popup
  final double popupPadding;

  /// The list of message
  final List<Widget> message;

  /// The text of the buttons
  final List<String> buttonsText;

  /// The color of the buttons
  final List<Color>? buttonsColor;

  /// The style of the buttons text
  final TextStyle? buttonsTextStyle;

  /// The width of the buttons
  final double? buttonsWidth;

  /// The height of the buttons
  final double? buttonsHeight;

  /// The size of the buttons text
  final double? buttonsTextSize;

  /// The color of the buttons text
  final List<Color>? buttonsTextColors;

  /// The icon of the popup
  final Widget? popupIcon;

  /// The width of the icon
  final double? popupIconWidth;

  /// The height of the icon
  final double? popupIconHeight;

  /// The color of the title text
  final Color? titleTextColor;

  /// The size of the title text
  final double? titleTextSize;

  /// The alignment of the title
  final TextAlign? titleAlignment;

  /// The alignment of the message
  final CrossAxisAlignment? messageAlligment;

  /// The function that will be called when the confirm button is clicked
  final void Function(BuildContext context)? onConfirmButtonClicked;

  /// The function that will be called when the cancel button is clicked
  final void Function(BuildContext context)? onCancelButtonClicked;

  /// Whether the popup has padding or not
  final bool hasPadding;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(popupPadding),
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
            crossAxisAlignment: messageAlligment ?? CrossAxisAlignment.start,
            children: List.generate(
              message.length,
              (index) => Padding(
                padding: EdgeInsets.only(
                  top: (index > 0 && index.isEven && hasPadding)
                      ? popupPadding
                      : 0,
                ),
                child: message[index],
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
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
                    widthFactor: buttonsWidth,
                    heightFactor: buttonsHeight,
                    text: buttonsText[index],
                    textStyle: buttonsTextStyle,
                    textSize: buttonsTextSize,
                    textColor: buttonsTextColors?[index],
                    backgroundColor: buttonsColor?[index],
                    borderWidth: 0,
                    borderColor: context.colorScheme.background,
                    onPressed: (context) {
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

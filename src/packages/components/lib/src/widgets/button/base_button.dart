import 'package:flutter/material.dart';

/// [BaseButton] is a base class for all buttons in the app.
class BaseButton extends StatelessWidget {
  /// Constructor for [BaseButton].
  const BaseButton({
    required this.child,
    required this.onPressed,
    required this.borderSide,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.textStyle,
    this.textColor,
    this.iconColor,
    this.minimumSize,
    this.maximumSize,
    this.fixedSize,
    this.splashColor,
    this.alignment = Alignment.center,
    this.shadowColor = Colors.transparent,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(80),
    ),
    this.padding = const EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 16,
    ),
    this.tapTargetSize = MaterialTapTargetSize.shrinkWrap,
    this.splashFactory = InkRipple.splashFactory,
    super.key,
  });

  final void Function(BuildContext context) onPressed;
  final EdgeInsetsGeometry padding;
  final BorderSide borderSide;

  final TextStyle textStyle;

  final Color backgroundColor;
  final Color foregroundColor;
  final Color shadowColor;
  final Color? textColor;
  final Color? iconColor;
  final Color? splashColor;

  final Size? minimumSize;
  final Size? maximumSize;
  final Size? fixedSize;

  final Alignment alignment;

  final BorderRadius borderRadius;

  final MaterialTapTargetSize tapTargetSize;

  final InteractiveInkFeatureFactory splashFactory;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      style: ButtonStyle(
        padding: MaterialStatePropertyAll(padding),
        side: MaterialStatePropertyAll(borderSide),
        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.focused)) {
            return foregroundColor;
          } else if (states.contains(MaterialState.hovered)) {
            return foregroundColor.withOpacity(0.8);
          } else if (states.contains(MaterialState.pressed)) {
            return foregroundColor.withOpacity(0.5);
          } else if (states.contains(MaterialState.disabled)) {
            return foregroundColor.withOpacity(0.5);
          }
          return foregroundColor;
        }),
        minimumSize: MaterialStatePropertyAll(minimumSize),
        maximumSize: MaterialStatePropertyAll(maximumSize),
        fixedSize: MaterialStatePropertyAll(fixedSize),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.focused)) {
            return backgroundColor;
          } else if (states.contains(MaterialState.hovered)) {
            return backgroundColor.withOpacity(0.8);
          } else if (states.contains(MaterialState.pressed)) {
            return backgroundColor.withOpacity(0.5);
          } else if (states.contains(MaterialState.disabled)) {
            return backgroundColor.withOpacity(0.5);
          }
          return backgroundColor;
        }),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
        shadowColor: MaterialStatePropertyAll(shadowColor),
        splashFactory: InkRipple.splashFactory,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: alignment,
      ),
      child: child,
    );
  }
}

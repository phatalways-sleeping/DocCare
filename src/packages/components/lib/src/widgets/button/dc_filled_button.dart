import 'package:components/components.dart';
import 'package:components/src/widgets/button/base_button.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

/// [DCFilledButton] is a button with filled background.
/// It use [BaseButton] as base class.
class DCFilledButton extends StatelessWidget {
  /// Constructor for [DCFilledButton].
  const DCFilledButton({
    required this.onPressed,
    required this.child,
    this.borderSide,
    this.minimumSize,
    this.maximumSize,
    this.fixedSize,
    this.alignment = Alignment.center,
    this.tapTargetSize = MaterialTapTargetSize.shrinkWrap,
    this.splashFactory = InkRipple.splashFactory,
    this.styleWithRespectToParent = true,
    this.backgroundColor,
    this.foregroundColor,
    this.shadowColor,
    this.textColor,
    this.iconColor,
    this.textStyle,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(80),
    ),
    this.padding = const EdgeInsets.all(10),
    super.key,
  });

  final void Function(BuildContext context) onPressed;
  final EdgeInsetsGeometry? padding;
  final BorderSide? borderSide;

  final TextStyle? textStyle;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? shadowColor;

  final Color? textColor;
  final Color? iconColor;

  final bool styleWithRespectToParent;

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
    return BaseButton(
      onPressed: onPressed,
      padding: padding ??
          const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
      borderSide: borderSide ?? BorderSide.none,
      backgroundColor: backgroundColor ?? context.colorScheme.primary,
      foregroundColor: foregroundColor ?? context.colorScheme.onPrimary,
      borderRadius: borderRadius,
      textColor: textColor,
      iconColor: iconColor,
      minimumSize: minimumSize,
      maximumSize: maximumSize,
      fixedSize: fixedSize,
      alignment: alignment,
      tapTargetSize: tapTargetSize,
      splashFactory: splashFactory,
      shadowColor: shadowColor ?? Colors.transparent,
      textStyle: textStyle ?? context.textTheme.bodyRegularPoppins,
      child: child,
    );
  }
}

import 'package:components/components.dart';
import 'package:components/src/widgets/text_form_field/base_text_form_field.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

/// Outlined text form field with heading. This is the text form field that is used
/// in: Login, Register, Forgot Password, and Change Password screens, etc.
/// It uses the [BaseTextFormField] as its base class.
class DCOutlinedWithHeadingTextFormField extends StatelessWidget {
  /// Creates an outlined text form field.
  const DCOutlinedWithHeadingTextFormField({
    required this.contentPadding,
    required this.heading,
    this.gapBetweenHeadingAndInput = 8,
    this.headingColor,
    this.textFormFieldConstraints,
    this.keyboardType,
    this.keyboardAppearance,
    this.obscuringCharacter = '•',
    this.borderColor,
    this.borderRadius = 40,
    this.borderWidth = 1,
    this.textAlign = TextAlign.justify,
    this.textAlignVertical = TextAlignVertical.center,
    this.textCapitalization = TextCapitalization.none,
    this.color,
    this.iconSize = 20,
    this.onChanged,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.initialText,
    this.helperText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onPrefixIconPressed,
    this.onSuffixIconPressed,
    this.prefixIconTooltip,
    this.suffixIconTooltip,
    this.onlyShowIconOnFocus = false,
    this.validator,
    this.obscureMode = false,
    this.enabled = true,
    this.paddingBetweenIconAndInput,
    super.key,
  });

  final Widget heading;
  final Color? headingColor;
  final double gapBetweenHeadingAndInput;

  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final Brightness? keyboardAppearance;
  final String obscuringCharacter;
  final BoxConstraints? textFormFieldConstraints;
  final double? iconSize;
  final Color? color;
  final void Function(BuildContext context, TextEditingController controller)?
      onChanged;
  final double borderRadius;
  final double borderWidth;
  final Color? borderColor;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final String? initialText;
  final String? helperText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(BuildContext context, TextEditingController controller)?
      onPrefixIconPressed;
  final void Function(BuildContext context, TextEditingController controller)?
      onSuffixIconPressed;
  final String? prefixIconTooltip;
  final String? suffixIconTooltip;
  final bool onlyShowIconOnFocus;
  final FormFieldValidator<String>? validator;
  final bool obscureMode;
  final bool enabled;
  final EdgeInsetsGeometry contentPadding;
  final double? paddingBetweenIconAndInput;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: textFormFieldConstraints?.maxHeight ?? 56 + 20,
        minHeight: textFormFieldConstraints?.minHeight ?? 48 + 20,
        minWidth: textFormFieldConstraints?.minWidth ?? double.infinity,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle.merge(
            style: context.textTheme.h3ExtraBoldPoppins.copyWith(
              color:
                  headingColor ?? borderColor ?? context.colorScheme.secondary,
            ),
            child: heading,
          ),
          SizedBox(height: gapBetweenHeadingAndInput),
          BaseTextFormField(
            constraints: textFormFieldConstraints ??
                const BoxConstraints(
                  minHeight: 48,
                  maxHeight: 50,
                  minWidth: double.infinity,
                ),
            iconSize: iconSize ?? 20,
            color: color ??
                context
                    .theme.colorScheme.onSecondary, // The color of text, icon
            textAlign: textAlign,
            textAlignVertical: textAlignVertical,
            textCapitalization: textCapitalization,
            keyboardType: keyboardType,
            keyboardAppearance: keyboardAppearance,
            obscuringCharacter: obscuringCharacter,
            onChanged: onChanged,
            maxLength: maxLength,
            minLines: minLines,
            maxLines: maxLines,
            initialText: initialText,
            helperText: helperText,
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            onPrefixIconPressed: onPrefixIconPressed,
            onSuffixIconPressed: onSuffixIconPressed,
            prefixIconTooltip: prefixIconTooltip,
            suffixIconTooltip: suffixIconTooltip,
            onlyShowIconOnFocus: onlyShowIconOnFocus,
            validator: validator,
            obscureMode: obscureMode,
            enabled: enabled,
            paddingBetweenIconAndInput: paddingBetweenIconAndInput,
            inputBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: borderColor ?? context.theme.colorScheme.secondary,
                width: borderWidth,
              ),
            ),
            contentPadding: contentPadding,
          ),
        ],
      ),
    );
  }
}

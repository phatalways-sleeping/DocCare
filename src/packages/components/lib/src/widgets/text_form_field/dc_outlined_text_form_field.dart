import 'package:components/src/widgets/text_form_field/base_text_form_field.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

/// Outlined text form field. This is the text form field that is used
/// in: Login, Register, Forgot Password, and Change Password screens, etc.
/// It uses the [BaseTextFormField] as its base class.
class DCOutlinedTextFormField extends StatelessWidget {
  /// Creates an outlined text form field.
  const DCOutlinedTextFormField({
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 8,
      vertical: 12,
    ),
    this.heightFactor = 0.12,
    this.widthFactor = 0.8,
    this.keyboardType,
    this.keyboardAppearance,
    this.obscuringCharacter = '•',
    this.borderColor,
    this.borderRadius = 40,
    this.borderWidth = 1,
    this.constraints = const BoxConstraints(
      minHeight: 48,
      minWidth: double.infinity,
    ),
    this.textAlign = TextAlign.justify,
    this.textAlignVertical = TextAlignVertical.center,
    this.textCapitalization = TextCapitalization.none,
    this.color,
    this.iconSize = 20,
    this.onChanged,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.labelText,
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

  final double heightFactor;
  final double widthFactor;

  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final Brightness? keyboardAppearance;
  final String obscuringCharacter;
  final BoxConstraints constraints;
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
  final String? labelText;
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
    return BaseTextFormField(
      constraints: constraints,
      iconSize: iconSize ?? 20,
      color: color ??
          context.theme.colorScheme.onSecondary, // The color of text, icon
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
      labelText: labelText,
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
    );
  }
}

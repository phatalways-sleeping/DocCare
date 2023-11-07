import 'package:components/src/svgs/dc_svgs.dart';
import 'package:components/src/widgets/text_form_field/base_text_form_field.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Outlined text form field. This is the text form field that is used
/// in: Login, Register, Forgot Password, and Change Password screens, etc.
/// It uses the [BaseTextFormField] as its base class.
class DCOutlinedObscuredTextFormField extends StatelessWidget {
  /// Creates an outlined obscured text form field.
  const DCOutlinedObscuredTextFormField({
    required this.contentPadding,
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
    this.iconSize = 24,
    this.onChanged,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.labelText,
    this.initialText,
    this.helperText,
    this.hintText,
    this.suffixIcon,
    this.suffixIconOnObscuredMode,
    this.onSuffixIconPressed,
    this.suffixIconTooltip,
    this.onlyShowIconOnFocus = false,
    this.validator,
    this.enabled = true,
    this.paddingBetweenIconAndInput,
    super.key,
  });

  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final Brightness? keyboardAppearance;
  final String obscuringCharacter;
  final BoxConstraints? constraints;
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
  final Widget? suffixIcon;
  final Widget? suffixIconOnObscuredMode;
  final void Function(BuildContext context, TextEditingController controller)?
      onSuffixIconPressed;
  final String? suffixIconTooltip;
  final bool onlyShowIconOnFocus;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final EdgeInsetsGeometry contentPadding;
  final double? paddingBetweenIconAndInput;

  @override
  Widget build(BuildContext context) {
    return BaseTextFormField(
      constraints: constraints ??
          const BoxConstraints(
            minHeight: 48,
            maxHeight: 50,
            minWidth: double.infinity,
          ),
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
      suffixIcon: suffixIcon ??
          SvgPicture.string(
            DCSVGIcons.hide,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              color ?? context.theme.colorScheme.onSecondary,
              BlendMode.srcIn,
            ),
            width: iconSize,
            height: iconSize,
          ),
      suffixIconOnObscuredMode: suffixIconOnObscuredMode ??
          SvgPicture.string(
            DCSVGIcons.unhide,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              color ?? context.theme.colorScheme.onSecondary,
              BlendMode.srcIn,
            ),
            width: iconSize,
            height: iconSize,
          ),
      onSuffixIconPressed: onSuffixIconPressed,
      suffixIconTooltip: suffixIconTooltip,
      onlyShowIconOnFocus: onlyShowIconOnFocus,
      validator: validator,
      obscureMode: true,
      toggleObscuredModeIcon: true,
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

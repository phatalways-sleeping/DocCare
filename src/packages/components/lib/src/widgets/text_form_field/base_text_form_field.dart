import 'dart:math';

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// This is the base class for all text form fields used in the app.
/// It is used to provide a common interface for all text form fields.
/// It is also used to provide a common place to add any common functionality
/// that is needed for all text form fields.
base class BaseTextFormField extends StatefulWidget {
  /// Creates a base text form field.
  const BaseTextFormField({
    required this.color,
    required this.inputBorder,
    required this.contentPadding,
    required this.constraints,
    this.controller,
    this.textAlign = TextAlign.justify,
    this.textAlignVertical = TextAlignVertical.center,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType,
    this.keyboardAppearance,
    this.obscuringCharacter = '•',
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
    this.suffixIconOnObscuredMode,
    this.onPrefixIconPressed,
    this.onSuffixIconPressed,
    this.onFocus,
    this.onFocusChange,
    this.prefixIconTooltip,
    this.suffixIconTooltip,
    this.onlyShowIconOnFocus = false,
    this.validator,
    this.obscureMode = false,
    this.toggleObscuredModeIcon = false,
    this.enabled = true,
    this.paddingBetweenIconAndInput,
    super.key,
  });

  final TextEditingController? controller;

  final TextInputType? keyboardType;
  final Brightness? keyboardAppearance;
  final String obscuringCharacter;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final TextCapitalization textCapitalization;
  final BoxConstraints constraints;
  final double iconSize;
  final Color color;
  final void Function(BuildContext context, TextEditingController controller)?
      onChanged;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final String? labelText;
  final String? initialText;
  final String? helperText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget?
      suffixIcon; // This is the icon that is shown when the obscure mode is on.
  final Widget?
      suffixIconOnObscuredMode; // This is the icon that is shown when the obscure mode is off.
  final void Function(BuildContext context, TextEditingController controller)?
      onPrefixIconPressed;
  final void Function(BuildContext context, TextEditingController controller)?
      onSuffixIconPressed;
  final void Function(BuildContext context, FocusNode focusNode)? onFocus;
  final void Function(BuildContext context, FocusNode focusNode)? onFocusChange;
  final String? prefixIconTooltip;
  final String? suffixIconTooltip;
  final bool onlyShowIconOnFocus;
  final FormFieldValidator<String>? validator;
  final bool obscureMode;
  final bool toggleObscuredModeIcon;
  final bool enabled;

  final InputBorder inputBorder;
  final EdgeInsetsGeometry contentPadding;
  final double? paddingBetweenIconAndInput;

  @override
  State<BaseTextFormField> createState() => _BaseTextFormFieldState();
}

class _BaseTextFormFieldState extends State<BaseTextFormField> {
  late bool isObscured = widget.obscureMode;
  late TextEditingController controller =widget.controller ??
          TextEditingController(
            text: widget.initialText,
          );
  late FocusNode focusNode = FocusNode()
    ..addListener(() {
      widget.onFocusChange?.call(context, focusNode);
    });

  late final prefixPadding = widget.prefixIcon == null
      ? EdgeInsets.only(
          left: widget.contentPadding.horizontal / 2,
        )
      : EdgeInsets.only(
          left: max((widget.paddingBetweenIconAndInput ?? 8) - 8, 0),
        );
  late final prefixIconPadding = widget.prefixIcon == null
      ? EdgeInsets.zero
      : EdgeInsets.only(
          left: max(widget.contentPadding.horizontal / 2 - 8, 0),
        );
  late final suffixPadding = widget.suffixIcon == null
      ? EdgeInsets.only(
          right: widget.contentPadding.horizontal / 2,
        )
      : EdgeInsets.only(
          right: max((widget.paddingBetweenIconAndInput ?? 8) - 8, 0),
        );
  late final suffixIconPadding = widget.suffixIcon == null
      ? EdgeInsets.zero
      : EdgeInsets.only(
          right: max(widget.contentPadding.horizontal / 2 - 8, 0),
        );
  @override
  void dispose() {
    if (widget.controller == null) controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscured,
      enabled: widget.enabled,
      onChanged: (value) => widget.onChanged?.call(context, controller),
      maxLength: widget.maxLength,
      minLines: widget.minLines,
      maxLines: widget.obscureMode ? 1 : widget.maxLines,
      cursorColor: widget.color,
      style: context.textTheme.h6RegularPoppins.copyWith(
        color: widget.color,
      ),
      focusNode: focusNode,
      onTap: () {
        widget.onFocus?.call(context, focusNode);
        focusNode.requestFocus();
      },
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardAppearance: widget.keyboardAppearance,
      keyboardType: widget.keyboardType,
      obscuringCharacter: widget.obscuringCharacter,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textCapitalization: widget.textCapitalization,
      inputFormatters: [
        if (widget.keyboardType == TextInputType.number)
          FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        isDense: true,
        constraints: widget.constraints,
        contentPadding: EdgeInsets.symmetric(
          vertical: widget.contentPadding.vertical / 2,
          horizontal: widget.contentPadding.horizontal / 2,
        ),
        labelText: widget.labelText,
        labelStyle: context.textTheme.h6RegularPoppins.copyWith(
          color:
              focusNode.hasFocus ? widget.color : widget.color.withOpacity(0.8),
        ),
        helperText: widget.helperText,
        helperStyle: context.textTheme.sub1RegularPoppins.copyWith(
          color: widget.color.withOpacity(0.8),
        ),
        hintText: widget.hintText,
        hintStyle: context.textTheme.h6RegularPoppins.copyWith(
          color: widget.color.withOpacity(0.8),
        ),
        prefix: Padding(padding: prefixPadding),
        prefixIcon: widget.prefixIcon != null
            ? Padding(
                padding: prefixIconPadding,
                child: !widget.onlyShowIconOnFocus || focusNode.hasFocus
                    ? IconButton(
                        icon: SizedBox(
                          width: widget.iconSize,
                          height: widget.iconSize,
                          child: widget.prefixIcon,
                        ),
                        padding: EdgeInsets.zero,
                        color: focusNode.hasFocus
                            ? widget.color
                            : widget.color.withOpacity(0.8),
                        onPressed: () => widget.onPrefixIconPressed
                            ?.call(context, controller),
                        tooltip: widget.prefixIconTooltip,
                      )
                    : null,
              )
            : null,
        suffix: Padding(
          padding: suffixPadding,
        ),
        suffixIcon: widget.suffixIcon != null || widget.toggleObscuredModeIcon
            ? Padding(
                padding: suffixIconPadding,
                child: !widget.toggleObscuredModeIcon
                    ? !widget.onlyShowIconOnFocus || focusNode.hasFocus
                        ? IconButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                EdgeInsets.zero,
                              ),
                              fixedSize: MaterialStatePropertyAll(
                                Size.square(widget.iconSize),
                              ),
                              elevation: MaterialStateProperty.all(0),
                            ),
                            icon: SizedBox(
                              child: widget.suffixIcon,
                            ),
                            color: focusNode.hasFocus
                                ? widget.color
                                : context.colorScheme.onBackground
                                    .withOpacity(0.8),
                            onPressed: () => widget.onSuffixIconPressed
                                ?.call(context, controller),
                            tooltip: widget.suffixIconTooltip,
                          )
                        : null
                    : IconButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            EdgeInsets.zero,
                          ),
                          fixedSize: MaterialStatePropertyAll(
                            Size.square(widget.iconSize),
                          ),
                          elevation: MaterialStateProperty.all(0),
                        ),
                        icon: isObscured
                            ? widget.suffixIcon ??
                                Icon(
                                  Icons.visibility,
                                  color: widget.color,
                                )
                            : widget.suffixIconOnObscuredMode ??
                                Icon(
                                  Icons.visibility_off,
                                  color: widget.color,
                                ),
                        onPressed: () =>
                            setState(() => isObscured = !isObscured),
                        tooltip: 'Toggle password hidden mode.',
                      ),
              )
            : null,
        enabledBorder: widget.inputBorder.copyWith(
          borderSide: BorderSide(
            color: widget.inputBorder.borderSide.color,
          ),
        ),
        disabledBorder: widget.inputBorder.copyWith(
          borderSide: BorderSide(
            width: widget.inputBorder.borderSide.width * 1.25,
            color: widget.inputBorder.borderSide.color,
          ),
        ),
        focusedBorder: widget.inputBorder.copyWith(
          borderSide: BorderSide(
            width: widget.inputBorder.borderSide.width * 2.0,
            color: widget.inputBorder.borderSide.color,
          ),
        ),
      ),
    );
  }
}

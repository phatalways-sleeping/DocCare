import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';


class DCDropdownButton<T> extends StatefulWidget {
  final List<T> items;
  final double? dropdownWidth;
  final double? menuHeight;
  final double? textSize;
  final double? borderRadius;
  final bool? enabled; // default is true
  final bool? enableSearch; // default is true
  final bool? enableFilter; // default is true
  final bool? requestFocusOnTap; // default is true
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final String? hintText;
  final String? errorText;
  final TextStyle? textStyle;
  final Color? textColor;

  const DCDropdownButton({
    required this.items,
    this.dropdownWidth,
    this.menuHeight,
    this.textSize,
    this.borderRadius,
    this.enabled,
    this.leadingIcon,
    this.trailingIcon,
    this.hintText,
    this.errorText,
    this.enableSearch, // default is true
    this.enableFilter, // default is true
    this.textStyle,
    this.requestFocusOnTap, // defualt is true
    this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  State<DCDropdownButton<T>> createState() => _DropdownButtonState<T>();
}

class _DropdownButtonState<T> extends State<DCDropdownButton<T>> {
  T? dropdownValue;
  @override
  Widget build(BuildContext context) {
    dropdownValue = widget.items.first;
    return DropdownMenu<T>(
      width: widget.dropdownWidth ?? 200.0,
      enabled: widget.enabled ?? true,
      menuHeight: widget.menuHeight,
      leadingIcon: widget.leadingIcon ??
          Icon(
            Icons.search,
            color: Colors.black.withOpacity(0.25),
          ),
      trailingIcon: widget.trailingIcon ?? const Icon(Icons.arrow_drop_down),
      hintText: widget.hintText,
      errorText: widget.errorText,
      enableSearch: widget.enableSearch ?? true,
      enableFilter: widget.enableFilter ?? true,
      textStyle: widget.textStyle ??
          context.textTheme.h6RegularPoppins.copyWith(
            color: widget.textColor ?? Colors.black,
            fontSize: widget.textSize ?? 14,
          ),
      requestFocusOnTap: widget.requestFocusOnTap ?? true,
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(widget.borderRadius ?? 30)),
      )),
      onSelected: (T? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: widget.items.map<DropdownMenuEntry<T>>((T value) {
        return DropdownMenuEntry<T>(
            value: value,
            style: ButtonStyle(
              textStyle: MaterialStateProperty.resolveWith<TextStyle>(
                  (Set<MaterialState> states) {
                return TextStyle(
                  fontSize: widget.textSize ?? 14,
                );
              }),
            ),
            label: value.toString());
      }).toList(),
    );
  }
}

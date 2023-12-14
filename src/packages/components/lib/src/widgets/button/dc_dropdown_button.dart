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
  final String? label;
  final void Function(BuildContext context, TextEditingController controller,
      T? selectedValue)? onItemSelected;
  T? dropdownValue;

  void printDropDownValue() {
    print("DropDValue ${dropdownValue}");
  }

  DCDropdownButton({
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
    this.onItemSelected,
    this.label,
    this.dropdownValue,
    Key? key,
  }) : super(key: key) {
    printDropDownValue();
  }

  @override
  State<DCDropdownButton<T>> createState() => _DropdownButtonState<T>();
}

class _DropdownButtonState<T> extends State<DCDropdownButton<T>> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: widget.dropdownValue,
      onChanged: (T? value) async {
        if (widget.onItemSelected != null) {
          widget.onItemSelected!(context, _controller, value);
        }
        setState(() {
          widget.dropdownValue = value!;
        });
      },
      items: widget.items.map<DropdownMenuItem<T>>((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(
            value.toString(),
            style: TextStyle(
              fontSize: widget.textSize ?? 14,
            ),
          ),
        );
      }).toList(),
      style: widget.textStyle,
      hint: widget.hintText != null
          ? Text(
              widget.hintText!,
              style: widget.textStyle,
            )
          : null,
      disabledHint: widget.hintText != null
          ? Text(
              widget.hintText!,
              style: TextStyle(
                color: widget.textColor?.withOpacity(0.5) ?? Colors.black,
                fontSize: widget.textSize ?? 14,
              ),
            )
          : null,
      isExpanded: true,
      icon: widget.trailingIcon,
      underline: Container(), // To remove the underline
      focusColor: widget.textColor,
      autofocus: widget.requestFocusOnTap ?? true,
      itemHeight: widget.menuHeight,
      elevation: 8,
    );
  }
}

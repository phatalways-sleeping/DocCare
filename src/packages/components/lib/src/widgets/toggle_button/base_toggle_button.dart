// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// Flutter code for [BaseToggleButton].

// selectedElements: <bool>[true, false, false]

class BaseToggleButton extends StatefulWidget {
  const BaseToggleButton({
    Key? key,
    this.title,
    this.onChanged,
    this.selectedColor,
    this.unSelectedColor,
    this.borderRadius,
    this.color,
    required this.elements,
    required this.selectedElements,
  }) : super(key: key);

  final BorderRadius? borderRadius;
  final String? title;
  final Color? selectedColor;
  final Color? color;
  final Color? unSelectedColor;
  final List<bool> selectedElements;
  final List<String> elements;
  final void Function(BuildContext context, TextEditingController controller)?
      onChanged;

  @override
  State<BaseToggleButton> createState() => _BaseToggleButtonState();
}

class _BaseToggleButtonState extends State<BaseToggleButton> {
  late var selectItems = widget.selectedElements;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: FractionallySizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title ?? "",
                style: theme.textTheme.headline6,
              ),
            ),
            ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (int index) {
                setState(() {
                  // Toggle the selected state of the button that is tapped.
                  for (int i = 0; i < selectItems.length; i++) {
                    selectItems[i] = (i == index);
                  }
                  // Call onChanged callback with the selected element
                  if (selectItems[index]) {
                    widget.onChanged?.call(
                      context,
                      TextEditingController(text: widget.elements[index]),
                    );
                  }
                });
              },
              selectedColor: Theme.of(context).colorScheme.primary,
              borderRadius: widget.borderRadius ??
                  const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Theme.of(context).colorScheme.onBackground,
              color: widget.color ?? Theme.of(context).colorScheme.onBackground,
              constraints: BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              fillColor: Theme.of(context).colorScheme.error,
              isSelected: selectItems,
              children: widget.elements
                  .map((element) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          element,
                          style: TextStyle(
                              fontSize: 16,
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

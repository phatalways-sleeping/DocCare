import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class DropdownMenuExample<T> extends StatefulWidget {
  final List<T> items;
  final double dropdownWidth; // New parameter for dropdown width

const DropdownMenuExample({
    required this.items,
    this.dropdownWidth = 200.0, // Default dropdown width if not provided
    Key? key,
  }) : super(key: key);

  @override
  State<DropdownMenuExample<T>> createState() => _DropdownMenuExampleState<T>(items: items, dropdownWidth: dropdownWidth);
}

class _DropdownMenuExampleState<T> extends State<DropdownMenuExample<T>> {
  late T dropdownValue;
  late double dropdownWidth;

  _DropdownMenuExampleState({required List<T> items, required this.dropdownWidth}) {
    dropdownValue = items.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      width: dropdownWidth, 
      initialSelection: dropdownValue,
      onSelected: (T? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: widget.items.map<DropdownMenuEntry<T>>((T value) {
        return DropdownMenuEntry<T>(value: value, label: value.toString());
      }).toList(),
    );
  }
}
import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class DropdownMenuExample extends StatefulWidget {
  final List<String> items;
  final double dropdownWidth; // New parameter for dropdown width

const DropdownMenuExample({
    required this.items,
    this.dropdownWidth = 200.0, // Default dropdown width if not provided
    Key? key,
  }) : super(key: key);

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState(items: items, dropdownWidth: dropdownWidth);
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  late String dropdownValue;
  late double dropdownWidth;

  _DropdownMenuExampleState({required List<String> items, required this.dropdownWidth}) {
    dropdownValue = items.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      width: dropdownWidth, 
      initialSelection: dropdownValue,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: widget.items.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
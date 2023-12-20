import 'package:components/components.dart';
import 'package:flutter/material.dart';

class DCDoctorToggleButton extends StatefulWidget {
  const DCDoctorToggleButton({
    super.key,
    this.title,
    this.onChanged,
    this.selectedColor,
    this.unSelectedColor,
    this.borderRadius,
    this.color,
    required this.elements, // All element for choosing in toggle buttons
    required this.selectedElements,
  });

  final BorderRadius? borderRadius;
  final Color? selectedColor;
  final Color? color;
  final Color? unSelectedColor;
  final String? title;
  final void Function(BuildContext context, TextEditingController controller)?
      onChanged;
  final List<bool> selectedElements;
  final List<String> elements;

  @override
  State<DCDoctorToggleButton> createState() => _DCDoctorToggleButtonState();
}

class _DCDoctorToggleButtonState extends State<DCDoctorToggleButton> {
  @override
  Widget build(BuildContext context) {
    return BaseToggleButton(
        elements: widget.elements, selectedElements: widget.selectedElements);
  }
}

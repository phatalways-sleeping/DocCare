// ignore_for_file: always_put_required_named_parameters_first, public_member_api_docs

import 'package:components/components.dart';
import 'package:flutter/material.dart';

class DCAdminToggleButton extends StatefulWidget {
  const DCAdminToggleButton({
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
  State<DCAdminToggleButton> createState() => _DCAdminToggleButtonState();
}

class _DCAdminToggleButtonState extends State<DCAdminToggleButton> {
  @override
  Widget build(BuildContext context) {
    return BaseToggleButton(
      elements: widget.elements,
      selectedElements: widget.selectedElements,
      title: widget.title,
      selectedColor: widget.selectedColor,
      color: widget.color,
      unSelectedColor: widget.unSelectedColor,
      borderRadius: widget.borderRadius,
      onChanged: widget.onChanged, // Pass onChanged to BaseToggleButton
    );
  }
}

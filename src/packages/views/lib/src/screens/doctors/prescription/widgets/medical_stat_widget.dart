// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DCMedicalStat extends StatefulWidget {
  const DCMedicalStat({
    required this.statName,
    required this.hintValue,
    required this.icon,
    required this.textController,
    this.onChanged,
    super.key,
  });

  final String statName;
  final String hintValue;
  final String icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController textController;

  @override
  State<DCMedicalStat> createState() => _DCMedicalStatState();
}

class _DCMedicalStatState extends State<DCMedicalStat> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: context.colorScheme.background,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: context.colorScheme.secondary,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8, // Reduced vertical padding
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: context.colorScheme.quinary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.string(
                    widget.icon,
                    width: 25,
                    height: 25,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.statName,
                        style: context.textTheme.h6RegularPoppins.copyWith(
                          fontSize: 16,
                          color:
                              context.colorScheme.onSecondary.withOpacity(0.8),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.zero, // Remove padding if any
                        margin: EdgeInsets.zero, // Remove margin if any
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 2),
                          ),
                        ),
                        child: TextField(
                          controller: widget.textController,
                          style: context.textTheme.h6BoldPoppins.copyWith(
                            fontSize: 16,
                            color: context.colorScheme.onSecondary,
                          ),
                          decoration: InputDecoration(
                            isDense: true, // Add this line to your code
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 8),
                            border: InputBorder.none,
                            hintText: widget.hintValue,
                            hintStyle:
                                context.textTheme.h6RegularPoppins.copyWith(
                              fontSize: 16,
                              color: context.colorScheme.onSecondary
                                  .withOpacity(0.5),
                            ),
                          ),
                          onChanged: (value) {
                            widget.onChanged?.call(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

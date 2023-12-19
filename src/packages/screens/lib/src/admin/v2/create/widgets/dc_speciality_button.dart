// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class DCSpecialityButton extends StatefulWidget {
  const DCSpecialityButton({
    required this.future,
    required this.onPressed,
    required this.width,
    required this.hintText,
    this.borderColor,
    super.key,
  });

  final Future<List<String>> future;
  final void Function(BuildContext context) onPressed;
  final Color? borderColor;
  final double? width;
  final String hintText;

  @override
  State<DCSpecialityButton> createState() => _DCSpecialityButtonState();
}

class _DCSpecialityButtonState extends State<DCSpecialityButton> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data ?? [];
          final normalBorder = OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: widget.borderColor ?? context.colorScheme.error,
            ),
          );
          final errorBorder = OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          );
          final normalTextStyle = context.textTheme.bodyRegularPoppins.copyWith(
            color: context.colorScheme.tertiary,
            fontSize: 15,
          );
          return DropdownMenu<String>(
            onSelected: (value) {},
            textStyle: context.textTheme.bodyRegularPoppins.copyWith(
              color: context.colorScheme.tertiary,
              fontSize: 15,
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: normalBorder,
              enabledBorder: normalBorder,
              focusedBorder: normalBorder,
              errorBorder: errorBorder,
              focusedErrorBorder: errorBorder,
              labelStyle: normalTextStyle,
              hintStyle: normalTextStyle,
            ),
            hintText: widget.hintText,
            menuStyle: MenuStyle(
              backgroundColor: MaterialStatePropertyAll(
                context.colorScheme.background,
              ),
              elevation: const MaterialStatePropertyAll(4),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              side: MaterialStatePropertyAll(
                BorderSide(
                  color: widget.borderColor ?? context.colorScheme.secondary,
                ),
              ),
            ),
            width: widget.width,
            dropdownMenuEntries: data
                .map(
                  (e) => DropdownMenuEntry<String>(
                    value: e,
                    label: e,
                  ),
                )
                .toList(),
          );
        } else if (snapshot.hasError) {
          return ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                context.colorScheme.error,
              ),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
              ),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              fixedSize: widget.width != null
                  ? MaterialStateProperty.all<Size>(
                      Size(
                        widget.width!,
                        50,
                      ),
                    )
                  : null,
            ),
            onPressed: () => setState(() {}),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error loading data',
                  style: context.textTheme.bodyRegularPoppins.copyWith(
                    color: context.colorScheme.onSurface,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.refresh,
                  size: 30,
                  color: context.colorScheme.onSecondary,
                ),
              ],
            ),
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: context.colorScheme.secondary,
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                child: Wrap(
                  children: [
                    Text(
                      'Loading data of our specialities',
                      style: context.textTheme.bodyRegularPoppins.copyWith(
                        color: context.colorScheme.tertiary,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

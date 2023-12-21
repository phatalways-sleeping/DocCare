// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/src/screens/users/booking/booking_view/controller/booking_bloc.dart';

class DCSpecialityButton extends StatefulWidget {
  const DCSpecialityButton({
    required this.future,
    super.key,
  });

  final Future<List<String>> future;

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
              color: context.colorScheme.secondary,
            ),
          );
          final errorBorder = OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: context.colorScheme.error,
            ),
          );
          final normalTextStyle = context.textTheme.bodyRegularPoppins.copyWith(
            color: context.colorScheme.onSurface,
            fontSize: 15,
          );
          return DropdownMenu<String>(
            onSelected: (value) => value != null
                ? context.read<BookingBloc>().add(
                      BookingSelectSpecialityEvent(
                        speciality: value,
                      ),
                    )
                : null,
            textStyle: context.textTheme.bodyRegularPoppins.copyWith(
              color: context.colorScheme.onSurface,
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
            hintText: 'Select Speciality',
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
                  color: context.colorScheme.secondary,
                ),
              ),
            ),
            width: context.width * 0.94,
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
              fixedSize: MaterialStateProperty.all<Size>(
                Size(
                  context.width * 0.94,
                  50,
                ),
              ),
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
              Text(
                'Loading data of our specialities',
                style: context.textTheme.bodyRegularPoppins.copyWith(
                  color: context.colorScheme.onSurface,
                  fontSize: 15,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

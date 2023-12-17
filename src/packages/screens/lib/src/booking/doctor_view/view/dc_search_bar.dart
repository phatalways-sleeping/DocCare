// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/src/booking/doctor_view/controller/doctor_view_bloc.dart';

const debounceDuration = Duration(milliseconds: 1000);

class DCSearchBar extends StatefulWidget {
  const DCSearchBar({super.key});

  @override
  State<DCSearchBar> createState() => _DCSearchBarState();
}

class _DCSearchBarState extends State<DCSearchBar> {
  // Debounce timer
  Timer? _debounce;
  final TextEditingController _controller = TextEditingController();
  // Debound the textfield for debounceDuration before calling the API
  void _onChanged(String value) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(debounceDuration, () {
      if (value.isNotEmpty) {
        context.read<DoctorViewBloc>().add(
              DoctorViewSearchForNameEvent(
                searchedName: value,
              ),
            );
      } else {
        context.read<DoctorViewBloc>().add(
              const DoctorViewInitialEvent(),
            );
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: _onChanged,
      onTap: () => context.read<DoctorViewBloc>().add(
            const DoctorViewStartSearchForNameEvent(),
          ),
      onTapOutside: (event) {
        if (_controller.text.isEmpty) {
          context.read<DoctorViewBloc>().add(
                const DoctorViewInitialEvent(),
              );
        }
      },
      controller: _controller,
      style: context.textTheme.bodyRegularPoppins.copyWith(
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: 'Search for a name',
        hintStyle: context.textTheme.bodyRegularPoppins.copyWith(
          fontSize: 16,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.black,
        ),
        suffixIcon: IconButton.filled(
          splashColor: Colors.white,
          highlightColor: Colors.white,
          onPressed: _controller.clear,
          icon: const Icon(
            Icons.clear,
            color: Colors.black,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}

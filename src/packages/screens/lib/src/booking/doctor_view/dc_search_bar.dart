
import 'dart:async';

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

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

    if (value.isEmpty) {
      return;
    }

    _debounce = Timer(debounceDuration, () {
      print('Calling API with $value');
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

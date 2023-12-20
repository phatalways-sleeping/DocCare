// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:screens/src/admin/v2/config.dart';

/// Flutter code sample for [Autocomplete] that demonstrates fetching the
/// options asynchronously and debouncing the network calls.

const Duration fakeAPIDuration = Duration(seconds: 1);

class DCAsyncInput extends StatefulWidget {
  const DCAsyncInput({
    required this.onChanged,
    this.initialValue,
    super.key,
  });

  final String? initialValue;
  final void Function(BuildContext context, String value) onChanged;

  @override
  State<DCAsyncInput> createState() => DCAsyncInputState();
}

class DCAsyncInputState extends State<DCAsyncInput> {
  // The query currently being searched for. If null, there is no pending
  // request.
  String? _currentQuery;

  // The most recent options received from the API.
  late Iterable<String> _lastOptions = <String>[];

  late final _Debounceable<Iterable<String>?, String> _debouncedSearch;

  // Calls the "remote" API to search with the given query. Returns null when
  // the call has been made obsolete.
  Future<Iterable<String>?> _search(String query) async {
    _currentQuery = query;

    // In a real application, there should be some error handling here.
    final options = await _FakeAPI.search(_currentQuery!);

    // If another search happened after this one, throw away these options.
    if (_currentQuery != query) {
      return null;
    }
    _currentQuery = null;

    return options;
  }

  @override
  void initState() {
    super.initState();
    _debouncedSearch = _debounce<Iterable<String>?, String>(_search);
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: context.colorScheme.secondary,
      ),
    );
    final style = context.textTheme.bodyRegularPoppins.copyWith(
      color: context.colorScheme.tertiary,
      fontSize: 16,
    );
    return Autocomplete<String>(
      optionsViewBuilder: (context, onSelected, options) => Align(
        alignment: Alignment.topLeft,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: context.height * 0.2,
            width: context.width * 0.9,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options.elementAt(index);
                return InkWell(
                  onTap: () => onSelected(option),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.width * 0.05,
                      vertical: 20,
                    ),
                    child: Text(
                      option,
                      style: style,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      optionsBuilder: (TextEditingValue textEditingValue) async {
        final options = await _debouncedSearch(textEditingValue.text);
        if (options == null) {
          return _lastOptions;
        }
        _lastOptions = options;
        return options;
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) =>
              TextFormField(
        controller: textEditingController,
        focusNode: focusNode,
        onFieldSubmitted: (value) => onFieldSubmitted(),
        style: style,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: style,
          border: border,
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border,
          focusedErrorBorder: border,
          labelStyle: style,
          contentPadding: EdgeInsets.symmetric(
            horizontal: context.width * 0.05,
            vertical: 16,
          ),
        ),
      ),
      initialValue: widget.initialValue != null
          ? TextEditingValue(
              text: widget.initialValue!,
            )
          : null,
      optionsMaxHeight: context.height * 0.2,
      onSelected: (String selection) {
        widget.onChanged(context, selection);
      },
    );
  }
}

// Mimics a remote API.
class _FakeAPI {
  static const List<String> _kOptions = <String>[
    'john@gmail.com',
    'jane@gmail.com',
    'johndoe@gmail.com',
    'jeter@gmail.com',
    'peter@gmail.com',
  ];

  // Searches the options, but injects a fake "network" delay.
  static Future<Iterable<String>> search(String query) async {
    await Future<void>.delayed(fakeAPIDuration); // Fake 1 second delay.
    if (query == '') {
      return const Iterable<String>.empty();
    }
    return _kOptions.where((String option) {
      return option.contains(query.toLowerCase());
    });
  }
}

typedef _Debounceable<S, T> = Future<S?> Function(T parameter);

/// Returns a new function that is a debounced version of the given function.
///
/// This means that the original function will be called only after no calls
/// have been made for the given Duration.
_Debounceable<S, T> _debounce<S, T>(_Debounceable<S?, T> function) {
  _DebounceTimer? debounceTimer;

  return (T parameter) async {
    if (debounceTimer != null && !debounceTimer!.isCompleted) {
      debounceTimer!.cancel();
    }
    debounceTimer = _DebounceTimer();
    try {
      await debounceTimer!.future;
    } catch (error) {
      if (error is _CancelException) {
        return null;
      }
      rethrow;
    }
    return function(parameter);
  };
}

// A wrapper around Timer used for debouncing.
class _DebounceTimer {
  _DebounceTimer() {
    _timer = Timer(debounceDuration, _onComplete);
  }

  late final Timer _timer;
  final Completer<void> _completer = Completer<void>();

  void _onComplete() {
    _completer.complete();
  }

  Future<void> get future => _completer.future;

  bool get isCompleted => _completer.isCompleted;

  void cancel() {
    _timer.cancel();
    _completer.completeError(const _CancelException());
  }
}

// An exception indicating that the timer was canceled.
class _CancelException implements Exception {
  const _CancelException();
}

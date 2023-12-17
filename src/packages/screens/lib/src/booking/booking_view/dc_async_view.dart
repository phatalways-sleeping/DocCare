// ignore_for_file: public_member_api_docs

import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:screens/src/booking/booking_view/dc_circular_item.dart';

enum DCAsyncViewType {
  availableTime,
  reminder,
}

class DCAsyncView extends StatefulWidget {
  const DCAsyncView({
    required this.future,
    required this.type,
    super.key,
  });

  final Future<List<String>> future;
  final DCAsyncViewType type;

  @override
  State<DCAsyncView> createState() => _DCAsyncViewState();
}

class _DCAsyncViewState extends State<DCAsyncView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          return Wrap(
            runSpacing: 5,
            children: data.map(
              (e) {
                final title = e.split(' ')[0];
                final time = e.split(' ')[1];
                return DCCircularItem(
                  title: title,
                  subtitle: time,
                  onPressed: widget.type == DCAsyncViewType.availableTime
                      ? (context) {}
                      : (context) {},
                );
              },
            ).toList(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Icon(
              Icons.error,
              size: 30,
              color: Colors.red,
            ),
          );
        }
        return Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              color: context.colorScheme.secondary,
            ),
          ),
        );
      },
    );
  }
}

// ignore_for_file: public_member_api_docs

import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/src/screens/users/booking/booking_view/controller/booking_bloc.dart';
import 'package:views/src/screens/users/booking/booking_view/dc_circular_item.dart';

enum DCAsyncViewType {
  availableTime,
  reminder,
}

class DCAsyncView extends StatefulWidget {
  const DCAsyncView({
    required this.future,
    required this.type,
    this.title,
    super.key,
  });

  final Future<List<String>> future;
  final DCAsyncViewType type;
  final Widget? title;

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
          return BlocBuilder<BookingBloc, BookingState>(
            builder: (context, state) {
              final item = widget.type == DCAsyncViewType.availableTime
                  ? state.timeSelected
                  : state.remindMeBefore;
              final body = Center(
                child: Wrap(
                  runAlignment: WrapAlignment.center,
                  alignment: WrapAlignment.spaceEvenly,
                  spacing: 10,
                  runSpacing: 10,
                  children: data.map(
                    (e) {
                      return DCCircularItem(
                        title: e.split(' ').first,
                        subtitle: e.split(' ').last,
                        isSelected: item == e,
                        isAvailable: true,
                        onPressed: widget.type == DCAsyncViewType.availableTime
                            ? (context) => context
                                .read<BookingBloc>()
                                .add(BookingSelectTimeEvent(time: e))
                            : (context) => context.read<BookingBloc>().add(
                                  BookingSelectRemindMeBeforeEvent(
                                    remindMeBefore: e,
                                  ),
                                ),
                      );
                    },
                  ).toList(),
                ),
              );
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.title!,
                  body,
                ],
              );
            },
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
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              color: context.colorScheme.secondary,
            ),
          ),
        );
      },
    );
  }
}

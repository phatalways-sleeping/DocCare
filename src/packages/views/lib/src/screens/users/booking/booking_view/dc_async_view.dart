// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/src/screens/users/booking/booking_view/controller/booking_bloc.dart';
import 'package:views/src/screens/users/booking/booking_view/dc_circular_item.dart';

class DCAsyncView extends StatefulWidget {
  const DCAsyncView({
    required this.future,
    super.key,
  });

  final Future<List<String>> future;

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
          if (data.isEmpty) {
            return Center(
              child: Text(
                'There is no available time',
                style: context.textTheme.bodyRegularPoppins.copyWith(
                  color: context.colorScheme.onBackground,
                  fontSize: 14,
                ),
              ),
            );
          }
          final body = Center(
            child: Wrap(
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.spaceEvenly,
              spacing: 10,
              runSpacing: 10,
              children: data.map(
                (e) {
                  return BlocSelector<BookingBloc, BookingState, String?>(
                    selector: (state) => state.timeSelected,
                    builder: (context, state) {
                      return DCCircularItem(
                        title: e.split(' ').first,
                        subtitle: e.split(' ').last,
                        isSelected: state == e,
                        isAvailable: true,
                        onPressed: (context) => context.read<BookingBloc>().add(
                              BookingSelectTimeEvent(time: e),
                            ),
                      );
                    },
                  );
                },
              ).toList(),
            ),
          );
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Available Time',
                style: context.textTheme.bodyBoldPoppins.copyWith(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              body,
            ],
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

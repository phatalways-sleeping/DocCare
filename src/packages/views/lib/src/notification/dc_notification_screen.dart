// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/src/notification/controller/notification_bloc.dart';

class DCNotificationScreen extends StatefulWidget {
  const DCNotificationScreen({super.key});

  @override
  State<DCNotificationScreen> createState() => _DCNotificationScreenState();
}

class _DCNotificationScreenState extends State<DCNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationBloc(),
      child: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationInitial) {
            BlocProvider.of<NotificationBloc>(context)
                .add(const LoadNotification());
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NotificationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NotificationLoaded) {
            final notificationWidgets =
                state.notifications.entries.map((entry) {
              return Column(
                children: [
                  SizedBox(
                    width: context.width,
                    height: context.height * 0.2,
                    child: DCNotification(
                      heightFactor: 1,
                      title: Text(entry.value[0]),
                      message: Text(entry.value[1]),
                      notificationTime: state.dates[entry.key],
                      haveNotificationTime: true,
                      backgroundColor: context.colorScheme.quinary,
                      textColor: context.colorScheme.background,
                      onPressed: (context) {},
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              );
            }).toList();

            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(notificationWidgets),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
          // This return is unnecessary since all paths above return a widget
        },
      ),
    );
  }
}

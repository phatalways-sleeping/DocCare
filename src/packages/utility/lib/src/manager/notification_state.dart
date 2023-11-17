import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:utility/src/manager/notification_manager.dart';

/// [NotificationType] is the enum class for notification type.
enum NotificationType {
  /// [login] is the enum for login notification type.
  login,
}

/// [NotificationState] is the abstract class for all notification states.
@immutable
sealed class NotificationState {
  /// Constructor for [NotificationState].
  const NotificationState();

  /// [build] is the method to build the dialog.
  Widget build(BuildContext context);
}

/// [DismissedNotificationState] is the class for dismissed notification state.
class DismissedNotificationState extends NotificationState {
  /// Constructor for [DismissedNotificationState].
  const DismissedNotificationState();

  // DismissedNotificationState does not have build method
  @override
  Widget build(BuildContext context) => throw UnimplementedError();
}

/// [LoginNotificationState] is the class for
/// login notification state.
class LoginNotificationState extends NotificationState {
  /// Constructor for [LoginNotificationState].
  const LoginNotificationState({
    required this.title,
    required this.message,
  });

  /// [title] is the title of the notification.
  final Widget title;

  /// [message] is the message of the notification.
  final Widget message;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: DCNotification(
            title: title,
            message: message,
            backgroundColor: context.colorScheme.secondary,
            textColor: context.colorScheme.onSecondary,
            onPressed: (context) =>
                NotificationManager.instance.dismiss<void>(),
          ),
        ),
      ),
    );
  }
}

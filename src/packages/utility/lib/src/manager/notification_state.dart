part of 'notification_manager.dart';

/// [NotificationType] is the enum class for notification type.
enum NotificationType {
  /// [login] is the enum for login notification type.
  login,

  /// [signUp] is the enum for sign up notification type.
  signUp,

  /// [dismissed] is the enum for dismissed notification type.
  dismissed,

  /// [error] is the enum for error notification type.
  error,
}

/// [NotificationBuilder] is the abstract class for all notification states.
sealed class NotificationBuilder with ManagerStateMixin {
  /// Constructor for [NotificationBuilder].
  const NotificationBuilder();

  /// [wrapWith] is the method to wrap the notification with
  void wrapWith({required Widget title, required Widget message});
}

/// [DismissedNotificationBuilder] is the class for dismissed notification state.
@immutable
class DismissedNotificationBuilder extends NotificationBuilder {
  /// Constructor for [DismissedNotificationBuilder].
  const DismissedNotificationBuilder();

  // DismissedNotificationBuilder does not have build method
  @override
  Widget build(BuildContext context) => throw UnimplementedError();

  @override
  void wrapWith({required Widget title, required Widget message}) =>
      throw UnimplementedError();
}

/// [LoginNotificationBuilder] is the class for
/// login notification state.
class LoginNotificationBuilder extends NotificationBuilder {
  /// Constructor for [LoginNotificationBuilder].
  LoginNotificationBuilder();

  /// [title] is the title of the notification.
  late Widget title;

  /// [message] is the message of the notification.
  late Widget message;

  @override
  void wrapWith({required Widget title, required Widget message}) {
    this.title = title;
    this.message = message;
  }

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
            onPressed: (context) {},
          ),
        ),
      ),
    );
  }
}

class ErrorNotificationBuilder extends NotificationBuilder {
  /// Constructor for [ErrorNotificationBuilder].
  ErrorNotificationBuilder();

  /// [title] is the title of the notification.
  late Widget title;

  /// [message] is the message of the notification.
  late Widget message;

  @override
  void wrapWith({required Widget title, required Widget message}) {
    this.title = title;
    this.message = message;
  }

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
            backgroundColor: context.colorScheme.error,
            textColor: context.colorScheme.onError,
            onPressed: (context) {},
          ),
        ),
      ),
    );
  }
}
/// [SignUpNotificationBuilder] is the class for
/// sign up notification state.
class SignUpNotificationBuilder extends NotificationBuilder {
  /// Constructor for [SignUpNotificationBuilder].
  SignUpNotificationBuilder();

  /// [title] is the title of the notification.
  late Widget title;

  /// [message] is the message of the notification.
  late Widget message;

  @override
  void wrapWith({required Widget title, required Widget message}) {
    this.title = title;
    this.message = message;
  }

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
            onPressed: (context) {},
          ),
        ),
      ),
    );
  }
}

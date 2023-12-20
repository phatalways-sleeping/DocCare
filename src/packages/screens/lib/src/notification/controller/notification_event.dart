part of 'notification_bloc.dart';

@immutable
sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

final class LoadNotification extends NotificationEvent {
  const LoadNotification();
}

final class DisplayNotification extends NotificationEvent {
  const DisplayNotification();
}

final class NotificationBackButtonPressedEvent extends NotificationEvent {
  const NotificationBackButtonPressedEvent();
}

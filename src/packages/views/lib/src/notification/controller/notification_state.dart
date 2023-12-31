// ignore_for_file: public_member_api_docs

part of 'notification_bloc.dart';

@immutable
sealed class NotificationState extends Equatable {
  const NotificationState({
    required this.notifications,
    required this.dates,
  });

  /// Map of order of notification and list of notification
  /// Ex: {1: {'Title', 'Message'}}
  final Map<int, List<String>> notifications;

  /// List of date of notification
  final List<DateTime> dates;

  @override
  List<Object?> get props => [
        notifications,
        dates,
      ];

  NotificationState copyWith({
    Map<int, List<String>>? notifications,
    List<DateTime>? dates,
  });
}

final class NotificationInitial extends NotificationState {
  const NotificationInitial.empty()
      : super(
          notifications: const {},
          dates: const [],
        );

  const NotificationInitial.input({
    required super.notifications,
    required super.dates,
  });

  @override
  NotificationState copyWith({
    Map<int, List<String>>? notifications,
    List<DateTime>? dates,
  }) {
    return const NotificationInitial.empty();
  }
}

final class NotificationLoading extends NotificationState {
  const NotificationLoading({
    required super.notifications,
    required super.dates,
  });

  factory NotificationLoading.from(
    NotificationState notificationInitial,
  ) {
    return NotificationLoading(
      notifications: notificationInitial.notifications,
      dates: notificationInitial.dates,
    );
  }

  @override
  NotificationState copyWith({
    Map<int, List<String>>? notifications,
    List<DateTime>? dates,
  }) {
    return NotificationLoading(
      notifications: notifications ?? super.notifications,
      dates: dates ?? super.dates,
    );
  }
}

final class NotificationLoaded extends NotificationState {
  const NotificationLoaded({
    required super.notifications,
    required super.dates,
  });

  factory NotificationLoaded.from(
    NotificationState notificationInitial,
  ) {
    return NotificationLoaded(
      notifications: notificationInitial.notifications,
      dates: notificationInitial.dates,
    );
  }

  @override
  NotificationState copyWith({
    Map<int, List<String>>? notifications,
    List<DateTime>? dates,
  }) {
    return NotificationLoaded(
      notifications: notifications ?? super.notifications,
      dates: dates ?? super.dates,
    );
  }
}

final class NotificationError extends NotificationState {
  const NotificationError({
    required super.notifications,
    required super.dates,
  });

  factory NotificationError.from(
    NotificationState notificationInitial,
  ) {
    return NotificationError(
      notifications: notificationInitial.notifications,
      dates: notificationInitial.dates,
    );
  }

  @override
  NotificationState copyWith({
    Map<int, List<String>>? notifications,
    List<DateTime>? dates,
  }) {
    return NotificationError(
      notifications: notifications ?? super.notifications,
      dates: dates ?? super.dates,
    );
  }
}

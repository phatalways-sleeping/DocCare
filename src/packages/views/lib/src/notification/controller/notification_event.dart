// ignore_for_file: public_member_api_docs

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

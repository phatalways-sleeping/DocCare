import 'dart:async';

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:utility/utility.dart';

part 'notification_state.dart';

/// [NotificationManager] is the concrete class implementing
/// [NotificationManagerService].
class NotificationManager implements NotificationManagerService {
  /// [NotificationManager] constructor.
  /// It requires [GlobalKey] to be injected.
  NotificationManager._();

  /// Static instance of [NotificationManager].
  /// It requires [GlobalKey] to be injected in the constructor.
  static late final NotificationManager instance;

  /// [_overlayEntry] is the entry to display the notification.
  OverlayEntry? _overlayEntry;

  /// [init] is the method to initialize the [NotificationManager].
  static void init() {
    instance = GetIt.instance.registerSingleton(NotificationManager._());

    // Register lazing singletons
    GetIt.instance.registerLazySingleton(DismissedNotificationBuilder.new);
    GetIt.instance.registerLazySingleton(LoginNotificationBuilder.new);
    GetIt.instance.registerLazySingleton(ErrorNotificationBuilder.new);
    GetIt.instance.registerLazySingleton(SignUpNotificationBuilder.new);
    GetIt.instance
        .registerLazySingleton(AdminCreateStaffNotificationBuilder.new);
    GetIt.instance
        .registerLazySingleton(AdminDeleteStaffNotificationBuilder.new);
  }

  @override
  void dismiss<T>([T? result]) {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  NotificationBuilder _mapNotificationTypeToNotificationBuilder(
    NotificationType type,
  ) {
    switch (type) {
      case NotificationType.signUp:
        return GetIt.instance<SignUpNotificationBuilder>();
      case NotificationType.login:
        return GetIt.instance<LoginNotificationBuilder>();
      case NotificationType.dismissed:
        return GetIt.instance<DismissedNotificationBuilder>();
      case NotificationType.adminCreateStaff:
        return GetIt.instance<AdminCreateStaffNotificationBuilder>();
      case NotificationType.adminDeleteStaff:
        return GetIt.instance<AdminDeleteStaffNotificationBuilder>();
      case NotificationType.error:
        return GetIt.instance<ErrorNotificationBuilder>();
    }
  }

  @override
  Future<T?> show<T>(
    BuildContext context,
    NotificationType type, {
    Widget? title,
    Widget? message,
    Duration duration = const Duration(seconds: 2),
  }) {
    assert(type != NotificationType.dismissed, 'Type is dismissed');
    dismiss<T>();

    final notificationBuilder = _mapNotificationTypeToNotificationBuilder(type)
      ..wrapWith(
        title: title ?? const SizedBox.shrink(),
        message: message ?? const SizedBox.shrink(),
      );

    _overlayEntry = OverlayEntry(
      builder: notificationBuilder.build,
    );

    Overlay.of(context).insert(_overlayEntry!);

    Future.delayed(
      duration,
      () => dismiss<void>(),
    );
    // Since we are not returning anything,
    // we return Future.value()
    return Future.value();
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
  }
}

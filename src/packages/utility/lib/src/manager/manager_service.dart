import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:utility/src/manager/dialog_manager.dart';

import 'package:utility/utility.dart';

/// [ManagerService] is the base class for all manager services.
/// including: managing dialog, notification, which requires to
/// display on top of the screen.
abstract interface class ManagerService<R> {
  /// [ManagerService] constructor.
  /// It requires [GlobalKey] to be injected.
  const ManagerService();

  /// [navigatorKey] is the key to navigate the widget on top of the screen.
  /// It requires [GlobalKey] to be injected.
  GlobalKey<NavigatorState> get navigatorKey;

  /// [dismiss] is the method to dismiss the widget on top of the screen.
  /// It requires [result] to be injected.
  /// [result] is the result of the widget.
  void dismiss<T>([T? result]);

  /// [show] is the method to show the widget on top of the screen.
  Future<T?> show<T>(R type, {
    Widget? title,
    Widget? message,
    Duration duration = const Duration(seconds: 2),
  });

  /// [dispose] is the method to dispose the manager service.
  /// For example, it is used to close the stream controller.
  void dispose();
}

/// [DialogManagerService] is the base class for all dialog manager services.
/// including: managing dialog, which requires to display on top of the screen.
abstract interface class DialogManagerService
    extends ManagerService<DialogType> {
  /// [DialogManagerService] constructor.
  const DialogManagerService();
}

/// [NotificationManagerService] is the base class for all notification manager
/// services, including: managing notification, which requires
/// to display on top of the screen.
abstract interface class NotificationManagerService
    extends ManagerService<NotificationType> {
  /// [NotificationManagerService] constructor.
  const NotificationManagerService();
}

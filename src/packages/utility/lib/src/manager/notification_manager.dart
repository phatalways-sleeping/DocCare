import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:utility/utility.dart';

/// [NotificationManager] is the concrete class implementing
/// [NotificationManagerService].
class NotificationManager implements NotificationManagerService {
  /// [NotificationManager] constructor.
  /// It requires [GlobalKey] to be injected.
  NotificationManager._(this._navigatorKey);

  final GlobalKey<NavigatorState> _navigatorKey;

  /// Static instance of [NotificationManager].
  /// It requires [GlobalKey] to be injected in the constructor.
  static late final NotificationManager instance;

  OverlayEntry? _overlayEntry;

  /// [init] is the method to initialize the [NotificationManager].
  static void init(GlobalKey<NavigatorState> navigatorKey) {
    instance =
        GetIt.instance.registerSingleton(NotificationManager._(navigatorKey));

    // Register lazing singletons
    GetIt.instance.registerLazySingleton(DismissedNotificationState.new);
  }

  @override
  void dismiss<T>([T? result]) {
    assert(_navigatorKey.currentContext != null, 'Navigator key is null');
    _overlayEntry?.remove();
    
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Future<T?> show<T>(NotificationState state) async {
    assert(_navigatorKey.currentContext != null, 'Navigator key is null');
    assert(state is! DismissedNotificationState, 'State is dismissed');
    dismiss<T>();
    _overlayEntry = OverlayEntry(
      builder: (context) => state.build(
        context,
      ),
    );

    Overlay.of(_navigatorKey.currentContext!).insert(_overlayEntry!);

    return Future.value();
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
  }
}

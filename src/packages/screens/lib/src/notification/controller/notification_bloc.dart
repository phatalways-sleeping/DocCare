import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial.empty()) {
    on<LoadNotification>(_onLoadNotification);
    on<DisplayNotification>(_onDisplayNotification);
  }

  Future<void> _onLoadNotification(
    LoadNotification event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading.from(state));

    // Make modifiable copies of the maps
    final currentMap = Map<int, List<String>>.from(state.notifications);
    final currentMapDates = List<DateTime>.from(state.dates);

    for (var i = 0; i < 5; ++i) {
      // Use unique keys for map entries - here I assume `i` provides uniqueness
      currentMap[currentMap.length] = [
        'Upcoming appointment in 15 minutes',
        'Your next appointment with Dr. Johnny Sins will start in 15 minutes',
      ];
      currentMapDates.add(DateTime.now());
    }

    emit(
      NotificationLoaded.from(
        state.copyWith(
          notifications: currentMap,
          dates: currentMapDates,
        ),
      ),
    );
  }

  void _onDisplayNotification(
    DisplayNotification event,
    Emitter<NotificationState> emit,
  ) {}
}

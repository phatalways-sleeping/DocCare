// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:controllers/controllers.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc(
    this._customerRepositoryService,
  ) : super(const NotificationInitial.empty()) {
    on<LoadNotification>(_onLoadNotification);
  }

  final CustomerRepositoryService _customerRepositoryService;

  Future<void> _onLoadNotification(
    LoadNotification event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading.from(state));

    // Make modifiable copies of the maps
    final currentMap = Map<int, List<String>>.from(state.notifications);
    final currentMapDates = List<DateTime>.from(state.dates);

    final currentTime = DateTime.now();
    final data = await _customerRepositoryService
        .getAppointmentStatusDoctorName()
        .timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        emit(NotificationError.from(state));
        return [];
      },
    );
    for (final element in data) {
      final time = DateFormat('HH:mm:ss').parse(element['time'].toString());
      final dateTime = DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        time.hour,
        time.minute,
        time.second, // Include seconds
      );

      final formattedDateTime = DateFormat('hh:mm a, d MMM y').format(dateTime);

      if (element['status'] == true) {
        final message = 'Your appointment with Dr. ${element['doctorName']} '
            'at $formattedDateTime is cancelled.';
        currentMap[currentMap.length] = [
          'Appointment Cancelled',
          message,
        ];
        currentMapDates.add(dateTime);
      } else {
        final timeToAppointment = dateTime.difference(currentTime);
        if (timeToAppointment.inMinutes <= 1000 &&
            timeToAppointment.inMinutes > 0) {
          final message =
              'Your next appointment with Dr. ${element['doctorName']} '
              'will start in ${timeToAppointment.inMinutes} '
              'minutes.';
          currentMap[currentMap.length] = [
            'Upcoming appointment in 15 minutes',
            message,
          ];
          currentMapDates.add(dateTime);
        }
      }
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
}

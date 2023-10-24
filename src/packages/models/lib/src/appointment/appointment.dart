import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appointment.g.dart';

@JsonSerializable()
final class Appointment extends Equatable {
  const Appointment({
    required this.customerID,
    required this.doctorID,
    required this.period,
    required this.date,
    this.rating,
    this.customerComment,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);

  @JsonKey(required: true)
  final String customerID;
  @JsonKey(required: true)
  final String doctorID;
  @JsonKey(required: true)
  final int period;
  @JsonKey(required: true)
  final DateTime date;
  @JsonKey()
  final int? rating;
  @JsonKey()
  final String? customerComment;

  @override
  List<Object?> get props =>
      [customerID, doctorID, period, date, rating, customerComment];

  Appointment copyWith({
    String? customerID,
    String? doctorID,
    int? period,
    DateTime? date,
    int? rating,
    String? customerComment,
  }) {
    return Appointment(
      customerID: customerID ?? this.customerID,
      doctorID: doctorID ?? this.doctorID,
      period: period ?? this.period,
      date: date ?? this.date,
      rating: rating ?? this.rating,
      customerComment: customerComment ?? this.customerComment,
    );
  }
}

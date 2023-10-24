import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appointment.g.dart';

@JsonSerializable()
final class Appointment extends Equatable {
  const Appointment({
    required this.customer_id,
    required this.doctor_id,
    required this.period,
    required this.date,
    required this.rating,
    required this.customer_comment,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);

  @JsonKey(required: true)
  final String customer_id;
  @JsonKey(required: true)
  final String doctor_id;
  @JsonKey(required: true)
  final int period;
  @JsonKey(required: true)
  final DateTime date;
  @JsonKey(required: true)
  final int rating;
  @JsonKey(required: true)
  final String customer_comment;

  @override
  List<Object?> get props =>
      [customer_id, doctor_id, period, date, rating, customer_comment];

  Appointment copyWith({
    String? customer_id,
    String? doctor_id,
    int? period,
    DateTime? date,
    int? rating,
    String? customer_comment,
  }) {
    return Appointment(
      customer_id: customer_id ?? this.customer_id,
      doctor_id: doctor_id ?? this.doctor_id,
      period: period ?? this.period,
      date: date ?? this.date,
      rating: rating ?? this.rating,
      customer_comment: customer_comment ?? this.customer_comment,
    );
  }
}

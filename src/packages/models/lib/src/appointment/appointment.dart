// ignore_for_file: public_member_api_docs

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
    this.prescriptionID,
    this.dateDone,
    this.done,
    this.note,
    this.diagnosis,
    this.isCanceled,
    this.customerName,
    this.prescriptionDone
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
  @JsonKey()
  final String? prescriptionID;
  @JsonKey()
  final DateTime? dateDone;
  @JsonKey()
  final bool? done;
  @JsonKey()
  final String? note;
  @JsonKey()
  final String? diagnosis;
  @JsonKey()
  final bool? isCanceled;
  @JsonKey()
  final String? customerName;
  @JsonKey()
  final bool? prescriptionDone;

  @override
  List<Object?> get props =>
      [customerID, doctorID, period, date, rating, customerComment, prescriptionID, dateDone, done, note, diagnosis, isCanceled, customerName, prescriptionDone];

  Appointment copyWith({
    String? customerID,
    String? doctorID,
    int? period,
    DateTime? date,
    int? rating,
    String? customerComment,
    String? prescriptionID,
    DateTime? dateDone,
    bool? done,
    String? note,
    String? diagnosis,
    bool? isCanceled,
    String? customerName,
    bool? prescriptionDone


  }) {
    return Appointment(
      customerID: customerID ?? this.customerID,
      doctorID: doctorID ?? this.doctorID,
      period: period ?? this.period,
      date: date ?? this.date,
      rating: rating ?? this.rating,
      customerComment: customerComment ?? this.customerComment,
      prescriptionID: prescriptionID ?? this.prescriptionID,
      dateDone: dateDone ?? this.dateDone,
      done: done ?? this.done,
      note: note ?? this.note,
      diagnosis: diagnosis ?? this.diagnosis,
      isCanceled: isCanceled ?? this.isCanceled,
      customerName: customerName ?? this.customerName,
      prescriptionDone: prescriptionDone ?? this.prescriptionDone
    );
  }
}

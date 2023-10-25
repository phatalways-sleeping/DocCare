import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'prescription.g.dart';

@JsonSerializable()
class Prescription extends Equatable {
  Prescription({
    required this.id,
    required this.doctorId,
    required this.customerId,
    required this.dateDone,
    required this.datePrescribed,
    this.done = false,
    this.note = '',
  });

  factory Prescription.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionToJson(this);

  @JsonKey(required: true)
  final String id;
  @JsonKey(required: true)
  final String doctorId;
  @JsonKey(required: true)
  final String customerId;
  @JsonKey(required: true)
  final DateTime dateDone;
  @JsonKey(required: true)
  final DateTime datePrescribed;
  @JsonKey(required: true)
  bool done;
  @JsonKey(required: false)
  final String note;

  @override
  List<Object?> get props =>
      [id, doctorId, customerId, dateDone, datePrescribed, done, note];

  Prescription copyWith({
    String? id,
    String? doctorId,
    String? customerId,
    DateTime? dateDone,
    DateTime? datePrescribed,
    bool? done,
    String? note,
  }) {
    return Prescription(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      customerId: customerId ?? this.customerId,
      dateDone: dateDone ?? this.dateDone,
      datePrescribed: datePrescribed ?? this.datePrescribed,
      done: done ?? this.done,
      note: note ?? this.note,
    );
  }
}

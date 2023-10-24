import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Prescription.g.dart';

@JsonSerializable()
class Prescription extends Equatable {
  const Prescription({
    required this.id,
    required this.doctorId,
    required this.customerId,
    required this.dateDone,
    required this.datePrescribed,
    required this.done,
    this.note,
  }) : done = done ?? false;

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
  final String dateDone;
  @JsonKey(required: true)
  final String datePrescribed;
  @JsonKey(required: true)
  String done;
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

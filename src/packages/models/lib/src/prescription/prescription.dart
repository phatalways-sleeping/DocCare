import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'prescription.g.dart';

@JsonSerializable()
class Prescription extends Equatable {
  Prescription({
    required this.id,
    required this.doctorID,
    required this.customerID,
    required this.dateDone,
    required this.datePrescribed,
    this.done = false,
    this.note = '',
    this.diagnosis = '',
  });

  factory Prescription.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionToJson(this);

  @JsonKey(required: true)
  final String id;
  @JsonKey(required: true)
  final String doctorID;
  @JsonKey(required: true)
  final String customerID;
  @JsonKey(required: true)
  final DateTime dateDone;
  @JsonKey(required: true)
  final DateTime datePrescribed;
  @JsonKey(required: true)
  final bool done;
  @JsonKey(required: false)
  final String note;
  @JsonKey(required: false)
  final String diagnosis;

  @override
  List<Object?> get props =>
      [id, doctorID, customerID, dateDone, datePrescribed, done, note];

  Prescription copyWith({
    String? id,
    String? doctorID,
    String? customerID,
    DateTime? dateDone,
    DateTime? datePrescribed,
    bool? done,
    String? note,
    String? diagnosis,
  }) {
    return Prescription(
      id: id ?? this.id,
      doctorID: doctorID ?? this.doctorID,
      customerID: customerID ?? this.customerID,
      dateDone: dateDone ?? this.dateDone,
      datePrescribed: datePrescribed ?? this.datePrescribed,
      done: done ?? this.done,
      note: note ?? this.note,
      diagnosis: diagnosis ?? this.diagnosis,
    );
  }
}

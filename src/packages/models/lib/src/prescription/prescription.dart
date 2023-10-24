import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Prescription.g.dart';

@JsonSerializable()
final class Prescription extends Equatable {
  const Prescription({
    required this.id,
    required this.doctor_id,
    required this.customer_id,
    required this.date_done,
    required this.date_prescribed,
    required this.done,
    this.note,
  }); : done = done ?? false;

  factory Prescription.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionToJson(this);

  @JsonKey(required: true)
  final String id;
  @JsonKey(required: true)
  final String doctor_id;
  @JsonKey(required: true)
  final String customer_id;
  @JsonKey(required: true)
  final String date_done;
  @JsonKey(required: true)
  final String date_prescribed;
  @JsonKey(required: true)
  String done;
  @JsonKey(required: false)
  final String note;

  @override
  List<Object?> get props =>
      [id, doctor_id, customer_id, date_done, date_prescribed, done, note];

  Prescription copyWith({
    String? id,
    String? doctor_id,
    String? customer_id,
    DateTime? date_done,
    DateTime? date_prescribed,
    bool? done,
    String? note,
    
  }) {
    return Prescription(
      id: id ?? this.id,
      doctor_id: doctor_id ?? this.doctor_id,
      customer_id: customer_id ?? this.customer_id,
      date_done: date_done ?? this.date_done,
      date_prescribed: date_prescribed ?? this.date_prescribed,
      done: done ?? this.done,
      note: note ?? this.note,
    );
  }
}
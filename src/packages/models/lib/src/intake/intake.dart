import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'intake.g.dart';

@JsonSerializable()
final class Intake extends Equatable {
  const Intake({
    required this.medicine_name,
    required this.prescription_id,
    this.duration,
    this.time_of_the_day,
    this.to_be_taken,
    this.quantity,
  });

  factory Intake.fromJson(Map<String, dynamic> json) => _$IntakeFromJson(json);

  Map<String, dynamic> toJson() => _$IntakeToJson(this);

  @JsonKey(required: true)
  final String medicine_name;
  @JsonKey(required: true)
  final String prescription_id;
  @JsonKey()
  final int? duration;
  @JsonKey()
  final String? time_of_the_day;
  @JsonKey()
  final int? to_be_taken;
  @JsonKey()
  final int? quantity;

  @override
  List<Object?> get props => [
        this.medicine_name,
        this.prescription_id,
        this.duration,
        this.time_of_the_day,
        this.to_be_taken,
        this.quantity
      ];

  @override
  Intake copyWith({
    String? medicine_name,
    String? prescription_id,
    int? duration,
    String? time_of_the_day,
    int? to_be_taken,
    int? quantity,
  }) {
    return Intake(
      medicine_name: medicine_name ?? this.medicine_name,
      prescription_id: prescription_id ?? this.prescription_id,
      duration: duration ?? this.duration,
      time_of_the_day: time_of_the_day ?? this.time_of_the_day,
      to_be_taken: to_be_taken ?? this.to_be_taken,
      quantity: quantity ?? this.quantity,
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'intake.g.dart';

@JsonSerializable()
final class Intake extends Equatable {
  const Intake({
    required this.medicineName,
    required this.prescriptionID,
    this.duration,
    this.timeOfTheDay,
    this.toBeTaken,
    this.quantity,
  });

  factory Intake.fromJson(Map<String, dynamic> json) => _$IntakeFromJson(json);

  Map<String, dynamic> toJson() => _$IntakeToJson(this);

  @JsonKey(required: true)
  final String medicineName;
  @JsonKey(required: true)
  final String prescriptionID;
  @JsonKey()
  final int? duration;
  @JsonKey()
  final String? timeOfTheDay;
  @JsonKey()
  final int? toBeTaken;
  @JsonKey()
  final int? quantity;

  @override
  List<Object?> get props => [
        this.medicineName,
        this.prescriptionID,
        this.duration,
        this.timeOfTheDay,
        this.toBeTaken,
        this.quantity,
      ];

  Intake copyWith({
    String? medicineName,
    String? prescriptionID,
    int? duration,
    String? timeOfTheDay,
    int? toBeTaken,
    int? quantity,
  }) {
    return Intake(
      medicineName: medicineName ?? this.medicineName,
      prescriptionID: prescriptionID ?? this.prescriptionID,
      duration: duration ?? this.duration,
      timeOfTheDay: timeOfTheDay ?? this.timeOfTheDay,
      toBeTaken: toBeTaken ?? this.toBeTaken,
      quantity: quantity ?? this.quantity,
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'working_shift.g.dart';

@JsonSerializable()
class WorkingShift extends Equatable {
  WorkingShift({
    required this.doctorID,
    required this.startPeriodID,
    required this.dayOfWeek,
    required this.endPeriodID,
  });

  factory WorkingShift.fromJson(Map<String, dynamic> json) =>
      _$WorkingShiftFromJson(json);

  Map<String, dynamic> toJson() => _$WorkingShiftToJson(this);

  @JsonKey(required: true)
  final String doctorID;
  @JsonKey(required: true)
  final int startPeriodID;
  @JsonKey(required: true)
  final String dayOfWeek;
  @JsonKey(required: true)
  final int endPeriodID;

  @override
  List<Object?> get props =>
      [doctorID, startPeriodID, dayOfWeek, endPeriodID];

  WorkingShift copyWith({
    String? doctorID,
    int? startPeriodID,
    String? dayOfWeek,
    int? endPeriodID,
  }) {
    return WorkingShift(
      doctorID: doctorID ?? this.doctorID,
      startPeriodID: startPeriodID ?? this.startPeriodID,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      endPeriodID: endPeriodID ?? this.endPeriodID,
    );
  }
}

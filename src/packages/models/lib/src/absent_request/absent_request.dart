import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'absent_request.g.dart';

@JsonSerializable()
final class AbsentRequest extends Equatable {
  const AbsentRequest({
    required this.doctorID,
    required this.date,
    required this.doctorName,
    required this.dateRequest,
    this.reason,
    required this.isApproved,
  });

  factory AbsentRequest.fromJson(Map<String, dynamic> json) =>
      _$AbsentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AbsentRequestToJson(this);

  @JsonKey(required: true)
  final String doctorID;
  @JsonKey(required: true)
  final DateTime date;
  @JsonKey(required: true)
  final String doctorName;
  @JsonKey(required: true)
  final String dateRequest;
  @JsonKey()
  final String? reason;
  @JsonKey(required: true)
  final bool isApproved;

  @override
  List<Object?> get props => [
        this.doctorID,
        this.date,
        this.doctorName,
        this.dateRequest,
        this.reason,
        this.isApproved,
      ];

  AbsentRequest copyWith({
    String? doctorID,
    DateTime? date,
    String? doctorName,
    String? dateRequest,
    String? reason,
    bool? isApproved,
  }) {
    return AbsentRequest(
      doctorID: doctorID ?? this.doctorID,
      date: date ?? this.date,
      doctorName: doctorName ?? this.doctorName,
      dateRequest: dateRequest ?? this.dateRequest,
      reason: reason ?? this.reason,
      isApproved: isApproved ?? this.isApproved,
    );
  }
}

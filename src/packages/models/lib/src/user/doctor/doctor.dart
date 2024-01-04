import 'package:json_annotation/json_annotation.dart';

import 'package:models/src/user/base_user/base_user.dart';

part 'doctor.g.dart';

@JsonSerializable()
final class Doctor extends MedicalStaff {
  const Doctor({
    required super.id,
    required super.fullname,
    required super.email,
    required super.phone,
    super.birthday,
    required this.specializationId,
    required this.startWorkingFrom,
    this.rating,
    this.numberOfRates,
    this.imageUrl,
  });


  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorToJson(this);

  @JsonKey(required: true)
  final String specializationId;
  @JsonKey()
  final int startWorkingFrom;
  @JsonKey()
  final double? rating;
  @JsonKey()
  final int? numberOfRates;
  @JsonKey()
  final String? imageUrl;

  @override
  Doctor copyWith({
    String? id,
    String? fullname,
    String? email,
    String? phone,
    DateTime? birthday,
    String? specializationId,
    int? startWorkingFrom,
    double? rating,
    int? numberOfRates,
    String? imageUrl,
  }) {
    return Doctor(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
      specializationId: specializationId ?? this.specializationId,
      startWorkingFrom: startWorkingFrom ?? this.startWorkingFrom,
      rating: rating ?? this.rating,
      numberOfRates: numberOfRates ?? this.numberOfRates,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        specializationId,
        startWorkingFrom,
        rating,
        numberOfRates,
        imageUrl,
      ];
}

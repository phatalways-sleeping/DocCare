// ignore_for_file: public_member_api_docs

part of 'doctor_view_bloc.dart';

@immutable
sealed class DoctorViewState extends Equatable {
  const DoctorViewState({
    required this.filteredSpecialties,
    required this.filteredRating,
  });

  final List<String> filteredSpecialties;
  final String filteredRating;

  @override
  List<Object?> get props => [
        filteredSpecialties,
        filteredRating,
      ];

  DoctorViewState copyWith({
    List<String>? filteredSpecialties,
    String? filteredRating,
  });
}

final class DoctorViewInitial extends DoctorViewState {
  const DoctorViewInitial({
    super.filteredSpecialties = const ['All'],
    super.filteredRating = 'All',
  });

  factory DoctorViewInitial.fromState({
    required DoctorViewState state,
  }) {
    return DoctorViewInitial(
      filteredSpecialties: state.filteredSpecialties.isEmpty
          ? const ['All']
          : state.filteredSpecialties,
      filteredRating: state.filteredRating,
    );
  }

  @override
  DoctorViewInitial copyWith({
    List<String>? filteredSpecialties,
    String? filteredRating,
  }) {
    return DoctorViewInitial(
      filteredSpecialties: filteredSpecialties ?? this.filteredSpecialties,
      filteredRating: filteredRating ?? this.filteredRating,
    );
  }
}

final class DoctorViewChooseDoctor extends DoctorViewState {
  const DoctorViewChooseDoctor({
    required this.doctor,
  }) : super(
          filteredRating: 'All',
          filteredSpecialties: const ['All'],
        );

  final Map<String, dynamic> doctor;

  @override
  List<Object?> get props => [
        ...super.props,
      ];

  @override
  DoctorViewChooseDoctor copyWith({
    List<String>? filteredSpecialties,
    String? filteredRating,
    Map<String, dynamic>? doctor,
  }) {
    return DoctorViewChooseDoctor(
      doctor: doctor ?? this.doctor,
    );
  }
}

final class DoctorViewFilter extends DoctorViewState {
  const DoctorViewFilter({
    super.filteredSpecialties = const ['All'],
    super.filteredRating = 'All',
  });

  factory DoctorViewFilter.fromState({
    required DoctorViewState state,
  }) {
    return DoctorViewFilter(
      filteredSpecialties: state.filteredSpecialties,
      filteredRating: state.filteredRating,
    );
  }

  @override
  DoctorViewFilter copyWith({
    List<String>? filteredSpecialties,
    String? filteredRating,
  }) {
    return DoctorViewFilter(
      filteredSpecialties: filteredSpecialties ?? this.filteredSpecialties,
      filteredRating: filteredRating ?? this.filteredRating,
    );
  }
}

final class DoctorViewSearchForName extends DoctorViewState {
  const DoctorViewSearchForName({
    required super.filteredSpecialties,
    required super.filteredRating,
    required this.searchedName,
  });

  factory DoctorViewSearchForName.fromState({
    required DoctorViewState state,
    required String searchedName,
  }) {
    return DoctorViewSearchForName(
      filteredSpecialties: state.filteredSpecialties,
      filteredRating: state.filteredRating,
      searchedName: searchedName,
    );
  }
  final String searchedName;

  @override
  List<Object?> get props => [
        ...super.props,
        searchedName,
      ];

  @override
  DoctorViewSearchForName copyWith({
    List<String>? filteredSpecialties,
    String? filteredRating,
    String? searchedName,
  }) {
    return DoctorViewSearchForName(
      filteredSpecialties: filteredSpecialties ?? this.filteredSpecialties,
      filteredRating: filteredRating ?? this.filteredRating,
      searchedName: searchedName ?? this.searchedName,
    );
  }
}

final class DoctorViewLoading extends DoctorViewState {
  const DoctorViewLoading({
    required this.searchedName,
    super.filteredSpecialties = const [],
    super.filteredRating = 'All',
  });

  factory DoctorViewLoading.fromState({
    required DoctorViewState state,
    required String searchedName,
  }) {
    return DoctorViewLoading(
      filteredSpecialties: state.filteredSpecialties,
      filteredRating: state.filteredRating,
      searchedName: searchedName,
    );
  }

  final String searchedName;

  @override
  DoctorViewLoading copyWith({
    List<String>? filteredSpecialties,
    String? filteredRating,
    String? searchedName,
  }) {
    return DoctorViewLoading(
      filteredSpecialties: filteredSpecialties ?? this.filteredSpecialties,
      filteredRating: filteredRating ?? this.filteredRating,
      searchedName: searchedName ?? this.searchedName,
    );
  }
}

final class DoctorViewError extends DoctorViewState {
  const DoctorViewError({
    required this.searchedName,
    required this.error,
    super.filteredSpecialties = const [],
    super.filteredRating = 'All',
  });

  final String searchedName;
  final String error;

  @override
  List<Object?> get props => [
        ...super.props,
        searchedName,
        error,
      ];

  @override
  DoctorViewError copyWith({
    List<String>? filteredSpecialties,
    String? filteredRating,
    String? searchedName,
    String? error,
  }) {
    return DoctorViewError(
      filteredSpecialties: filteredSpecialties ?? this.filteredSpecialties,
      filteredRating: filteredRating ?? this.filteredRating,
      searchedName: searchedName ?? this.searchedName,
      error: error ?? this.error,
    );
  }
}

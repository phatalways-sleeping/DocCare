// ignore_for_file: public_member_api_docs

part of 'doctor_view_bloc.dart';

@immutable
sealed class DoctorViewState extends Equatable {
  const DoctorViewState({
    required this.filteredSpecialties,
    required this.filteredRating,
  });

  final List<String> filteredSpecialties;
  final List<String> filteredRating;

  @override
  List<Object?> get props => [
        filteredSpecialties,
        filteredRating,
      ];

  DoctorViewState copyWith({
    List<String>? filteredSpecialties,
    List<String>? filteredRating,
  });
}

final class DoctorViewInitial extends DoctorViewState {
  const DoctorViewInitial({
    super.filteredSpecialties = const ['All'],
    super.filteredRating = const ['All'],
  });

  factory DoctorViewInitial.fromState({
    required DoctorViewState state,
  }) {
    return DoctorViewInitial(
      filteredSpecialties: state.filteredSpecialties.isEmpty
          ? const ['All']
          : state.filteredSpecialties,
      filteredRating:
          state.filteredRating.isEmpty ? const ['All'] : state.filteredRating,
    );
  }

  @override
  DoctorViewInitial copyWith({
    List<String>? filteredSpecialties,
    List<String>? filteredRating,
  }) {
    return DoctorViewInitial(
      filteredSpecialties: filteredSpecialties ?? this.filteredSpecialties,
      filteredRating: filteredRating ?? this.filteredRating,
    );
  }
}

final class DoctorViewFilter extends DoctorViewState {
  const DoctorViewFilter({
    super.filteredSpecialties = const ['All'],
    super.filteredRating = const ['All'],
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
    List<String>? filteredRating,
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
    List<String>? filteredRating,
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
    super.filteredRating = const [],
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
    List<String>? filteredRating,
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
    super.filteredRating = const [],
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
    List<String>? filteredRating,
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

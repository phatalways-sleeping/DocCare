import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/src/booking/doctor_view/controller/doctor_view_bloc.dart';
import 'package:screens/src/booking/doctor_view/filter/dc_filter_button.dart';

const specialty = [
  'All',
  'Cardiologist',
  'Dentist',
  'Dermatologist',
  'Gastroenterologist',
  'General Physician',
  'Gynaecologist',
  'Neurologist',
  'Ophthalmologist',
  'Orthopedic',
  'Pediatrician',
  'Psychiatrist',
  'Urologist',
];

const rating = [
  'All',
  '1',
  '2',
  '3',
  '4',
  '5',
];

class DCDoctorFilterScreen extends StatefulWidget {
  const DCDoctorFilterScreen({super.key});

  @override
  State<DCDoctorFilterScreen> createState() => _DCDoctorFilterScreenState();
}

class _DCDoctorFilterScreenState extends State<DCDoctorFilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DCCustomerHeaderBar(
        title: 'Filter',
        allowNavigateBack: true,
        onLeadingIconPressed: (context) => context.read<DoctorViewBloc>().add(
              const DoctorViewInitialEvent(),
            ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.03,
        ).copyWith(
          top: context.height * 0.05,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Speciality',
              style: context.textTheme.bodyBoldPoppins.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocSelector<DoctorViewBloc, DoctorViewState, List<String>>(
              selector: (state) => state.filteredSpecialties,
              builder: (context, state) {
                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: specialty
                      .map(
                        (e) => DCSpecialtyButton(
                          specialty: e,
                          isSelected: state.contains(e),
                          onPressed: (context) => context
                              .read<DoctorViewBloc>()
                              .add(
                                DoctorViewFilterSpecialtyEvent(specialty: e),
                              ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Rating',
              style: context.textTheme.bodyBoldPoppins.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocSelector<DoctorViewBloc, DoctorViewState, String>(
              selector: (state) => state.filteredRating,
              builder: (context, state) {
                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: rating
                      .map(
                        (e) => DCRatingButton(
                          rating: e,
                          isSelected: state == e,
                          onPressed: (context) =>
                              context.read<DoctorViewBloc>().add(
                                    DoctorViewFilterRatingEvent(rating: e),
                                  ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.03,
          vertical: context.height * 0.02,
        ),
        child: Row(
          children: [
            Expanded(
              child: DCSpecialtyButton(
                onPressed: (context) => context.read<DoctorViewBloc>().add(
                      const DoctorViewResetFiltersEvent(),
                    ),
                specialty: 'Reset',
                isSelected: false,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: DCSpecialtyButton(
                onPressed: (context) => context.read<DoctorViewBloc>().add(
                      const DoctorViewInitialEvent(),
                    ),
                specialty: 'Apply',
                isSelected: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

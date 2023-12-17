import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
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
      appBar: const DCCustomerHeaderBar(
        title: 'Filter',
        allowNavigateBack: true,
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
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: specialty
                  .map(
                    (e) => DCSpecialtyButton(
                      specialty: e,
                      isSelected: false,
                      onPressed: (context) {},
                    ),
                  )
                  .toList(),
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
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: rating
                  .map(
                    (e) => DCRatingButton(
                      rating: e,
                      isSelected: false,
                      onPressed: (context) {},
                    ),
                  )
                  .toList(),
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
            )),
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.03,
          vertical: context.height * 0.02,
        ),
        child: Row(
          children: [
            Expanded(
              child: DCSpecialtyButton(
                onPressed: (context) {},
                specialty: 'Reset',
                isSelected: false,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: DCSpecialtyButton(
                onPressed: (context) {},
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

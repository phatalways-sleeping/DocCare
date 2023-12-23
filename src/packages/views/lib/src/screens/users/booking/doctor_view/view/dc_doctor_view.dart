import 'dart:math';

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:views/src/screens/users/booking/doctor_view/controller/doctor_view_bloc.dart';
import 'package:views/src/screens/users/booking/doctor_view/view/dc_doctor_card.dart';
import 'package:views/src/screens/users/booking/doctor_view/view/dc_search_bar.dart';

class DCDoctorViewScreen extends StatefulWidget {
  const DCDoctorViewScreen({super.key});

  @override
  State<DCDoctorViewScreen> createState() => _DCDoctorViewScreenState();
}

class _DCDoctorViewScreenState extends State<DCDoctorViewScreen> {
  final controller = ScrollController();
  bool showBottomNavBar = true;
  @override
  void initState() {
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent - 100 &&
          !controller.position.outOfRange) {
        // hide bottom nav bar
        setState(() {
          showBottomNavBar = false;
        });
      }
      if (controller.offset <= controller.position.minScrollExtent &&
          !controller.position.outOfRange) {
        // show bottom nav bar
        setState(() {
          showBottomNavBar = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DCCustomerHeaderBar(
        title: 'DocCare',
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        controller: controller,
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.03,
          vertical: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  'Category: ',
                  style: context.textTheme.bodyRegularPoppins.copyWith(
                    fontSize: 18,
                  ),
                ),
                BlocSelector<DoctorViewBloc, DoctorViewState, List<String>>(
                  selector: (state) => state.filteredSpecialties,
                  builder: (context, state) {
                    final specialties = state.join(', ').substring(
                          0,
                          min(
                            state.join(', ').length,
                            23,
                          ),
                        );
                    final suffix = state.join(', ').length > 23 ? '...' : '';
                    return Text(
                      '$specialties' '$suffix',
                      style: context.textTheme.bodyBoldPoppins.copyWith(
                        fontSize: 18,
                      ),
                    );
                  },
                ),
                const Spacer(),
                IconButton.filled(
                  onPressed: () => context.read<DoctorViewBloc>().add(
                        const DoctorViewFilterEvent(),
                      ),
                  padding: EdgeInsets.zero,
                  splashColor: Colors.white,
                  highlightColor: Colors.white,
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(2),
                    backgroundColor: const MaterialStatePropertyAll(
                      Colors.transparent,
                    ),
                    surfaceTintColor: MaterialStateProperty.all<Color>(
                      Colors.transparent,
                    ),
                  ),
                  icon: SvgPicture.string(
                    DCSVGIcons.filter,
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(16),
              child: const DCSearchBar(),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<DoctorViewBloc, DoctorViewState>(
              buildWhen: (previous, current) {
                if (previous is DoctorViewSearchForName &&
                    current is DoctorViewInitial) {
                  return true;
                }
                if (previous is DoctorViewInitial &&
                    current is DoctorViewSearchForName) {
                  return true;
                }
                if (previous is DoctorViewSearchForName &&
                    current is DoctorViewSearchForName) {
                  if (previous.searchedName != current.searchedName) {
                    return true;
                  }
                }
                return false;
              },
              builder: (context, state) {
                return FutureBuilder<List<Map<String, dynamic>>>(
                  // future: Future.delayed(
                  //   const Duration(seconds: 2),
                  //   () => List.generate(
                  //     10,
                  //     (index) => {
                  //       'doctorId': index,
                  //       'name': 'Dr. John Doe',
                  //       'speciality': 'Dentist',
                  //       'rating': 4.5,
                  //       'ratingCount': 100,
                  //       'imgPath': 'assets/images/doctor.png',
                  //     },
                  //   ),
                  // ),
                  future: context.read<DoctorViewBloc>().getAvaiableDoctors(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final content = snapshot.data ?? [];
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: content.length,
                        itemBuilder: (context, index) {
                          final data = content[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: context.height * 0.01,
                            ),
                            child: DCDoctorCard(
                              name: data['name'] as String,
                              speciality: data['speciality'] as String,
                              rating: data['rating'] as double,
                              ratingCount: data['ratingCount'] as int,
                              imgPath: data['imgPath'] as String,
                              onPressed: (context) =>
                                  context.read<DoctorViewBloc>().add(
                                        DoctorViewChooseDoctorEvent(
                                          doctor: data,
                                        ),
                                      ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Icon(
                          Icons.error,
                          size: 30,
                          color: context.colorScheme.error,
                        ),
                      );
                    }
                    return SizedBox(
                      height: context.height * 0.15,
                      width: context.width * 0.2,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: context.colorScheme.secondary,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      drawer: const DCCustomerDrawer(),
      extendBody: true,
      bottomNavigationBar: showBottomNavBar
          ? const DCCustomerNavigationBar(
              selectedIndex: 2,
            )
          : null,
    );
  }
}

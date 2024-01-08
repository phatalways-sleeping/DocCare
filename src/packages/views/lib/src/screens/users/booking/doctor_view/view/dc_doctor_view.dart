// ignore_for_file: public_member_api_docs

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
  const DCDoctorViewScreen({
    super.key,
    this.inCustomerView = true,
  });

  final bool inCustomerView;
  @override
  State<DCDoctorViewScreen> createState() => _DCDoctorViewScreenState();
}

class _DCDoctorViewScreenState extends State<DCDoctorViewScreen> {
  final controller = ScrollController();
  Future<List<Map<String, dynamic>>>? _future;

  @override
  void initState() {
    _future = context.read<DoctorViewBloc>().getAvaiableDoctors();
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
                    const maxLength = 16;
                    final specialties = state.join(', ').substring(
                          0,
                          min(
                            state.join(', ').length,
                            maxLength,
                          ),
                        );
                    final suffix =
                        state.join(', ').length > maxLength ? '...' : '';
                    return Expanded(
                      child: Text(
                        '$specialties' '$suffix',
                        style: context.textTheme.bodyBoldPoppins.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    );
                  },
                ),
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
            BlocConsumer<DoctorViewBloc, DoctorViewState>(
              buildWhen: (previous, current) =>
                  previous.filteredSpecialties != current.filteredSpecialties ||
                  ((previous is DoctorViewSearchForName &&
                          current is DoctorViewSearchForName) &&
                      previous.searchedName != current.searchedName),
              listener: (context, state) {
                _future = context.read<DoctorViewBloc>().getAvaiableDoctors();
              },
              builder: (context, state) {
                return FutureBuilder<List<Map<String, dynamic>>>(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(
                        color: context.colorScheme.secondary,
                      );
                    }

                    if (snapshot.hasData) {
                      final content = snapshot.data ?? [];
                      //debugPrint('content: rebuild');

                      return Column(
                        children: content
                            .map(
                              (e) => Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: context.height * 0.01,
                                ),
                                child: DCDoctorCard(
                                  name: e['name'] as String,
                                  speciality: e['speciality'] as String,
                                  rating: (e['rating'] as num).toDouble(),
                                  ratingCount: e['ratingCount'] as int,
                                  imgPath: e['imgUrl'] as String? ?? '',
                                  onPressed: (context) =>
                                      context.read<DoctorViewBloc>().add(
                                            DoctorViewChooseDoctorEvent(
                                              doctor: e,
                                            ),
                                          ),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.error,
                              size: 30,
                              color: context.colorScheme.error,
                            ),
                            Text(
                              'An error occured. Please try again later.',
                              style:
                                  context.textTheme.bodyRegularPoppins.copyWith(
                                color: context.colorScheme.tertiary,
                                fontSize: 16,
                              ),
                            ),
                          ],
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
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
      drawer: widget.inCustomerView
          ? const DCCustomerDrawer()
          : const DCReceptionistDrawer(),
      extendBody: true,
      bottomNavigationBar: widget.inCustomerView
          ? const DCCustomerNavigationBar(
              selectedIndex: 2,
            )
          : const DCReceptionistNavigationBar(
              selectedIndex: 2,
            ),
    );
  }
}

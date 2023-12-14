// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/src/prescription/controller/prescription_bloc.dart';

class DCMedicine extends StatelessWidget {
  const DCMedicine({
    required this.medicineName,
    required this.details,
    this.onPressed,
    this.isAddMedicine = false,
    super.key,
  });

  final String medicineName;
  final String details;
  final bool isAddMedicine;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isAddMedicine ? onPressed : null,
      child: Card(
        color: isAddMedicine
            ? context.colorScheme.surface
            : context.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Colors.green,
          ),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              SvgPicture.string(
                DCSVGIcons.pill,
                width: 30,
                height: 30,
              ),
              const SizedBox(width: 8),
              if (!isAddMedicine)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              medicineName,
                              style:
                                  context.textTheme.h6RegularPoppins.copyWith(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              BlocProvider.of<PrescriptionBloc>(context).add(
                                RemoveMedicineButtonPressedEvent(medicineName),
                              );
                            },
                            icon: SvgPicture.string(
                              DCSVGIcons.deleteMedicine,
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              details,
                              style:
                                  context.textTheme.h6RegularPoppins.copyWith(
                                fontSize: 14,
                                color: context.colorScheme.onSecondary
                                    .withOpacity(0.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              else
                Expanded(
                  child: Center(
                    child: Text(
                      'Add new medicine',
                      style: context.textTheme.h6RegularPoppins.copyWith(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

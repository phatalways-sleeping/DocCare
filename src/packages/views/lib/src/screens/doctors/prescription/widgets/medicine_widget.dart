// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:views/src/screens/doctors/prescription/controller/prescription_bloc.dart';

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
            ? context.colorScheme.secondary
            : context.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: isAddMedicine
              ? BorderSide.none
              : BorderSide(
                  color: context.colorScheme.onBackground,
                ),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: context.colorScheme.background,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.string(
                  DCSVGIcons.pill,
                  width: 30,
                  height: 30,
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.secondary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: context.width * 0.05),
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
                                fontSize: 18,
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
                              colorFilter: ColorFilter.mode(
                                context.colorScheme.secondary,
                                BlendMode.srcIn,
                              ),
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
                  child: Text(
                    'Add new medicine',
                    style: context.textTheme.h6RegularPoppins.copyWith(
                      fontSize: 18,
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

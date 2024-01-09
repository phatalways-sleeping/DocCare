// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:controllers/controllers.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:views/src/screens/receptionist/absent/controller/receptionist_absent_bloc.dart';
import 'package:views/src/screens/receptionist/absent/doctor_card.dart';
import 'package:views/src/screens/receptionist/absent/show_request_dialog.dart';
import 'package:views/src/widgets/dc_loading_view.dart';

class DCReceptionistAbsentScreen extends StatefulWidget {
  const DCReceptionistAbsentScreen({super.key});

  @override
  State<DCReceptionistAbsentScreen> createState() =>
      _DCReceptionistAbsentScreenState();
}

class _DCReceptionistAbsentScreenState
    extends State<DCReceptionistAbsentScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReceptionistAbsentBloc(
        context.read<ReceptionistRepositoryService>(),
      ),
      child: BlocConsumer<ReceptionistAbsentBloc, ReceptionistAbsentState>(
        listener: (context, state) async {
          if (state is ReceptionistAbsentViewState) {
            await showRequestDialog(
              context: context,
              title: 'Absent Request',
              doctorName: state.data['name']! as String,
              absentDate: state.data['dateAbsent']! as DateTime,
              messageReasons: state.data['reason']! as String,
              messageNotes: 'I will be back soon',
            ).then(
              (value) {
                if (value == RequestResponse.accept) {
                  context.read<ReceptionistAbsentBloc>().add(
                        const ReceptionistAbsentResponseEvent(
                          approved: true,
                        ),
                      );
                } else if (value == RequestResponse.reject) {
                  context.read<ReceptionistAbsentBloc>().add(
                        const ReceptionistAbsentResponseEvent(
                          approved: false,
                        ),
                      );
                } else {
                  context.read<ReceptionistAbsentBloc>().add(
                        const ReceptionistAbsentResetEvent(),
                      );
                }
              },
            );
          } else if (state is ReceptionistAbsentErrorState) {}
        },
        builder: (context, state) => Scaffold(
          appBar: const DCReceptionistHeaderBar(),
          drawer: const DCReceptionistDrawer(),
          bottomNavigationBar: const DCReceptionistNavigationBar(),
          extendBody: true,
          body: Stack(
            children: [
              SizedBox(
                height: context.height,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.03,
                    vertical: context.height * 0.02,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: context.height * 0.02,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Requests',
                              style: context.textTheme.h1BoldPoppins.copyWith(
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(width: 8),
                            SvgPicture.string(
                              DCSVGIcons.absentRequest,
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<ReceptionistAbsentBloc,
                          ReceptionistAbsentState>(
                        buildWhen: (previous, current) =>
                            previous.runtimeType != current.runtimeType,
                        builder: (context, state) {
                          return FutureBuilder<List<Map<String, dynamic>>>(
                            future: context
                                .read<ReceptionistAbsentBloc>()
                                .getPendingAbsentRequests(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                // debugPrint(snapshot.error.toString());
                                return Center(
                                  child: Text(
                                    'Please try again later',
                                    style: context.textTheme.bodyRegularPoppins
                                        .copyWith(
                                      color: context.colorScheme.tertiary,
                                      fontSize: 16,
                                    ),
                                  ),
                                );
                              }
                              if (!snapshot.hasData) {
                                return const SizedBox.shrink();
                              }
                              final data = snapshot.data!;
                              if (data.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No requests',
                                    style: context.textTheme.bodyRegularPoppins
                                        .copyWith(
                                      color: context.colorScheme.tertiary,
                                      fontSize: 16,
                                    ),
                                  ),
                                );
                              }
                              final children = data.map(
                                (e) => Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: context.height * 0.01,
                                  ),
                                  child: DoctorCard(
                                    imgPath: e['imgPath'] as String?,
                                    name: e['name']! as String,
                                    dateAbsent: e['dateAbsent']! as DateTime,
                                    onPressed: (context) => context
                                        .read<ReceptionistAbsentBloc>()
                                        .add(
                                          ReceptionistAbsentViewEvent(
                                            data: e,
                                          ),
                                        ),
                                  ),
                                ),
                              );
                              return Padding(
                                padding: children.isNotEmpty
                                    ? const EdgeInsets.only(
                                        bottom: 50,
                                      )
                                    : EdgeInsets.zero,
                                child: Column(
                                  children: children.toList(),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              if (state is ReceptionistAbsentLoadingState)
                const DCLoadingView(),
            ],
          ),
        ),
      ),
    );
  }
}

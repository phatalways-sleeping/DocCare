// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:screens/src/report/controller/admin_generate_report_bloc.dart';
import 'package:utility/utility.dart';
import 'package:screens/src/report/pdf_service/generate_pdf_service.dart';
import 'package:administrator/src/supabase_admin_generate_report_service.dart';

class DCAdminGenerateReportScreen extends StatefulWidget {
  const DCAdminGenerateReportScreen({super.key});

  @override
  State<DCAdminGenerateReportScreen> createState() =>
      _DCAdminGenerateReportScreenState();
}

class _DCAdminGenerateReportScreenState
    extends State<DCAdminGenerateReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DCCustomerHeaderBar(
        cornerRadius: 12,
        backgroundColor: context.colorScheme.background,
        allowNavigateBack: true,
        onLeadingIconPressed: (context) {
          // TODO: handle navigate back to admin drawer screen
          Navigator.of(context).pop();
        },
      ),
      body: BlocProvider(
        create: (_) => GenerateReportBloc(
          SupabaseAdminGenerateReportService.instance,
          PdfInvoiceService(),
          NotificationManager.instance,
        ),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.width * 0.05,
                      vertical: context.height * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Generate report  ',
                              style: context.textTheme.h6BoldPoppins.copyWith(
                                fontSize: 30,
                              ),
                            ),
                            SvgPicture.string(
                              DCSVGIcons.report,
                              height: 34,
                              width: 34,
                            ),
                          ],
                        ),
                        Text(
                          'Keep track of clinic productivity within a moment',
                          style: context.textTheme.h1RegularPoppins.copyWith(
                            fontSize: 20,
                          ),
                          overflow: TextOverflow.clip,
                          softWrap: true,
                        ),
                        const SizedBox(height: 8),
                        DCOutlinedWithHeadingTextFormField(
                          heading: const Text('From'),
                          hintText: "Enter start month",
                          headingColor: context.colorScheme.onSurface,
                          borderColor: context.colorScheme.onBackground,
                          color: context.colorScheme.onBackground,
                          borderRadius: 16,
                          keyboardType: TextInputType.number,
                          onChanged: (context, controller) => context
                              .read<GenerateReportBloc>()
                              .add(FromMonthInputEvent(
                                  int.parse(controller.text))),
                        ),
                        const SizedBox(height: 8),
                        DCOutlinedWithHeadingTextFormField(
                          heading: const Text('To'),
                          hintText: "Enter end month",
                          headingColor: context.colorScheme.onSurface,
                          borderColor: context.colorScheme.onBackground,
                          color: context.colorScheme.onBackground,
                          borderRadius: 16,
                          keyboardType: TextInputType.number,
                          onChanged: (context, controller) => context
                              .read<GenerateReportBloc>()
                              .add(ToMonthInputEvent(
                                  int.parse(controller.text))),
                        ),
                        const SizedBox(height: 8),
                        DCOutlinedWithHeadingTextFormField(
                          heading: const Text('Year'),
                          hintText: "Enter a specific year",
                          headingColor: context.colorScheme.onSurface,
                          borderColor: context.colorScheme.onBackground,
                          color: context.colorScheme.onBackground,
                          borderRadius: 16,
                          keyboardType: TextInputType.number,
                          onChanged: (context, controller) => context
                              .read<GenerateReportBloc>()
                              .add(YearInputEvent(int.parse(controller.text))),
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: BlocBuilder<GenerateReportBloc,
                              GenerateReportState>(
                            builder: (context, state) {
                              if (state is GenerateReportInitial) {
                                return DCButton(
                                  backgroundColor:
                                      context.colorScheme.secondary,
                                  text: 'Create',
                                  widthFactor: 0.8,
                                  onPressed: (context) =>
                                      context.read<GenerateReportBloc>().add(
                                            const GenerateReportButtonPressedEvent(),
                                          ),
                                );
                              } else if (state is GenerateReportSuccess) {
                                // TODO(): handle navigate to ??? screen
                                return const Text(
                                  'Generating report successfully!',
                                );
                              }
                              return SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  color: context.colorScheme.secondary,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

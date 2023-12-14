import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:screens/src/report/chart/sample_chart.dart';
import 'package:screenshot/screenshot.dart';
import 'package:administrator/src/admin_generate_report_service.dart';
class PdfInvoiceService {
  Future<Uint8List> createInvoice(int startMonth, int endMonth, int year,
      AdminGenerateReportService reportService) async {
    final pdf = pw.Document();
    ScreenshotController screenshotController = ScreenshotController();

    List<pw.Widget> widgets = [];

    for (int month = startMonth; month <= endMonth; month++) {
      widgets.add(
        pw.Header(
          level: 1,
          child: pw.Text('Report for $month/$year'),
        ),
      );
      // // Fetch data from Supabase using service functions

       final totalAppointments =
           await reportService.countAppointmentsInMonth(month, year);

                 print('totalAppointments: $totalAppointments');

      final totalAbsentRequests =
          await reportService.countTotalAbsentRequest(month, year);

                print('totalAbsentRequests: $totalAbsentRequests');

      final averageAppointmentsPerUser =
          await reportService.averageAppointmentsPerUser(month, year);

                print('averageAppointmentsPerUser: $averageAppointmentsPerUser');

      final busiestDay = await reportService.busiestDayPerMonth(month, year);

            print('busiestDay: $busiestDay');

      final mostBookedSpecialty =
          await reportService.mostBookedSpecializationInMonth(month, year);

      print('mostBookedSpecialty: $mostBookedSpecialty');

      final one_star = await reportService.countOneStarInMonth(month, year);
      final two_star = await reportService.countTwoStarInMonth(month, year);
      final three_star = await reportService.countThreeStarInMonth(month, year);
      final four_star = await reportService.countFourStarInMonth(month, year);
      final five_star = await reportService.countFiveStarInMonth(month, year);
      
      final bytes = await screenshotController.captureFromWidget(
          MediaQuery(data: const MediaQueryData(), child: PieChartSample2(
            one_star: one_star,
             two_star : two_star,
             three_star : three_star,
             four_star : four_star,
             five_star: five_star,
              sum_star: totalAppointments,
             )));
//PieChartSample2(one_star,two_star,three_star,four_star,five_star);

      widgets.addAll([
        pw.Paragraph(text: 'Total appointments booked: $totalAppointments'),
        pw.Paragraph(text: 'Total absent request: $totalAbsentRequests'),
        pw.Paragraph(
            text: 'Average appointments per user: $averageAppointmentsPerUser'),
        pw.Paragraph(text: 'Busiest day: $busiestDay'),
        pw.Paragraph(text: 'Most booked specialty: $mostBookedSpecialty'),

        pw.Header(
          level: 1,
          child: pw.Text('MONTHLY CUSTOMERS RATING CHART'),
        ),
        pw.Column(
          children: [
            pw.Center(
              child: pw.Container(
                height: 700,
                width: 1080,
                child: pw.Expanded(
                  child: pw.Image(pw.MemoryImage(bytes)),
                ),
              ),
            ),
          ],
        ),
      ]);
    }

    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => widgets));
    return pdf.save();
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    OpenFile.open("${output.path}/$fileName.pdf");
  }

  Future<void> createReport(int fromMonth, int toMonth, int year,
      AdminGenerateReportService adminGenerateReportService) async {
    final data = await createInvoice(
        fromMonth, toMonth, year, adminGenerateReportService);
    savePdfFile("Monthly Report", data);
  }
}









// class PdfInvoiceService {
//   Future<Uint8List> createInvoice(
//       int startMonth, int endMonth, int year) async {
    
//     final pdf = pw.Document();
//     List<pw.Widget> widgets = [];

//     for (int month = startMonth; month <= endMonth; month++) {
//       widgets.add(
//         pw.Header(
//           level: 1,
//           child: pw.Text('Report for $month/$year'),
//         ),
//       );
//       widgets.add(
//         pw.Paragraph(
//           text: 'This is a paragraph',
//         ),
//       );
//       ScreenshotController screenshotController = ScreenshotController();
//     final bytes = await screenshotController.captureFromWidget(
//         MediaQuery(data: const MediaQueryData(), child: PieChartSample2()));
//       widgets.add(
//         pw.Column(
//           children: [
//             pw.Center(
//               child: pw.Container(
//                 height: 700,
//                 width: 1080,
//                 child: pw.Expanded(
//                   child: pw.Image(pw.MemoryImage(bytes)),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     pdf.addPage(pw.MultiPage(
//         pageFormat: PdfPageFormat.a4,
//         margin: const pw.EdgeInsets.all(32),
//         build: (context) => widgets));
//     return pdf.save();
//   }

//   Future<void> savePdfFile(String fileName, Uint8List byteList) async {
//     final output = await getTemporaryDirectory();
//     var filePath = "${output.path}/$fileName.pdf";
//     final file = File(filePath);
//     await file.writeAsBytes(byteList);
//     OpenFile.open("${output.path}/$fileName.pdf");
//     //await OpenDocument.openDocument(filePath: filePath);
//   }

//   Future<void> createReport(int fromMonth, int toMonth, int year) async {
//     final data = await createInvoice(fromMonth, toMonth, year);
//     savePdfFile("Monthly Report", data);
//   }
// }

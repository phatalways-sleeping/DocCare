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
    List<String> monthName = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July ',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    List<String> dayName = [
      'st',
      'nd',
      'rd',
      'th',
    ];

    final pdf = pw.Document();
    ScreenshotController screenshotController = ScreenshotController();

    List<pw.Widget> widgets = [];

    for (int month = startMonth; month <= endMonth; month++) {
      String currentMonthName = "";
      if (month > 0)
        currentMonthName = monthName[month - 1];
      else
        currentMonthName = monthName[0];

      // // Fetch data from Supabase using service functions

      final totalAppointments =
          await reportService.countAppointmentsInMonth(month, year);

      //print('totalAppointments: $totalAppointments');

      final totalAbsentRequests =
          await reportService.countTotalAbsentRequest(month, year);

      //print('totalAbsentRequests: $totalAbsentRequests');

      final totalUser = await reportService.countCustomer();

      //print('Total user: $totalUser');
      final averageAppointmentsPerUser = 1.0 * totalAppointments / totalUser;
      //print('averageAppointmentsPerUser: $averageAppointmentsPerUser');
      final busiestDay = await reportService.busiestDayPerMonth(month, year);

      //print('busiestDay: $busiestDay');

      final mostBookedSpecialty =
          await reportService.mostBookedSpecializationInMonth(month, year);

      //print('mostBookedSpecialty: $mostBookedSpecialty');
      String busiestDayName = "";
      if ((busiestDay % 10) <= 4 && (busiestDay % 10) > 0)
        busiestDayName = busiestDay.toString() + dayName[(busiestDay % 10) - 1];
      else if (busiestDay > 0)
        busiestDayName = busiestDay.toString() + dayName[3];
      else
        busiestDayName = "No data";
      final one_star = await reportService.countOneStarInMonth(month, year);
      final two_star = await reportService.countTwoStarInMonth(month, year);
      final three_star = await reportService.countThreeStarInMonth(month, year);
      final four_star = await reportService.countFourStarInMonth(month, year);
      final five_star = await reportService.countFiveStarInMonth(month, year);
      final totalStar =
          one_star + two_star + three_star + four_star + five_star;
      //print('totalStar: $totalStar');
      Uint8List bytes = Uint8List(0);
      if (totalStar != 0)
        bytes = await screenshotController.captureFromWidget(MediaQuery(
            data: const MediaQueryData(),
            child: PieChartSample2(
              one_star: one_star,
              two_star: two_star,
              three_star: three_star,
              four_star: four_star,
              five_star: five_star,
              sum_star: totalStar,
            )));
//PieChartSample2(one_star,two_star,three_star,four_star,five_star);

      widgets.addAll([
        pw.Row(
          children: [
            pw.Text(
              'DOCCARE',
              style: pw.TextStyle(
                fontSize: 37,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'MONTHLY REPORT',
              style: pw.TextStyle(
                fontSize: 35,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ],
        ),
        pw.Header(
          level: 0,
          textStyle: pw.TextStyle(
            fontSize: 40,
            fontWeight: pw.FontWeight.bold,
          ),
          child: pw.Text(' '),
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Text(
              '$currentMonthName - $year',
              style: pw.TextStyle(
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ],
        ),
        pw.Row(
          children: [
            pw.Text(
              'OVERVIEW:',
              style: pw.TextStyle(
                fontSize: 17,
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Bullet(
          text: 'Total appointments booked: $totalAppointments',
          style: pw.TextStyle(
            fontSize: 14.0,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Bullet(
          text: 'Total absent request: $totalAbsentRequests',
          style: pw.TextStyle(
            fontSize: 14.0,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Bullet(
          text: 'Average appointments per user: ' +
              averageAppointmentsPerUser.toStringAsFixed(2),
          style: pw.TextStyle(
            fontSize: 14.0,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Bullet(
          text: busiestDayName == "No data"
              ? 'Busiest day: ' + busiestDayName
              : 'Busiest day: $currentMonthName, $busiestDayName, $year',
          style: pw.TextStyle(
            fontSize: 14.0,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Bullet(
          text: 'Most booked specialty: $mostBookedSpecialty',
          style: pw.TextStyle(
            fontSize: 14.0,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 30),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Text(
              'MONTHLY CUSTOMERS RATING CHART',
              style: pw.TextStyle(
                fontSize: 17,
              ),
            ),
          ],
        ),
        pw.Column(
          children: [
            pw.Center(
              child: pw.Container(
                height: 400,
                width: 1080,
                child: totalStar != 0
                    ? pw.Expanded(child: pw.Image(pw.MemoryImage(bytes)))
                    : pw.Expanded(child:pw.Column(children: [
                      pw.SizedBox(height: 50),
                        pw.Text(
                          'There is no data to display!',
                          style: pw.TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ]),
                    )
              ),
            ),
            pw.Text(
              '(*)This report aims to provide a comprehensive overview of the performance of the clinic, user engagement, appointment statistics, user feedback, trends, and actionable steps for improvement. Throughout this report, data analysis will be conducted to assess the clinic\'s operational efficiency, patient satisfaction, and areas requiring enhancement, ultimately offering strategic recommendations to elevate overall performance.',
              style: pw.TextStyle(
                fontSize: 10.0,
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

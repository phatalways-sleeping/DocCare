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
import 'dart:io';


class PdfInvoiceService {
  Future<Uint8List> createInvoice(int startMonth, int endMonth, int year) async {
    ScreenshotController screenshotController = ScreenshotController();
    final bytes = await screenshotController.captureFromWidget(MediaQuery(data: const MediaQueryData(), child: PieChartSample2()));
    final pdf = pw.Document();
    
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => <pw.Widget>[
          pw.Header(
            level: 0,
            child: pw.Text('DC Admin Report'),
          ),
          pw.Header(
            level: 1,
            child: pw.Text('Report for $startMonth/$endMonth/$year'),
          ),
          pw.Paragraph(
            text: 'This is a paragraph',
          ),
          pw.Paragraph(
            text: 'This is another paragraph',
          ),
          pw.Header(
            level: 2,
            child: pw.Text('This is a subheading'),
          ),
          pw.Paragraph(
            text: 'This is a paragraph',
          ),
          pw.Paragraph(
            text: 'This is another paragraph',
          ),
          pw.Header(
            level: 2,
            child: pw.Text('This is a subheading'),
          ),
          pw.Paragraph(
            text: 'This is a paragraph',
          ),
          pw.Paragraph(
            text: 'This is another ASDKLASKLDMNASLDASKD',
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
        ],
      )
    );
    return pdf.save();
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    OpenFile.open("${output.path}/$fileName.pdf");
    //await OpenDocument.openDocument(filePath: filePath);
  }
}

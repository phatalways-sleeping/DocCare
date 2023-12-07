import 'package:flutter/material.dart';
import 'package:screens/src/report/invoice_service.dart';

// import 'package:path_provider/path_provider.dart'; // Import this package for file operations
// import 'package:screens/src/report/pdf_page.dart'; // Import the ReportGenerator class

class DCAdminGenerateReportScreen extends StatelessWidget {
  final PdfInvoiceService service = PdfInvoiceService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice Generator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final data = await service.createInvoice(11,11,2023);
                service.savePdfFile("invoice", data);
              },
              child: const Text("Create Invoice"),
            ),
          ],
        ),
      ),
    );
  }

}
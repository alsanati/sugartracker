import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sugar_tracker/app/features/data_export/pdf_service.dart';
import 'package:sugar_tracker/app/utils/constants.dart';

class ExportPage extends StatelessWidget {
  ExportPage({Key? key}) : super(key: key);

  final PdfGenerator pdfGenerator = PdfGenerator(supabase);

  Future<bool> _requestPermission(BuildContext context) async {
    PermissionStatus status = await Permission.storage.status;
    if (!status.isGranted) {
      return true;
    } else {
      // Request the permission
      status = await Permission.storage.request();
      return status.isGranted;
    }
  }

  Future<void> _exportToPdf(BuildContext context) async {
    bool hasPermission = await _requestPermission(context);
    if (!hasPermission) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Permission denied. Unable to export to PDF.')),
        );
      }
      return;
    }

    String pdfFilePath = await pdfGenerator.generateSugarDataTable();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF generated at $pdfFilePath')),
      );
    }
  }

  Future<void> _exportToCsv(BuildContext context) async {
    bool hasPermission = await _requestPermission(context);
    if (!hasPermission) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Permission denied. Unable to export to CSV.')),
        );
      }
      return;
    }

    await pdfGenerator.exportSugarDataToCsv();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('CSV file generated')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Export Data'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Card(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Choose the export format:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Export your sugar data in a format of your choice.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 150),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
              child: const Text(
                'Export Sugar Data to PDF',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () => _exportToPdf(context),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
              child: const Text(
                'Export Sugar Data to CSV',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () => _exportToCsv(context),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

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
        title: Text('Export Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose the export format:',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Export your sugar data in a format of your choice.',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.tertiaryContainer,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Export Sugar Data to PDF',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                onPressed: () => _exportToPdf(context),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.tertiaryContainer,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Export Sugar Data to CSV',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                onPressed: () => _exportToCsv(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

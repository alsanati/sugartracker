import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sugar_tracker/app/utils/utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../models/sugar_data.dart';

class PdfGenerator {
  SupabaseClient supabaseClient;

  PdfGenerator(this.supabaseClient);
  Future<void> exportSugarDataToCsv() async {
    // Fetch sugar data from Supabase
    List<SugarData> sugarDataList = await supabaseClient.patient.getSugarData();

    if (sugarDataList.isEmpty) {
      debugPrint('No sugar data found.');
      return;
    }

    // Prepare the CSV data
    List<List<dynamic>> csvData = [];
    csvData.add(['Date', 'Sugar Level']);

    for (SugarData sugarData in sugarDataList) {
      csvData.add([
        sugarData.createdAt?.toIso8601String() ?? '',
        sugarData.sugarLevel?.toString() ?? '',
      ]);
    }

    // Convert CSV data to a string
    String csvString = const ListToCsvConverter().convert(csvData);

    // Save the CSV data to a file
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File csvFile = File('$documentPath/SugarData.csv');
    await csvFile.writeAsString(csvString);

    debugPrint('Sugar data exported to CSV file: ${csvFile.path}');
  }

  Future<String> generateSugarDataTable() async {
    // Fetch data from Supabase

    List<SugarData> sugarDataList = await supabaseClient.patient.getSugarData();
    var patientData = await supabaseClient.patient.fetchPatientData();
    // Create a new PDF document

    PdfDocument document = PdfDocument();
    // Create a PDF page
    PdfPage page = document.pages.add();

    // Set up the text formatting
    PdfFont headerFont =
        PdfStandardFont(PdfFontFamily.helvetica, 12, style: PdfFontStyle.bold);
    PdfFont dataFont = PdfStandardFont(PdfFontFamily.helvetica, 12);
    const double lineHeight = 20;

    // Add the document creation date
    PdfTextElement dateElement = PdfTextElement(
      text: 'Document Creation Date: ${DateTime.now().toString()}',
      font: dataFont,
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );
    dateElement.draw(
      page: page,
      bounds: const Rect.fromLTWH(50, 50, 500, lineHeight),
    );

    // Add patient data as text
    double currentY = 100;
    String firstName = patientData.firstName ?? '';
    String lastName = patientData.lastName ?? '';
    String birthday = patientData.birthday ?? '';
    String accountId = patientData.accountId?.toString() ?? '';

    PdfTextElement patientText = PdfTextElement(
      text: 'Patient Information',
      font: headerFont,
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );
    patientText.draw(
      page: page,
      bounds: Rect.fromLTWH(50, currentY, 500, lineHeight),
    );
    currentY += lineHeight;

    PdfTextElement firstNameText = PdfTextElement(
      text: 'First Name: $firstName',
      font: dataFont,
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );
    firstNameText.draw(
      page: page,
      bounds: Rect.fromLTWH(50, currentY, 500, lineHeight),
    );
    currentY += lineHeight;

    PdfTextElement lastNameText = PdfTextElement(
      text: 'Last Name: $lastName',
      font: dataFont,
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );
    lastNameText.draw(
      page: page,
      bounds: Rect.fromLTWH(50, currentY, 500, lineHeight),
    );
    currentY += lineHeight;

    PdfTextElement birthdayText = PdfTextElement(
      text: 'Birthday: $birthday',
      font: dataFont,
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );
    birthdayText.draw(
      page: page,
      bounds: Rect.fromLTWH(50, currentY, 500, lineHeight),
    );
    currentY += lineHeight;

    PdfTextElement accountIdText = PdfTextElement(
      text: 'Account ID: $accountId',
      font: dataFont,
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );
    accountIdText.draw(
      page: page,
      bounds: Rect.fromLTWH(50, currentY, 500, lineHeight),
    );
    currentY += lineHeight;

    // Create a PdfGrid class
    PdfGrid grid = PdfGrid();
    grid.columns.add(count: 2);

    // Add the columns to the grid

    // Add header to the grid
    grid.headers.add(1);
    PdfGridRow header = grid.headers[0];

    header.cells[0].value = 'Person ID';
    header.cells[1].value = 'Sugar Level';
    // Add the rows to the grid
    header.cells[0].style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.lightGray,
      textBrush: PdfBrushes.black,
      font: PdfStandardFont(PdfFontFamily.helvetica, 12,
          style: PdfFontStyle.bold),
      cellPadding: PdfPaddings(left: 5),
    );
    header.cells[1].style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.lightGray,
      textBrush: PdfBrushes.black,
      font: PdfStandardFont(PdfFontFamily.helvetica, 12,
          style: PdfFontStyle.bold),
      cellPadding: PdfPaddings(left: 5),
    );

// Add rows to grid and set row styles
    int rowIndex = 0;
    for (SugarData sugarData in sugarDataList) {
      PdfGridRow row = grid.rows.add();
      String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss')
          .format(sugarData.createdAt ?? DateTime.now());
      row.cells[0].value = formattedDate;
      row.cells[1].value = sugarData.sugarLevel?.toString();

      // Set alternating row styles
      PdfGridCellStyle rowStyle = rowIndex % 1 == 0
          ? PdfGridCellStyle(
              backgroundBrush: PdfBrushes.white,
              textBrush: PdfBrushes.black,
              font: PdfStandardFont(PdfFontFamily.helvetica, 12),
              cellPadding: PdfPaddings(left: 5),
            )
          : PdfGridCellStyle(
              backgroundBrush: PdfBrushes.lightYellow,
              textBrush: PdfBrushes.black,
              font: PdfStandardFont(PdfFontFamily.helvetica, 12),
              cellPadding: PdfPaddings(left: 5),
            );

      row.cells[0].style = rowStyle;
      row.cells[1].style = rowStyle;
      rowIndex++;
    }

    // Set the grid style
// Set the grid style

    // Draw the grid
    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));

    // Save the PDF document to a file
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/Output.pdf");
    await file.writeAsBytes(await document.save());

    // Dispose the document
    document.dispose();

    return file.path;
  }
}

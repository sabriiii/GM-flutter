import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gm/components/rapport_component/file_component.dart';
import 'package:gm/components/rapport_component/write_component_component.dart';

class MedicalReportPage extends StatefulWidget {
  const MedicalReportPage({super.key});

  @override
  State<MedicalReportPage> createState() => _MedicalReportPageState();
}

class _MedicalReportPageState extends State<MedicalReportPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController reportController = TextEditingController();
  final TextEditingController patientIdController = TextEditingController();
  final TextEditingController patientNameController = TextEditingController();
  final TextEditingController patientSurnameController =
      TextEditingController();

  final List<Map<String, String>> _selectedFiles = [];
  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    titleController.dispose();
    reportController.dispose();
    patientIdController.dispose();
    patientNameController.dispose();
    patientSurnameController.dispose();
    super.dispose();
  }

  void saveReport() {
    final title = titleController.text;
    final report = reportController.text;
    final patient_name = patientNameController.text;
    final patient_surname = patientSurnameController.text;
    final patient_id = patientIdController.text;

    if (title.isEmpty ||
        report.isEmpty ||
        patient_name.isEmpty ||
        patient_surname.isEmpty ||
        patient_id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Please fill in all fields",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          padding: const EdgeInsets.all(18),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red[300],
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    print("Report Saved:");
    print("Title: $title");
    print("Report: $report");
    print("Patient: $patient_name $patient_surname (ID: $patient_id)");
    if (_selectedFiles.isNotEmpty) {
      print(
          "Attached File: ${_selectedFiles.map((file) => file['name']).toList()}");
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Report saved successfully!",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        padding: const EdgeInsets.all(18),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.teal[300],
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Future<void> generateJsonReport() async {
    final title = titleController.text;
    final report = reportController.text;
    final patient_name = patientNameController.text;
    final patient_surname = patientSurnameController.text;
    final patient_id = patientIdController.text;

    if (title.isEmpty ||
        report.isEmpty ||
        patient_name.isEmpty ||
        patient_surname.isEmpty ||
        patient_id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    final jsonObject = {
      'patient name': patient_name,
      'patient surname': patient_surname,
      'patient id': patient_id,
      'title': title,
      'report': report,

      'files': _selectedFiles, // List of selected files with Base64
    };

    print('Generated JSON Report:');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("JSON Report generated successfully!")),
    );
  }

  void handleFileSelected(List<Map<String, String>> files) async {
    final updatedFiles = await Future.wait(files.map((fileInfo) async {
      final base64String = fileInfo['base64'];
      final fileName = fileInfo['name'];

      return {'name': fileName!, 'base64': base64String!};
    })); // Filter out null entries

    setState(() {
      _selectedFiles.clear();
      _selectedFiles.addAll(updatedFiles.cast<Map<String, String>>());
    });
    log(jsonEncode(_selectedFiles.map((e) {
      return e["name"];
    }).toList()));
    showSnackbar(
      '${files.length} file(s) selected and processed',
    );
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: const Duration(seconds: 2),
        padding: const EdgeInsets.all(18),
        backgroundColor: Colors.teal[300],
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WriteFieldComponent(
                titleController: titleController,
                reportController: reportController,
                patientIdController: patientIdController,
                patientSurnameController: patientSurnameController,
                patientNameController: patientNameController),
            const SizedBox(height: 20),
            ImportDocumentButton(
              onFilesSelected: handleFileSelected,
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: generateJsonReport,
              icon: const Icon(Icons.file_copy),
              label: const Text('Generate JSON Report'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

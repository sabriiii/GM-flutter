import 'package:flutter/material.dart';
import 'package:gm/components/rapport_component/write_component_component.dart';

class MedicalReportPage extends StatefulWidget {
  const MedicalReportPage({super.key});

  @override
  State<MedicalReportPage> createState() => _MedicalReportPageState();
}

class _MedicalReportPageState extends State<MedicalReportPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController reportController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    titleController.dispose();
    reportController.dispose();
    super.dispose();
  }

  void saveReport() {
    // Example: Save the report data
    final title = titleController.text;
    final report = reportController.text;

    if (title.isEmpty || report.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    print("Report Saved:");
    print("Title: $title");
    print("Report: $report");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Report saved successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Write Medical Report"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: saveReport,
          ),
        ],
      ),
      body: WriteFieldComponent(
        titleController: titleController,
        reportController: reportController,
      ),
    );
  }
}

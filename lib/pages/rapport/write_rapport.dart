// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:gm/components/rapport_component/file_component.dart';
// import 'package:gm/components/rapport_component/write_component_component.dart';

// class MedicalReportPage extends StatefulWidget {
//   const MedicalReportPage({super.key});

//   @override
//   State<MedicalReportPage> createState() => _MedicalReportPageState();
// }

// class _MedicalReportPageState extends State<MedicalReportPage> {
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController reportController = TextEditingController();
//   String? _selectedFilePath; // Store the imported file path
//   String? _selectedFileBase64; // Store the Base64-encoded file

//   @override
//   void dispose() {
//     // Dispose controllers to prevent memory leaks
//     titleController.dispose();
//     reportController.dispose();
//     super.dispose();
//   }

//   void saveReport() {
//     final title = titleController.text;
//     final report = reportController.text;

//     if (title.isEmpty || report.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please fill in all fields")),
//       );
//       return;
//     }

//     print("Report Saved:");
//     print("Title: $title");
//     print("Report: $report");
//     if (_selectedFilePath != null) {
//       print("Attached File: $_selectedFilePath");
//     }
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Report saved successfully!")),
//     );
//   }

//   Future<void> generateJsonReport() async {
//     final title = titleController.text;
//     final report = reportController.text;

//     if (title.isEmpty || report.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please fill in all fields")),
//       );
//       return;
//     }

//     String? fileBase64;
//     if (_selectedFilePath != null) {
//       final fileBytes = await File(_selectedFilePath!).readAsBytes();
//       fileBase64 = base64Encode(fileBytes);
//     }

//     final jsonObject = {
//       'title': title,
//       'report': report,
//       'fileBase64': fileBase64,
//     };

//     print('Generated JSON Report:');
//     print(jsonEncode(jsonObject));

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("JSON Report generated successfully!")),
//     );
//   }

//   void handleFilePicked(String? filePath) {
//     setState(() {
//       _selectedFilePath = filePath;
//     });

//     if (filePath != null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('File selected: $filePath')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('No file selected')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Write Medical Report"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.save),
//             onPressed: saveReport,
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             WriteFieldComponent(
//               titleController: titleController,
//               reportController: reportController,
//             ),
//             const SizedBox(height: 20),
//             ImportDocumentButton(),
//             const SizedBox(height: 10),
//             if (_selectedFilePath != null)
//               Text(
//                 'Selected File: $_selectedFilePath',
//                 style: const TextStyle(fontSize: 16),
//               ),
//             const SizedBox(height: 20),
//             ElevatedButton.icon(
//               onPressed: generateJsonReport,
//               icon: const Icon(Icons.file_copy),
//               label: const Text('Generate JSON Report'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.teal,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
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
  String? _selectedFilePath; // Store the imported file path
  String? _selectedFileBase64; // Store the Base64-encoded file

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    titleController.dispose();
    reportController.dispose();
    super.dispose();
  }

  void saveReport() {
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
    if (_selectedFilePath != null) {
      print("Attached File: $_selectedFilePath");
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Report saved successfully!")),
    );
  }

  Future<void> generateJsonReport() async {
    final title = titleController.text;
    final report = reportController.text;

    if (title.isEmpty || report.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    final jsonObject = {
      'title': title,
      'report': report,
      'fileBase64': _selectedFileBase64, // Include Base64-encoded file
    };

    print('Generated JSON Report:');
    print(jsonEncode(jsonObject));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("JSON Report generated successfully!")),
    );
  }

  void handleFileSelected(Map<String, String> fileInfo) async {
    final filePath = fileInfo['path'];

    if (filePath != null) {
      final fileBytes = await File(filePath).readAsBytes();
      final base64String = base64Encode(fileBytes);

      setState(() {
        _selectedFilePath = filePath;
        _selectedFileBase64 = base64String; // Set the Base64 string
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File selected: ${fileInfo['name']}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No file selected')),
      );
    }
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WriteFieldComponent(
              titleController: titleController,
              reportController: reportController,
            ),
            const SizedBox(height: 20),
            ImportDocumentButton(
              onFileSelected:
                  handleFileSelected, // Use the method to handle file selection
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

import 'package:flutter/material.dart';

class WriteFieldComponent extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController reportController;
  final TextEditingController patientNameController;
  final TextEditingController patientSurnameController;
  final TextEditingController patientIdController;

  const WriteFieldComponent({
    super.key,
    required this.titleController,
    required this.reportController,
    required this.patientIdController,
    required this.patientNameController,
    required this.patientSurnameController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Patient Name",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: patientNameController,
            decoration: InputDecoration(
              hintText: "Enter the Patient Name",
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.teal, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              filled: true, // Enables background color
              fillColor: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Patient Surname",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: patientSurnameController,
            decoration: InputDecoration(
              hintText: "Enter the Patient Surname",
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.teal, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Patient ID",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: patientIdController,
            decoration: InputDecoration(
              hintText: "Enter the Patient ID",
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.teal, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Report Title",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: "Enter the report title",
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.teal, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Medical Report",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: reportController,
            maxLines: 15,
            decoration: InputDecoration(
              hintText: "Write the details of the medical report here...",
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.teal, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gm/components/doctor_rdv_component.dart';

void main() {
  runApp(const RDVDoctorPage());
}

class RDVDoctorPage extends StatelessWidget {
  const RDVDoctorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: const Text("Appointments")),
        body: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            DoctorRdvComponent(
              patientName: "Dr. Marcus Horizon",
              date: "26/06/2022",
              time: "10:30 AM",
              patientImageUrl: "https://via.placeholder.com/50",
              onCancel: () => print("Cancel clicked"),
            ),
            DoctorRdvComponent(
              patientName: "Dr. Alysa Hana",
              date: "28/06/2022",
              time: "2:00 PM",
              patientImageUrl: "https://via.placeholder.com/50",
              onCancel: () => print("Cancel clicked"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gm/components/patient_component/patient_rdv.dart';

void main() {
  runApp(const RDVPaientPage());
}

class RDVPaientPage extends StatelessWidget {
  const RDVPaientPage({super.key});

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
            PatientRdvCard(
              doctorName: "Dr. Marcus Horizon",
              specialty: "Cardiologist",
              date: "26/06/2022",
              time: "10:30 AM",
              doctorImageUrl: "https://via.placeholder.com/50",
              onReschedule: () => print("Reschedule clicked"),
              onCancel: () => print("Cancel clicked"),
            ),
            PatientRdvCard(
              doctorName: "Dr. Alysa Hana",
              specialty: "Psychiatrist",
              date: "28/06/2022",
              time: "2:00 PM",
              doctorImageUrl: "https://via.placeholder.com/50",
              onReschedule: () => print("Reschedule clicked"),
              onCancel: () => print("Cancel clicked"),
            ),
          ],
        ),
      ),
    );
  }
}

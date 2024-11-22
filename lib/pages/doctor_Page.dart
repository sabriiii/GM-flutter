import 'package:flutter/material.dart';
import 'package:gm/components/doctor_card_component.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            DoctorCardComponent(
              doctorName: 'Dr. Marcus Horizon',
              specialty: 'Cardiologist',
              profileImageUrl:
                  'https://example.com/profile.jpg', // Replace with actual image URL

              ville: 'Tunis',
            ),
            SizedBox(height: 16),
            DoctorCardComponent(
              doctorName: 'Dr. Sarah Thompson',
              specialty: 'Dermatologist',
              profileImageUrl:
                  'https://example.com/profile2.jpg', // Replace with actual image URL

              ville: 'Ben Arous',
            ),
            // Add more DoctorCardComponent widgets as needed
          ],
        ),
      ),
    );
  }
}

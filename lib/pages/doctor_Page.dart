import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gm/components/doctor_card_component.dart';
import 'package:gm/models/doctor.dart';
import 'package:http/http.dart' as http;

class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  Future<List<Doctor>> fetchDoctors() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:3000/doctor/getdoctors'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final List<dynamic> jsonList = json.decode(response.body);

      return jsonList.map((json) => Doctor.fromJson(json)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Doctor>>(
          future: fetchDoctors(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No doctors found.'));
            }

            final doctors = snapshot.data!;

            return ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                return DoctorCardComponent(
                    doctorName: doctor.name,
                    specialty: doctor.speciality,
                    profileImageUrl: doctor.image_path,
                    ville: doctor.governorate);
              },
            );
          },
        ),
      ),
    );
  }
}

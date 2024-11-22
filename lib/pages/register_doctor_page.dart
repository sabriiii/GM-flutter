// File: lib/pages/RegisterDoctorPage.dart

import 'package:flutter/material.dart';
import 'package:gm/components/register_doctor_component.dart';

class RegisterDoctorPage extends StatelessWidget {
  const RegisterDoctorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register as Doctor'),
        backgroundColor: Colors.blue, // Set your preferred color
      ),
      body: const RegisterDoctorComponent(),
    );
  }
}

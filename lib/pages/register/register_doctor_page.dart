import 'package:flutter/material.dart';
import 'package:gm/components/register_component/register_doctor_component.dart';

class RegisterDoctorPage extends StatelessWidget {
  const RegisterDoctorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: RegisterDoctorComponent(),
    );
  }
}

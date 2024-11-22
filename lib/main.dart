import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gm/pages/help_Page.dart';
import 'package:gm/pages/home_page.dart';
import 'package:gm/pages/main_page.dart';
import 'package:gm/pages/rapport/write_rapport.dart';
import 'package:gm/pages/register_doctor_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Gm());
}

class Gm extends StatelessWidget {
  const Gm({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: IntroPage(),
      //home: HomePage(),
      //home: LoginPage(),
      //home: RegisterPatientPage(),
      //home: DoctorPage(),
      //home: RDVPaientPage(),
      //home: RDVDoctorPage(),
      //home: RegisterDoctorPage(),
      //home: MainPage(),
      //home: HelpPage(),
      home: MedicalReportPage(),
    );
  }
}

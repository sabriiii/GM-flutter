import 'package:flutter/material.dart';
import 'package:gm/pages/login_page.dart';

void main() {
  runApp(const Gm());
}

class Gm extends StatelessWidget {
  const Gm({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: IntroPage(),
      home: LoginPage(),
    );
  }
}

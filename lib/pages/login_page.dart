import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gm/components/login_components/login_components.dart';
import 'package:gm/components/login_components/sign_In_Button.dart';
import 'package:gm/components/login_components/square_tile.dart';
import 'package:gm/pages/intro_page.dart';
import 'package:gm/pages/main_page.dart';
import 'package:gm/pages/register/register_patient_Page.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class LoginPatientPage extends StatefulWidget {
  const LoginPatientPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPatientPage> {
  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //sign in method

  void signUserIn() async {
    if (_validateEmail(usernameController.text) != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid Email"),
          duration: Duration(seconds: 2),
        ),
      );

      return;
    }
    if (passwordController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid Password"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final patientData = {
      'email': usernameController.text,
      'password': passwordController.text
    };

    final jsonData = jsonEncode(patientData);
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/patient/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonData,
    );
    final r = jsonDecode(response.body) as Map<String, dynamic>;
    if (r.containsKey("message")) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(r["message"] ?? ""),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    } else if (r.containsKey("type")) {
      await initLocalStorage();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Welcome " + r["name"]),
          duration: Duration(seconds: 2),
        ),
      );
      if (r["type"] == "patient") {
        localStorage.setItem('patient', jsonEncode(r));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      } else {
        localStorage.setItem('doctor', jsonEncode(r));
        //doctor route
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const IntroPage()),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invalid Credentials"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Logo
              const SizedBox(height: 20),
              Image.asset(
                'lib/images/logo.png',
                height: 250, // Set height for a smaller logo
                width: 250,
              ),
              const SizedBox(height: 20),
              //Welcome back we hope your healyh is good
              Text(
                'Welcome back we hope you\'re healthy!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 25),

              //Username textfield

              MyLoginField(
                controller: usernameController,
                hintText: 'Email',
                obscureText: false,
                icon: Icons.email,
              ),

              const SizedBox(height: 25),

              MyLoginField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
                icon: Icons.logout,
              ),

              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              //sign in button
              SignInButton(
                onTap: signUserIn,
                text: '',
              ),
              const SizedBox(height: 50),

              //or continue with

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              //google+ apple sign in buttons
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //google button
                  SquareTile(imagePath: 'lib/images/google.png'),
                  SizedBox(width: 25),
                  //apple button
                  SquareTile(imagePath: 'lib/images/apple.png'),
                ],
              ),
              const SizedBox(height: 25),
              //not a member

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPatientPage()),
                      );
                    },
                    child: const Text(
                      'Register here',
                      style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

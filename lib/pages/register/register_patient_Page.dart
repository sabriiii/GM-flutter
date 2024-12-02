import 'package:flutter/material.dart';

import 'package:gm/pages/login_page.dart';
import 'dart:convert'; // For JSON encoding
import 'package:http/http.dart' as http;

class RegisterPatientPage extends StatefulWidget {
  const RegisterPatientPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPatientPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final birthDateController = TextEditingController();
  final genderOptions = ['Male', 'Female', 'Other'];
  String? selectedGender;

  DateTime? selectedBirthDate;
  final List<String> governorates = [
    'Ariana',
    'Beja',
    'Ben Arous',
    'Bizerte',
    'Gabes',
    'Gafsa',
    'Jendouba',
    'Kairouan',
    'Kasserine',
    'Kebili',
    'La Manouba',
    'Le Kef',
    'Mahdia',
    'Medenine',
    'Monastir',
    'Nabeul',
    'Sfax',
    'Sidi Bouzid',
    'Siliana',
    'Sousse',
    'Tataouine',
    'Tozeur',
    'Tunis',
    'Zaghouan'
  ];
  String? selectedGovernorate;
  void registerUser() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Create a JSON object with the collected data
      final doctorData = {
        'name': nameController.text,
        'surname': surnameController.text,
        'age': ageController.text,
        'email': emailController.text,
        'gender': selectedGender,
        'birth_date': birthDateController.text,
        'governorate': selectedGovernorate,
        'password': passwordController.text
      };

      // Convert to JSON string
      final jsonData = jsonEncode(doctorData);
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/patient/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonData,
      );
      final r = jsonDecode(response.body) as Map<String, dynamic>;
      if (r['message'] == "success") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Patient registered successfully!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            duration: const Duration(seconds: 2),
            padding: const EdgeInsets.all(18),
            backgroundColor: Colors.teal[300],
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              r["message"] ?? "Server error.",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            padding: EdgeInsets.all(18),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red[300],
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
      // Debug print to see the result
      print('Doctor Data JSON: $jsonData');

      // Show a confirmation dialog or toast
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Doctor registered successfully!'),
      //     duration: Duration(seconds: 2),
      //   ),
      // );
    }
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedBirthDate = picked;
        // Format and set the date in the birth date field
        birthDateController.text =
            '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (RegExp(r'\d').hasMatch(value)) {
      return 'Name cannot contain numbers';
    }
    return null;
  }

  String? _validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }

    return null;
  }

  String? _validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Age must be a number';
    }
    return null;
  }

  String? _validateYearsExperience(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Years of experience must be a number';
    }
    return null;
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
    if (value.length < 8 || value.length > 16) {
      return 'Password must be between 8 and 16 characters';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'\d').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  const SizedBox(height: 20),

                  const SizedBox(height: 20),

                  Text(
                    'Create Patient Profile',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                  ),

                  const SizedBox(height: 60),

                  // Name Field
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your name',
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.teal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.teal, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide:
                            BorderSide(color: Color(0xFFE8F3F1), width: 1),
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.teal,
                      ),
                      filled: true, // Enables background color
                      fillColor: Color(0xFFE8F3F1),
                    ),
                    validator: _validateName,
                  ),

                  const SizedBox(height: 20),

                  // Surname Field
                  TextFormField(
                    controller: surnameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your Surname',
                      labelText: 'Surname',
                      labelStyle: TextStyle(color: Colors.teal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.teal, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide:
                            BorderSide(color: Color(0xFFE8F3F1), width: 1),
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.teal,
                      ),
                      filled: true, // Enables background color
                      fillColor: Color(0xFFE8F3F1),
                    ),
                    validator: _validateName,
                  ),

                  const SizedBox(height: 20),

                  // Age Field
                  TextFormField(
                    controller: ageController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your Age',
                      labelText: 'Age',
                      labelStyle: TextStyle(color: Colors.teal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.teal, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide:
                            BorderSide(color: Color(0xFFE8F3F1), width: 1),
                      ),
                      prefixIcon: Icon(
                        Icons.date_range,
                        color: Colors.teal,
                      ),
                      filled: true, // Enables background color
                      fillColor: Color(0xFFE8F3F1),
                    ),
                    validator: _validateAge,
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(height: 20),

                  // Email Field
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your Email',
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.teal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.teal, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide:
                            BorderSide(color: Color(0xFFE8F3F1), width: 1),
                      ),
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.teal,
                      ),
                      filled: true, // Enables background color
                      fillColor: Color(0xFFE8F3F1),
                    ),
                    validator: _validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 20),

                  // Gender Dropdown Field
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      labelStyle: TextStyle(color: Colors.teal),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFE8F3F1),
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.teal,
                      ),
                      filled: true,
                      fillColor: Color(0xFFE8F3F1),
                    ),
                    value: selectedGender,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue;
                      });
                    },
                    items: genderOptions.map((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    validator: (value) =>
                        value == null ? 'This field is required' : null,
                  ),

                  const SizedBox(height: 20),

                  // Birth Date Picker Field
                  GestureDetector(
                    onTap: () => _selectBirthDate(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: birthDateController,
                        decoration: const InputDecoration(
                          hintText: 'Birth Date',
                          labelText: 'Birth Date',
                          labelStyle: TextStyle(color: Colors.teal),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide:
                                BorderSide(color: Colors.teal, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide:
                                BorderSide(color: Color(0xFFE8F3F1), width: 1),
                          ),
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.teal,
                          ),
                          filled: true,
                          fillColor: Color(0xFFE8F3F1),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'This field is required'
                            : null,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Dropdown for Governorates
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Governorate',
                      labelStyle: TextStyle(color: Colors.teal),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFE8F3F1),
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: Icon(
                        Icons.map,
                        color: Colors.teal,
                      ),
                      filled: true,
                      fillColor: Color(0xFFE8F3F1),
                    ),
                    value: selectedGovernorate,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGovernorate = newValue;
                      });
                    },
                    items: governorates.map((String governorate) {
                      return DropdownMenuItem<String>(
                        value: governorate,
                        child: Text(governorate),
                      );
                    }).toList(),
                    validator: (value) =>
                        value == null ? 'This field is required' : null,
                  ),

                  const SizedBox(height: 20),
                  // Password Field
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your Password',
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.teal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.teal, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide:
                            BorderSide(color: Color(0xFFE8F3F1), width: 1),
                      ),
                      prefixIcon: Icon(
                        Icons.password,
                        color: Colors.teal,
                      ),
                      filled: true, // Enables background color
                      fillColor: Color(0xFFE8F3F1),
                    ),
                    obscureText: true,
                    validator: _validatePassword,
                  ),

                  const SizedBox(height: 20),

                  // Confirm Password Field
                  TextFormField(
                    controller: confirmPasswordController,
                    decoration: const InputDecoration(
                      hintText: 'Confirm your Password',
                      labelText: 'Confirmation',
                      labelStyle: TextStyle(color: Colors.teal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.teal, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide:
                            BorderSide(color: Color(0xFFE8F3F1), width: 1),
                      ),
                      prefixIcon: Icon(
                        Icons.password,
                        color: Colors.teal,
                      ),
                      filled: true, // Enables background color
                      fillColor: Color(0xFFE8F3F1),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  // Register Button
                  ElevatedButton(
                    onPressed: registerUser,
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      backgroundColor: Colors.teal,
                      side: const BorderSide(color: Color(0xFFE8F3F1)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPatientPage()),
                          );
                        },
                        child: const Text(
                          'Login here',
                          style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:gm/components/patient_component/register_patient_components.dart';
import 'package:gm/components/sign_In_Button.dart';

class RegisterPatientPage extends StatefulWidget {
  const RegisterPatientPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPatientPage> {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final birthDateController =
      TextEditingController(); // Controller for birth date
  final genderOptions = ['Male', 'Female', 'Other'];
  String? selectedGender;

  DateTime? selectedBirthDate;

  void registerUser() {}

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Create Your Account',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                      ),
                ),

                const SizedBox(height: 30),

                MyLoginField(
                  controller: nameController,
                  hintText: 'Name',
                  obscureText: false,
                  icon: Icons.person_outline,
                ),
                MyLoginField(
                  controller: surnameController,
                  hintText: 'Surname',
                  obscureText: false,
                  icon: Icons.person_outline,
                ),
                MyLoginField(
                  controller: ageController,
                  hintText: 'Age',
                  obscureText: false,
                  icon: Icons.calendar_today,
                  keyboardType: TextInputType.number,
                ),
                MyLoginField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                MyLoginField(
                  controller: addressController,
                  hintText: 'Address',
                  obscureText: false,
                  icon: Icons.location_on_outlined,
                ),

                GenderDropdown(
                  genderOptions: genderOptions,
                  selectedGender: selectedGender,
                  onChanged: (newValue) {
                    setState(() {
                      selectedGender = newValue;
                    });
                  },
                ),

                // Birth Date Picker Field
                GestureDetector(
                  onTap: () => _selectBirthDate(context),
                  child: AbsorbPointer(
                    child: MyLoginField(
                      controller:
                          birthDateController, // Using the new controller
                      hintText: 'Birth Date',
                      obscureText: false,
                      icon: Icons.calendar_today_outlined,
                    ),
                  ),
                ),

                MyLoginField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  icon: Icons.lock_outline,
                ),
                MyLoginField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                  icon: Icons.lock_outline,
                ),

                const SizedBox(height: 30),
                SignInButton(
                  onTap: registerUser,
                  text: 'Register',
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
                        // Navigate to login
                      },
                      child: const Text(
                        'Login here',
                        style: TextStyle(
                          color: Colors.blueAccent,
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
      ),
    );
  }
}

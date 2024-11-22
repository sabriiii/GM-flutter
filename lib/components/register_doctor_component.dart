// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:convert'; // For JSON encoding

// class RegisterDoctorComponent extends StatefulWidget {
//   const RegisterDoctorComponent({super.key});

//   @override
//   _RegisterDoctorComponentState createState() =>
//       _RegisterDoctorComponentState();
// }

// class _RegisterDoctorComponentState extends State<RegisterDoctorComponent> {
//   final nameController = TextEditingController();
//   final surnameController = TextEditingController();
//   final ageController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   final birthDateController = TextEditingController();
//   final genderOptions = ['Male', 'Female', 'Other'];
//   String? selectedGender;
//   String? selectedGovernorate;
//   DateTime? selectedBirthDate;
//   String? selectedImagePath;

//   final List<String> governorates = [
//     'Ariana',
//     'Beja',
//     'Ben Arous',
//     'Bizerte',
//     'Gabes',
//     'Gafsa',
//     'Jendouba',
//     'Kairouan',
//     'Kasserine',
//     'Kebili',
//     'La Manouba',
//     'Le Kef',
//     'Mahdia',
//     'Medenine',
//     'Monastir',
//     'Nabeul',
//     'Sfax',
//     'Sidi Bouzid',
//     'Siliana',
//     'Sousse',
//     'Tataouine',
//     'Tozeur',
//     'Tunis',
//     'Zaghouan'
//   ];

//   Future<void> pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         selectedImagePath = pickedFile.path;
//       });
//     }
//   }

//   Future<void> _selectBirthDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null) {
//       setState(() {
//         selectedBirthDate = picked;
//         birthDateController.text =
//             '${picked.day}/${picked.month}/${picked.year}';
//       });
//     }
//   }

//   void _registerDoctor() {
//     // Create a JSON object with the collected  data
//     final doctorData = {
//       'name': nameController.text,
//       'surname': surnameController.text,
//       'age': ageController.text,
//       'email': emailController.text,
//       'gender': selectedGender,
//       'birth_date': birthDateController.text,
//       'governorate': selectedGovernorate,
//       'password': passwordController.text,
//       'confirm_password': confirmPasswordController.text,
//       'image_path': selectedImagePath,
//     };

//     // Convert to JSON string
//     final jsonData = jsonEncode(doctorData);

//     // Debug print to see the result
//     print('Doctor Data JSON: $jsonData');

//     // Show a confirmation dialog or toast
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: const Text('Doctor registered successfully!'),
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 20),

//             // Floating Action Button for Image Picker
//             FloatingActionButton(
//               onPressed: pickImage,
//               backgroundColor: Colors.blue,
//               child: const Icon(Icons.camera_alt),
//             ),

//             const SizedBox(height: 20),

//             if (selectedImagePath != null)
//               Text(
//                 'Image selected: $selectedImagePath',
//                 style: const TextStyle(fontSize: 12, color: Colors.grey),
//                 textAlign: TextAlign.center,
//               ),

//             const SizedBox(height: 20),

//             Text(
//               'Create Doctor Account',
//               style: Theme.of(context).textTheme.headlineSmall!.copyWith(
//                     color: Colors.grey[800],
//                     fontWeight: FontWeight.bold,
//                   ),
//             ),
//             const SizedBox(height: 30),

//             MyLoginField(
//               controller: nameController,
//               hintText: 'Name',
//               obscureText: false,
//               icon: Icons.person_outline,
//             ),
//             MyLoginField(
//               controller: surnameController,
//               hintText: 'Surname',
//               obscureText: false,
//               icon: Icons.person_outline,
//             ),
//             MyLoginField(
//               controller: ageController,
//               hintText: 'Age',
//               obscureText: false,
//               icon: Icons.calendar_today,
//               keyboardType: TextInputType.number,
//             ),
//             MyLoginField(
//               controller: emailController,
//               hintText: 'Email',
//               obscureText: false,
//               icon: Icons.email_outlined,
//               keyboardType: TextInputType.emailAddress,
//             ),

//             // Gender Dropdown Field
//             GenderDropdown(
//               genderOptions: genderOptions,
//               selectedGender: selectedGender,
//               onChanged: (newValue) {
//                 setState(() {
//                   selectedGender = newValue;
//                 });
//               },
//             ),

//             // Birth Date Picker Field
//             GestureDetector(
//               onTap: () => _selectBirthDate(context),
//               child: AbsorbPointer(
//                 child: MyLoginField(
//                   controller: birthDateController,
//                   hintText: 'Birth Date',
//                   obscureText: false,
//                   icon: Icons.calendar_today_outlined,
//                 ),
//               ),
//             ),

//             // Dropdown for Governorates
//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(
//                 labelText: 'Governorate',
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey.shade300),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 filled: true,
//                 fillColor: Colors.white,
//               ),
//               value: selectedGovernorate,
//               onChanged: (String? newValue) {
//                 setState(() {
//                   selectedGovernorate = newValue;
//                 });
//               },
//               items: governorates.map((String governorate) {
//                 return DropdownMenuItem<String>(
//                   value: governorate,
//                   child: Text(governorate),
//                 );
//               }).toList(),
//             ),

//             MyLoginField(
//               controller: passwordController,
//               hintText: 'Password',
//               obscureText: true,
//               icon: Icons.lock_outline,
//             ),
//             MyLoginField(
//               controller: confirmPasswordController,
//               hintText: 'Confirm Password',
//               obscureText: true,
//               icon: Icons.lock_outline,
//             ),

//             const SizedBox(height: 30),

//             // Register Button
//             ElevatedButton(
//               onPressed: _registerDoctor,
//               child: const Text('Register'),
//             ),

//             const SizedBox(height: 25),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Already have an account?',
//                   style: TextStyle(color: Colors.grey[700]),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     // Navigate to login
//                   },
//                   child: const Text(
//                     'Login here',
//                     style: TextStyle(
//                       color: Colors.blueAccent,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Reusable Text Field Widget
// class MyLoginField extends StatelessWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final bool obscureText;
//   final IconData icon;
//   final TextInputType? keyboardType;

//   const MyLoginField({
//     super.key,
//     required this.controller,
//     required this.hintText,
//     required this.obscureText,
//     required this.icon,
//     this.keyboardType,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           hintText: hintText,
//           prefixIcon: Icon(icon),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           filled: true,
//           fillColor: Colors.grey[200],
//         ),
//         obscureText: obscureText,
//         keyboardType: keyboardType,
//       ),
//     );
//   }
// }

// // Reusable Gender Dropdown Widget
// class GenderDropdown extends StatelessWidget {
//   final List<String> genderOptions;
//   final String? selectedGender;
//   final ValueChanged<String?> onChanged;

//   const GenderDropdown({
//     super.key,
//     required this.genderOptions,
//     this.selectedGender,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<String>(
//       decoration: InputDecoration(
//         labelText: 'Gender',
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.grey.shade300),
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.grey),
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         filled: true,
//         fillColor: Colors.white,
//       ),
//       value: selectedGender,
//       onChanged: onChanged,
//       items: genderOptions.map((gender) {
//         return DropdownMenuItem(
//           value: gender,
//           child: Text(gender),
//         );
//       }).toList(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert'; // For JSON encoding

class RegisterDoctorComponent extends StatefulWidget {
  const RegisterDoctorComponent({super.key});

  @override
  _RegisterDoctorComponentState createState() =>
      _RegisterDoctorComponentState();
}

class _RegisterDoctorComponentState extends State<RegisterDoctorComponent> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final birthDateController = TextEditingController();

  final genderOptions = ['Male', 'Female', 'Other'];
  String? selectedGender;
  String? selectedGovernorate;
  DateTime? selectedBirthDate;
  String? selectedImagePath;

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

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImagePath = pickedFile.path;
      });
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

  String? _validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Age must be a number';
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

  void _registerDoctor() {
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
        'password': passwordController.text,
        'image_path': selectedImagePath,
      };

      // Convert to JSON string
      final jsonData = jsonEncode(doctorData);

      // Debug print to see the result
      print('Doctor Data JSON: $jsonData');

      // Show a confirmation dialog or toast
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Doctor registered successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Floating Action Button for Image Picker
              FloatingActionButton(
                onPressed: pickImage,
                backgroundColor: Colors.blue,
                child: const Icon(Icons.camera_alt),
              ),

              const SizedBox(height: 20),

              if (selectedImagePath != null)
                Text(
                  'Image selected: $selectedImagePath',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),

              const SizedBox(height: 20),

              Text(
                'Create Doctor Account',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 30),

              // Name Field
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                  labelText: 'Name',
                ),
                validator: _validateName,
              ),

              // Surname Field
              TextFormField(
                controller: surnameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your surname',
                  labelText: 'Surname',
                ),
                validator: _validateName,
              ),

              // Age Field
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(
                  hintText: 'Enter your age',
                  labelText: 'Age',
                ),
                validator: _validateAge,
                keyboardType: TextInputType.number,
              ),

              // Email Field
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  labelText: 'Email',
                ),
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),

              // Gender Dropdown Field
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Gender',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
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

              // Birth Date Picker Field
              GestureDetector(
                onTap: () => _selectBirthDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: birthDateController,
                    decoration: const InputDecoration(
                      hintText: 'Select your birth date',
                      labelText: 'Birth Date',
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'This field is required'
                        : null,
                  ),
                ),
              ),

              // Dropdown for Governorates
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Governorate',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
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

              // Password Field
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: _validatePassword,
              ),

              // Confirm Password Field
              TextFormField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  hintText: 'Confirm your password',
                  labelText: 'Confirm Password',
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
                onPressed: _registerDoctor,
                child: const Text('Register'),
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
    );
  }
}

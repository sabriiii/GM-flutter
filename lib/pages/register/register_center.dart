import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert'; // For JSON encoding
import 'package:http/http.dart' as http;
import 'dart:io';

class RegisterCenterPage extends StatefulWidget {
  const RegisterCenterPage({super.key});

  @override
  RegisterCenterPageState createState() => RegisterCenterPageState();
}

class RegisterCenterPageState extends State<RegisterCenterPage> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  final nameController = TextEditingController();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final descriptionController = TextEditingController();
  final yearsexperienceController = TextEditingController();
  final localisationController = TextEditingController();

  String? selectedGovernorate;

  String? selectedImagePath;
  String? selectedSpeciality;

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

  final List<String> speciality = [
    'Neuroradiology',
    'Cardiothoracic radiology',
    'Nuclear Radiology',
    'MRI',
    'Laborator'
  ];
  Future<String?> encodeImageToBase64(String? imagePath) async {
    try {
      if (imagePath == null) {
        return "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";
      }
      // Read the image file
      final bytes = await File(imagePath).readAsBytes();

      // Encode to Base64
      return base64Encode(bytes);
    } catch (e) {
      throw Exception('Error encoding image to Base64: $e');
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImagePath = pickedFile.path;
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

  String? _validateLinkLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
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

  void _registerCenter() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Create a JSON object with the collected data
      final centerData = {
        'name': nameController.text,
        'email': emailController.text,
        'governorate': selectedGovernorate,
        'password': passwordController.text,
        'image_path': await encodeImageToBase64(selectedImagePath),
        'speciality': selectedSpeciality,
        'description': descriptionController.text,
        'years_of_experience': yearsexperienceController.text,
        'Localisation link': localisationController.text
      };

      // Convert to JSON string
      final jsonData = jsonEncode(centerData);
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/center/register'),
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
              'Center registered successfully!',
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
      print('Center Data JSON: $jsonData');

      // // Show a confirmation dialog or toast
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: const Text(
      //       'Doctor registered successfully!',
      //       style: TextStyle(
      //         color: Colors.white,
      //         fontSize: 16,
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //     duration: const Duration(seconds: 2),
      //     padding: EdgeInsets.all(18),
      //     backgroundColor: Colors.teal[300],
      //     behavior: SnackBarBehavior.floating,
      //     margin: const EdgeInsets.all(16),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(12),
      //     ),
      //   ),
      // );
    }
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

                // Floating Action Button for Image Picker
                FloatingActionButton(
                  onPressed: pickImage,
                  backgroundColor: Colors.teal,
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
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
                  'Create Center Profile',
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
                // Dropdown for Governorates
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Governorate',
                    labelStyle: TextStyle(color: Colors.teal),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE8F3F1)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: const Icon(
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

                TextFormField(
                  controller: localisationController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your Localisation link',
                    labelText: 'Localisation Link',
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
                      Icons.location_on,
                      color: Colors.teal,
                    ),
                    filled: true, // Enables background color
                    fillColor: Color(0xFFE8F3F1),
                  ),
                  validator: _validateLinkLocation,
                ),
                const SizedBox(height: 20),
                // Dropdown for speciality
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Speciality',
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
                      Icons.work,
                      color: Colors.teal,
                    ),
                    filled: true,
                    fillColor: Color(0xFFE8F3F1),
                  ),
                  value: selectedSpeciality,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSpeciality = newValue;
                    });
                  },
                  items: speciality.map((String speciality) {
                    return DropdownMenuItem<String>(
                      value: speciality,
                      child: Text(
                        speciality,
                      ),
                    );
                  }).toList(),
                  validator: (value) =>
                      value == null ? 'This field is required' : null,
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: yearsexperienceController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your Years of experience',
                    labelText: 'years of experience',
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
                    filled: true,
                    fillColor: Color(0xFFE8F3F1),
                  ),
                  validator: _validateYearsExperience,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                // Description Field
                TextFormField(
                  controller: descriptionController,
                  maxLines: 15,
                  decoration: InputDecoration(
                    hintText:
                        "Write the details of the medical experties here...",
                    hintStyle: const TextStyle(
                      color: Colors.teal,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.teal, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: Color(0xFFE8F3F1), width: 1),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFE8F3F1),
                  ),
                  validator: _validateDescription,
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

                const SizedBox(height: 40),

                // Register Button
                ElevatedButton(
                  onPressed: _registerCenter,
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
                        // Navigate to login
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
      ),
    );
  }
}

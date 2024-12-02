class Doctor {
  final String id;
  final String name;
  final String surname;
  final String age;
  final String email;
  final String gender;
  final String birth_date;
  final String governorate;
  final String password;
  final String? image_path;
  final String speciality;
  final String description;
  final String years_of_experience;

  const Doctor({
    required this.id,
    required this.name,
    required this.surname,
    required this.age,
    required this.email,
    required this.gender,
    required this.birth_date,
    required this.governorate,
    required this.password,
    required this.image_path,
    required this.speciality,
    required this.description,
    required this.years_of_experience,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'name': String name,
        'surname': String surname,
        'age': String age,
        'email': String email,
        'gender': String gender,
        'birth_date': String birth_date,
        'governorate': String governorate,
        'password': String password,
        'image_path': String? image_path,
        'speciality': String speciality,
        'description': String description,
        'years_of_experience': String years_of_experience,
      } =>
        Doctor(
          id: id,
          name: name,
          surname: surname,
          age: age,
          email: email,
          gender: gender,
          birth_date: birth_date,
          governorate: governorate,
          password: password,
          image_path: image_path,
          speciality: speciality,
          description: description,
          years_of_experience: years_of_experience,
        ),
      _ => throw const FormatException('Failed to load Doctor.'),
    };
  }
}

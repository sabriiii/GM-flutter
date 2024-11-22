import 'package:flutter/material.dart';

class DoctorCardComponent extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String profileImageUrl;

  final String ville;

  const DoctorCardComponent({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.profileImageUrl,
    required this.ville,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Doctor's Profile Image
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(profileImageUrl),
            ),
            const SizedBox(height: 10),

            // Doctor's Name
            Text(
              doctorName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 4),

            // Specialty
            Text(
              specialty,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),

            // Rating and Distance
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Rating with Icon

                const SizedBox(width: 4),

                const SizedBox(width: 10),

                // Distance with Icon
                Icon(
                  Icons.location_on,
                  color: Colors.grey[500],
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  ville,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

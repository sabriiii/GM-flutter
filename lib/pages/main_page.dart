import 'package:flutter/material.dart';
import 'package:gm/components/main_compnent/search_bar_component.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Add your logic here (e.g., navigate to another page or show a dialog)
  void handleSearchTap() {}
  // Function to handle click events on categories
  void onCategoryTap(String category) {
    // For now, just show a Snackbar with the category name
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Selected: $category")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back navigation
          },
        ),
        title: const Text('Find Doctors'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   decoration: BoxDecoration(
            //     color: Colors.grey[200],
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: const Row(
            //     children: [
            //       Icon(Icons.search, color: Colors.grey),
            //       SizedBox(width: 8),
            //       Expanded(
            //         child: TextField(
            //           decoration: InputDecoration(
            //             hintText: "Find a doctor",
            //             border: InputBorder.none,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SearchBarComponent(
              onTap: handleSearchTap,
            ),

            const SizedBox(height: 20),

            // Category Section
            const Text(
              "Category",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CategoryIcon(
                  icon: Icons.local_hospital,
                  label: "General",
                  onTap: () => onCategoryTap("General"),
                ),
                CategoryIcon(
                  icon: Icons.air,
                  label: "Lungs Specialist",
                  onTap: () => onCategoryTap("Lungs Specialist"),
                ),
                CategoryIcon(
                  icon: Icons.face,
                  label: "Dentist",
                  onTap: () => onCategoryTap("Dentist"),
                ),
                CategoryIcon(
                  icon: Icons.psychology,
                  label: "Psychiatrist",
                  onTap: () => onCategoryTap("Psychiatrist"),
                ),
                CategoryIcon(
                  icon: Icons.coronavirus,
                  label: "Covid-19",
                  onTap: () => onCategoryTap("Covid-19"),
                ),
                CategoryIcon(
                  icon: Icons.health_and_safety,
                  label: "Surgeon",
                  onTap: () => onCategoryTap("Surgeon"),
                ),
                CategoryIcon(
                  icon: Icons.favorite,
                  label: "Cardiologist",
                  onTap: () => onCategoryTap("Cardiologist"),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Recommended Doctors Section
            const Text(
              "Recommended Doctors",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const DoctorCard(
              imageUrl: 'https://example.com/doctor_image.jpg',
              name: "Dr. Marcus Horizon",
              specialty: "Cardiologist",
              rating: 4.7,
              distance: "800m away",
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for category icons
class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const CategoryIcon({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.teal[50],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Colors.teal,
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

// Widget for a single doctor card
class DoctorCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String specialty;
  final double rating;
  final String distance;

  const DoctorCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  specialty,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.location_on, color: Colors.grey[600], size: 16),
                    const SizedBox(width: 4),
                    Text(distance),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

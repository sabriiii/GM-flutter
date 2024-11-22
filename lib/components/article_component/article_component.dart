import 'package:flutter/material.dart';

class ArticleComponent extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String date;
  final String readTime;

  const ArticleComponent({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.readTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Container
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade200,
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Article Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Article Title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                // Date and Read Time
                Row(
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '• $readTime read',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.teal, // Color similar to #199A8E
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Bookmark Icon
          IconButton(
            icon: const Icon(
              Icons.bookmark_border,
              color: Colors.teal, // Color similar to #199A8E
            ),
            onPressed: () {
              // Add bookmark functionality if needed
            },
          ),
        ],
      ),
    );
  }
}

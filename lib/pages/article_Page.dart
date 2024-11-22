import 'package:flutter/material.dart';
import 'package:gm/components/article_component/article_component.dart';

class ArticlePage extends StatefulWidget {
  ArticlePage({super.key});

  final List<Map<String, String>> articles = [
    {
      'imageUrl': 'https://example.com/image1.jpg',
      'title':
          'The 25 Healthiest Fruits You Can Eat, According to a Nutritionist',
      'date': 'Jun 10, 2021',
      'readTime': '5 min',
    },
    {
      'imageUrl': 'https://example.com/image2.jpg',
      'title': 'Traditional Herbal Medicine Treatments for COVID-19',
      'date': 'Jun 9, 2021',
      'readTime': '8 min',
    },
    {
      'imageUrl': 'https://example.com/image3.jpg',
      'title':
          'Beauty Tips For Face: 10 Dos and Don\'ts for Naturally Beautiful Skin',
      'date': 'Jun 9, 2021',
      'readTime': '7 min',
    },
  ];

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles'),
        actions: [
          TextButton(
            onPressed: () {
              // Handle "See all" action
            },
            child: const Text(
              'See all',
              style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.articles.length, // Access articles through `widget`
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final article =
              widget.articles[index]; // Access articles through `widget`
          return ArticleComponent(
            imageUrl: article['imageUrl']!,
            title: article['title']!,
            date: article['date']!,
            readTime: article['readTime']!,
          );
        },
      ),
    );
  }
}

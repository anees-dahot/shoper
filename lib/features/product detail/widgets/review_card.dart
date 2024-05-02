import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String user;
  final String content;
  final int stars;

  const ReviewCard({Key? key, required this.user, required this.content, required this.stars}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text(content),
            const SizedBox(height: 8.0),
            Row(
              children: List.generate(stars, (index) => const Icon(Icons.star, color: Colors.amber)),
            ),
          ],
        ),
      ),
    );
  }
}
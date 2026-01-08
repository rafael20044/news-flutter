import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String author;
  final String title;
  final String description;
  final String urlToImage;
  final String publishedAt;
  final String url;

  const CardWidget({
    super.key,
    required this.author,
    required this.description,
    required this.title,
    required this.urlToImage,
    required this.publishedAt,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: InkWell(
        child: Column(
          children: [
            Image.network(
              urlToImage,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.image_not_supported,
                  size: 80,
                  color: Colors.grey,
                );
              },
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'By ${author.isEmpty ? 'Anonimo' : author}',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 12),
            ),
            Text(description),
            Text(
              '${DateTime.parse(publishedAt).day}/${DateTime.parse(publishedAt).month}/${DateTime.parse(publishedAt).year}',
            ),
          ],
        ),
      ),
    );
  }
}

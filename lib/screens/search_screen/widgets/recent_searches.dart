import 'package:flutter/material.dart';

class RecentSearches extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Your recent searches',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          search('BMW X6 2014 White'),
          const SizedBox(
            height: 10,
          ),
          search('Mercedes Benz SLK Class 2014 Silver'),
        ],
      ),
    );
  }

  Widget search(String title) {
    return Row(
      children: [
        const Icon(Icons.history),
        const SizedBox(
          width: 5,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

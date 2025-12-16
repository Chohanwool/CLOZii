import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Display search results here'),
    );
  }
}

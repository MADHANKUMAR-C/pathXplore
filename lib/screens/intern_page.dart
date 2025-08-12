import 'package:flutter/material.dart';

class InternPage extends StatelessWidget {
  const InternPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Internships')),
      body: const Center(
        child: Text('Internship Opportunities', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

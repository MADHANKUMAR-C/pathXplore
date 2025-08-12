import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  final String title;
  final double progress;
  final Color color;

  const ProgressCard({super.key, 
    required this.title,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            LinearProgressIndicator(
                value: progress,
                color: color,
                backgroundColor: color.withOpacity(0.2)),
            const SizedBox(height: 10),
            Text('${(progress * 100).round()}% Complete',
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

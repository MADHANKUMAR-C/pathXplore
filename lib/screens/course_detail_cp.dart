// lib/screens/course_detail_screen.dart
import 'package:flutter/material.dart';

class CourseDetailScreen extends StatelessWidget {
  final String courseTitle;
  final List<Map<String, dynamic>>
      students; // List of students passed from CoursesScreen

  const CourseDetailScreen({super.key, required this.courseTitle, required this.students, required String courseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseTitle),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          var student = students[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student['name'],
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text("Progress: ${student['progress']}%"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'course_details_page.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Courses'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('courses').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return CourseCard(
                courseId: document.id,
                courseName: data['courseName'] ?? 'Untitled Course',
                description: data['description'] ?? 'No description available',
                duration: data['duration'] ?? 'Duration not specified',
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String courseId;
  final String courseName;
  final String description;
  final String duration;

  const CourseCard({
    super.key,
    required this.courseId,
    required this.courseName,
    required this.description,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(courseName),
        subtitle: Text(description),
        trailing: Chip(
          label: Text(duration),
          backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseDetailsPage(courseId: courseId),
            ),
          );
        },
      ),
    );
  }
}
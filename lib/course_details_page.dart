import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CourseDetailsPage extends StatelessWidget {
  final String courseId;

  const CourseDetailsPage({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Details'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('courses').doc(courseId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Course not found'));
          }

          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['courseName'] ?? 'Untitled Course',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Duration: ${data['duration'] ?? 'Not specified'}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                Text(
                  data['description'] ?? 'No description available',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => _enrollInCourse(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: const Text('Enroll in Course'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _enrollInCourse(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You must be logged in to enroll in a course')),
        );
        return;
      }

      final courseRef = FirebaseFirestore.instance.collection('courses').doc(courseId);
      final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final courseDoc = await transaction.get(courseRef);
        final userDoc = await transaction.get(userRef);

        if (!courseDoc.exists) {
          throw Exception('Course does not exist!');
        }

        List<String> enrolledStudents = List<String>.from(courseDoc.data()?['enrolledStudents'] ?? []);
        if (enrolledStudents.contains(user.uid)) {
          throw Exception('You are already enrolled in this course');
        }

        enrolledStudents.add(user.uid);
        transaction.update(courseRef, {'enrolledStudents': enrolledStudents});

        List<String> enrolledCourses = List<String>.from(userDoc.data()?['enrolledCourses'] ?? []);
        enrolledCourses.add(courseId);
        transaction.update(userRef, {'enrolledCourses': enrolledCourses});
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully enrolled in the course')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error enrolling in the course: $e')),
      );
    }
  }
}
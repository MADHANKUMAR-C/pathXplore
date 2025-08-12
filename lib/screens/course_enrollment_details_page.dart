import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseEnrollmentDetailsPage extends StatelessWidget {
  final String courseId;

  const CourseEnrollmentDetailsPage({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Enrollment Details'),
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

          Map<String, dynamic> courseData = snapshot.data!.data() as Map<String, dynamic>;
          String courseName = courseData['courseName'] ?? 'Untitled Course';
          List<String> enrolledStudents = List<String>.from(courseData['enrolledStudents'] ?? []);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  courseName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: enrolledStudents.isEmpty
                    ? const Center(child: Text('No students enrolled yet'))
                    : ListView.builder(
                        itemCount: enrolledStudents.length,
                        itemBuilder: (context, index) {
                          return FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance.collection('users').doc(enrolledStudents[index]).get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const ListTile(title: CircularProgressIndicator());
                              }
                              if (snapshot.hasError || !snapshot.hasData) {
                                return const ListTile(title: Text('Error loading student data'));
                              }
                              Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;
                              String studentName = userData['name'] ?? 'Unknown Student';
                              String studentEmail = userData['email'] ?? 'No email provided';
                              double progress = (userData['courseProgress'] as Map<String, dynamic>?)?[courseId] ?? 0.0;

                              return ListTile(
                                title: Text(studentName),
                                subtitle: Text(studentEmail),
                                trailing: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    value: progress,
                                    backgroundColor: Colors.grey[200],
                                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
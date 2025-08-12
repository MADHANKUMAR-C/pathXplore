import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../styles/app_text_styles.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Welcome!", style: AppTextStyles.heading),
            const SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (userSnapshot.hasError) {
                  return const Center(child: Text('Error loading user data'));
                }
                int totalUsers = userSnapshot.data?.docs.length ?? 0;

                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('courses').snapshots(),
                  builder: (context, courseSnapshot) {
                    if (courseSnapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (courseSnapshot.hasError) {
                      return const Center(child: Text('Error loading course data'));
                    }
                    int totalCourses = courseSnapshot.data?.docs.length ?? 0;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildDataCard("Total Users", totalUsers.toString(), Icons.group, Colors.blue),
                        _buildDataCard("Total Courses", totalCourses.toString(), Icons.book, Colors.green),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      );
    
  }

  Widget _buildDataCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 3,
      child: Container(
        width: 150,
        height: 120,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 8),
            Text(title, style: AppTextStyles.body),
            Text(value, style: AppTextStyles.subheading.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}
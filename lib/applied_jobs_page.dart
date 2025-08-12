import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppliedJobsPage extends StatelessWidget {
  const AppliedJobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('User not logged in'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Applied Jobs', style: TextStyle(color: Colors.white)), // Set text color to white
        backgroundColor: Theme.of(context).colorScheme.primary, // Use theme primary color for the background
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('appliedJobs')
            .orderBy('appliedAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No applied jobs yet', style: TextStyle(fontSize: 18, color: Colors.black45)));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final job = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners for cards
                ),
                elevation: 6, // Slightly elevated cards
                color: Colors.deepPurple.shade50, // Light purple background for cards
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  leading: const Icon(Icons.work, color: Colors.deepPurpleAccent, size: 30), // Icon for job
                  title: Text(
                    job['jobName'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.deepPurple, // Vibrant color for job title
                    ),
                  ),
                  subtitle: Text(
                    job['company'],
                    style: TextStyle(fontSize: 14, color: Colors.deepPurple[400]), // Lighter purple for company name
                  ),
                  trailing: Text(
                    'Applied: ${(job['appliedAt'] as Timestamp).toDate().toString().split(' ')[0]}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

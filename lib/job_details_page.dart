import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobDetailsPage extends StatelessWidget {
  final String jobId;
  final String jobName;
  final String company;
  final int salary;
  final List<String> skills;
  final String experience;

  const JobDetailsPage({
    super.key,
    required this.jobId,
    required this.jobName,
    required this.company,
    required this.skills,
    required this.salary,
    required this.experience,
  });

  Future<void> _applyForJob(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not logged in')),
        );
        return;
      }

      final jobApplication = {
        'jobId': jobId,
        'jobName': jobName,
        'company': company,
        'skills': skills,
        'experience': experience,
        'appliedAt': FieldValue.serverTimestamp(),
      };

      final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      await userRef.collection('appliedJobs').doc(jobId).set(jobApplication);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Application submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error applying for job: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(jobName),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.purple, Colors.deepPurple],
                  ),
                ),
                child: Center(
                  child: Text(
                    company,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(context, 'Required Skills'),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: skills.map((skill) => Chip(
                      label: Text(skill),
                      backgroundColor: Colors.purple[100],
                    )).toList(),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle(context, 'Experience Needed'),
                  const SizedBox(height: 8),
                  Text(
                    experience,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _applyForJob(context),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      ),
                      child: const Text(
                        'Apply Now',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
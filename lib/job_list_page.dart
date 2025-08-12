import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'job_details_page.dart';

class JobListPage extends StatelessWidget {
  const JobListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HighIncomeJobsSection(),
            RegularJobsSection(),
          ],
        ),
      ),
    );
  }
}

class HighIncomeJobsSection extends StatelessWidget {
  const HighIncomeJobsSection({super.key});

  Future<List<String>> _getUserSkills() async {
    // Get the current user's UID
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      // Fetch user document and get the skills array
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      List<String> skills = List<String>.from(userDoc['skills'] ?? []);
      return skills;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _getUserSkills(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        List<String> userSkills = snapshot.data!;

        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'High Income Jobs (Based on Your Skills)',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('jobs')
                      .where('salary', isGreaterThanOrEqualTo: 40000)
                      .snapshots(),
                  builder: (context, jobSnapshot) {
                    if (jobSnapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    }

                    if (jobSnapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    // Filter jobs based on matching skills
                    final matchingJobs = jobSnapshot.data!.docs.where((doc) {
                      List<String> jobSkills = List<String>.from(doc['skills']);
                      return jobSkills.any((skill) => userSkills.contains(skill));
                    }).toList();

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: matchingJobs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data = matchingJobs[index].data() as Map<String, dynamic>;
                        return HighIncomeJobCard(
                          jobId: matchingJobs[index].id,
                          jobName: data['jobName'],
                          company: data['company'],
                          salary: data['salary'],
                          skills: List<String>.from(data['skills']),
                          experience: data['experience'],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class RegularJobsSection extends StatelessWidget {
  const RegularJobsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All Jobs',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('jobs')
                .orderBy('postedAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  return JobCard(
                    jobId: snapshot.data!.docs[index].id,
                    jobName: data['jobName'],
                    company: data['company'],
                    salary: data['salary'],
                    skills: List<String>.from(data['skills']),
                    experience: data['experience'],
                    postedAt: (data['postedAt'] as Timestamp).toDate(),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class HighIncomeJobCard extends StatelessWidget {
  final String jobId;
  final String jobName;
  final String company;
  final int salary;
  final List<String> skills;
  final String experience;

  const HighIncomeJobCard({
    super.key,
    required this.jobId,
    required this.jobName,
    required this.company,
    required this.salary,
    required this.skills,
    required this.experience,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(right: 16, bottom: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JobDetailsPage(
                jobId: jobId,
                jobName: jobName,
                company: company,
                skills: skills,
                salary: salary,
                experience: experience,
              ),
            ),
          );
        },
        child: Container(
          width: 250,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                jobName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                company,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                'Salary: \$${salary.toString()} per month',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: skills.take(3).map((skill) => Chip(
                  label: Text(skill, style: const TextStyle(fontSize: 10)),
                  backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final String jobId;
  final String jobName;
  final String company;
  final int salary;
  final List<String> skills;
  final String experience;
  final DateTime postedAt;

  const JobCard({
    super.key,
    required this.jobId,
    required this.jobName,
    required this.company,
    required this.salary,
    required this.skills,
    required this.experience,
    required this.postedAt,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JobDetailsPage(
                jobId: jobId,
                jobName: jobName,
                company: company,
                skills: skills,
                salary: salary,
                experience: experience,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                jobName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                company,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Salary: \$${salary.toString()} per month',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: skills.map((skill) => Chip(
                  label: Text(skill),
                  backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostJobPage extends StatefulWidget {
  const PostJobPage({super.key});

  @override
  _PostJobPageState createState() => _PostJobPageState();
}

class _PostJobPageState extends State<PostJobPage> {
  final _formKey = GlobalKey<FormState>();
  final _jobNameController = TextEditingController();
  final _companyController = TextEditingController();
  final _salaryController = TextEditingController();
  final _experienceController = TextEditingController();
  final _skillsController = TextEditingController();

  @override
  void dispose() {
    _jobNameController.dispose();
    _companyController.dispose();
    _salaryController.dispose();
    _experienceController.dispose();
    _skillsController.dispose();
    super.dispose();
  }

  Future<void> _postJob() async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User not logged in')),
          );
          return;
        }

        await FirebaseFirestore.instance.collection('jobs').add({
          'jobName': _jobNameController.text,
          'company': _companyController.text,
          'salary': int.parse(_salaryController.text),
          'experience': _experienceController.text,
          'skills': _skillsController.text.split(',').map((e) => e.trim()).toList(),
          'companyId': user.uid,
          'postedAt': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Job posted successfully')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error posting job: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post a New Job'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _jobNameController,
                decoration: const InputDecoration(labelText: 'Job Title'),
                validator: (value) => value!.isEmpty ? 'Please enter a job title' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _companyController,
                decoration: const InputDecoration(labelText: 'Company Name'),
                validator: (value) => value!.isEmpty ? 'Please enter a company name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _salaryController,
                decoration: const InputDecoration(labelText: 'Salary (per month)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter a salary' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _experienceController,
                decoration: const InputDecoration(labelText: 'Experience Required'),
                validator: (value) => value!.isEmpty ? 'Please enter required experience' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _skillsController,
                decoration: const InputDecoration(labelText: 'Skills Required (comma-separated)'),
                validator: (value) => value!.isEmpty ? 'Please enter required skills' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _postJob,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Post Job'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
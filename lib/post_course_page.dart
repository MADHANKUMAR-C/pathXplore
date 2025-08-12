import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostCoursePage extends StatefulWidget {
  const PostCoursePage({super.key});

  @override
  _PostCoursePageState createState() => _PostCoursePageState();
}

class _PostCoursePageState extends State<PostCoursePage> {
  final _formKey = GlobalKey<FormState>();
  final _courseNameController = TextEditingController();
  final _providerController = TextEditingController();
  final _durationController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _courseNameController.dispose();
    _providerController.dispose();
    _durationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _postCourse() async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User not logged in')),
          );
          return;
        }

        await FirebaseFirestore.instance.collection('courses').add({
          'courseName': _courseNameController.text,
          'provider': _providerController.text,
          'duration': _durationController.text,
          'description': _descriptionController.text,
          'providerId': user.uid,
          'createdAt': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Course posted successfully')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error posting course: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post a New Course'),
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
                controller: _courseNameController,
                decoration: const InputDecoration(labelText: 'Course Name'),
                validator: (value) => value!.isEmpty ? 'Please enter a course name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _providerController,
                decoration: const InputDecoration(labelText: 'Provider Name'),
                validator: (value) => value!.isEmpty ? 'Please enter a provider name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(labelText: 'Course Duration'),
                validator: (value) => value!.isEmpty ? 'Please enter the course duration' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Course Description'),
                validator: (value) => value!.isEmpty ? 'Please enter a course description' : null,
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _postCourse,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Post Course'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
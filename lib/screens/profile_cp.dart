// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Course Provider Profile"),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Information
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(
                  'assets/profile.jpg'), // Placeholder for profile picture
            ),
            SizedBox(height: 16),
            Text("John Doe",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Institution: Tech Institute"),
            SizedBox(height: 8),
            Text(
                "Expertise in Software Development and Teaching with over 10 years of experience."),

            Divider(height: 32),

            // Contact Information
            Text("Contact Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Email: johndoe@example.com"),
            Text("Phone: +123 456 7890"),
            Text("Website: www.johndoe.com"),
            Text("LinkedIn: linkedin.com/in/johndoe"),

            Divider(height: 32),

            // Professional Background
            Text("Professional Background",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Educational Qualifications: M.S. in Computer Science"),
            Text("Certifications: Flutter Certified, React Certified"),
            Text("Areas of Expertise: Flutter, React, Python, Cloud Computing"),

            Divider(height: 32),

            // Course-Related Information
            Text("Courses Offered",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(
                "Flutter for Beginners - A complete guide to Flutter development (Duration: 6 weeks)"),
            Text(
                "Advanced React - Master React with hands-on projects (Duration: 8 weeks)"),
            Text(
                "Python Essentials - A foundational course in Python (Duration: 5 weeks)"),

            Divider(height: 32),

            // Reviews & Ratings
            Text("Reviews & Ratings",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Average Rating: 4.8"),
            Text(
                "Testimonials: Excellent teaching methods and very knowledgeable!"),

            Divider(height: 32),

            // Analytics & Achievements
            Text("Analytics & Achievements",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Total Enrollments: 500"),
            Text("Successful Completions: 450"),
            Text("Certificates Issued: 300"),

            Divider(height: 32),

            // Other Details
            Text("Additional Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Languages Offered: English, Spanish"),
            Text("Preferred Mode of Instruction: Video-based, Interactive"),
            Text("Support Availability: 9 AM - 5 PM, Monday to Friday"),
          ],
        ),
      ),
    );
  }
}

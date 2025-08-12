import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internship_application/company_jobs_page.dart';
import 'package:internship_application/screens/course_provider_home.dart';
import 'home_page.dart';
import 'login_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('users').doc(snapshot.data!.uid).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator.adaptive();
            }
            if (!snapshot.hasData) {
              return const Text('Error: User data not found');
            }
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            final userType = userData['userType'] as String;
            print('User type: $userType');
            switch (userType) {
              case 'user':
                return const MainScreen();
              case 'company':
                return const CompanyJobsPage();
              case 'provider':
                return const CourseProviderHome();
              default:
                return const Text('Error: Invalid user type');
            }
          },
        );
        } else {
          return const LoginPage();
        }
        
      },
    );
  }
}
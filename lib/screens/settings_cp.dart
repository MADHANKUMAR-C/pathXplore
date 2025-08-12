// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import '../styles/app_text_styles.dart';
import 'profilesetting_cp.dart';
import 'contact_details_cp.dart';
import 'social_media_links_cp.dart';
import 'course_management_settings_cp.dart';
import 'default_course_settings_cp.dart';
import 'account_settings_cp.dart';
import 'notifications_cp.dart';
import 'analytics_reports_cp.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Profile Settings Section
        ListTile(
          leading: const Icon(Icons.account_circle),
          title: const Text("Profile Settings", style: AppTextStyles.body),
          subtitle: const Text("Edit profile information, bio, and contact details."),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileSettingsScreen()),
            );
          },
        ),
        // Contact Details
        ListTile(
          leading: const Icon(Icons.email),
          title: const Text("Contact Details", style: AppTextStyles.body),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactDetailsScreen()),
            );
          },
        ),
        // Social Media Links
        ListTile(
          leading: const Icon(Icons.link),
          title: const Text("Social Media Links", style: AppTextStyles.body),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SocialMediaLinksScreen()),
            );
          },
        ),
        const Divider(),

        // Course Management Settings
        ListTile(
          leading: const Icon(Icons.school),
          title: const Text("Course Management Settings", style: AppTextStyles.body),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CourseManagementSettingsScreen()),
            );
          },
        ),
        // Default Course Settings
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text("Default Course Settings", style: AppTextStyles.body),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DefaultCourseSettingsScreen()),
            );
          },
        ),
        const Divider(),

        // Account Settings
        ListTile(
          leading: const Icon(Icons.account_box),
          title: const Text("Account Settings", style: AppTextStyles.body),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AccountSettingsScreen()),
            );
          },
        ),
        const Divider(),

        // Notifications
        ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text("Notifications", style: AppTextStyles.body),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationsScreen()),
            );
          },
        ),
        const Divider(),

        // Analytics and Reports
        ListTile(
          leading: const Icon(Icons.analytics),
          title: const Text("Analytics and Reports", style: AppTextStyles.body),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AnalyticsReportsScreen()),
            );
          },
        ),
      ],
    );
  }
}

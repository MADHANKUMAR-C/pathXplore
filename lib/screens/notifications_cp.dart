// lib/screens/notifications_screen.dart
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle("General Notification Preferences"),
          _buildToggleField("Enable/Disable All Notifications"),
          _buildToggleField("Email Notifications"),
          _buildToggleField("Push Notifications"),
          _buildSectionTitle("Course Enrollment Notifications"),
          _buildToggleField("New Enrollment Alert"),
          _buildToggleField("Enrollment Limit Reached"),
          _buildSectionTitle("Student Interaction Notifications"),
          _buildToggleField("Student Questions or Comments"),
          _buildToggleField("Feedback and Ratings"),
          _buildToggleField("Direct Messages from Students"),
          _buildSectionTitle("Course Completion Notifications"),
          _buildToggleField("Student Course Completion"),
          _buildSectionTitle("Platform Announcements and Updates"),
          _buildToggleField("System Updates"),
          _buildToggleField("Policy Changes"),
          _buildToggleField("Promotional Opportunities"),
          _buildSectionTitle("Payment and Financial Notifications"),
          _buildToggleField("New Payments Received"),
          _buildToggleField("Payout Processed"),
          _buildSectionTitle("Reminder Notifications"),
          _buildToggleField("Upcoming Course Renewal Reminder"),
          _buildToggleField("Review Feedback Prompt"),
          _buildSectionTitle("Notification Frequency Settings"),
          _buildDropdownField("Notification Frequency",
              ["Instantly", "Daily Summary", "Weekly Summary"]),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Save settings logic here
            },
            child: const Text("Save Settings"),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16.0)),
          Switch(value: false, onChanged: (value) {}),
        ],
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> options) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: options
            .map((option) =>
                DropdownMenuItem(value: option, child: Text(option)))
            .toList(),
        onChanged: (value) {},
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
      ),
    );
  }
}

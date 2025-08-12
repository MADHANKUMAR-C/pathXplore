// lib/screens/default_course_settings_screen.dart
import 'package:flutter/material.dart';

class DefaultCourseSettingsScreen extends StatelessWidget {
  final TextEditingController defaultPriceController = TextEditingController();
  final TextEditingController fileSizeLimitController = TextEditingController();

  DefaultCourseSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Default Course Settings")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle("Default Course Settings"),
          _buildDropdownField(
              "Language Preference", ["English", "Spanish", "French"]),
          _buildDropdownField(
              "Category Selection", ["Business", "Technology", "Art"]),
          _buildDropdownField("Format Preference",
              ["Video-based", "Text-based", "Live sessions"]),
          _buildSectionTitle("Course Visibility Settings"),
          _buildToggleField("Public vs. Private"),
          _buildMultiSelectField("Enrollment Restrictions",
              ["Prerequisites", "Skill Level", "Membership Status"]),
          _buildSectionTitle("Course Pricing Options"),
          _buildTextField("Default Price", defaultPriceController),
          _buildToggleField("Enable Discounts/Promo Codes"),
          _buildMultiSelectField("Payment Options",
              ["Single Payment", "Subscription", "Installments"]),
          _buildSectionTitle("Course Content Management"),
          _buildMultiSelectField(
              "Content Upload Preferences", ["PDFs", "Videos", "Quizzes"]),
          _buildTextField("File Size Limit (MB)", fileSizeLimitController),
          _buildToggleField(
              "Content Security (Disable Downloading, Watermark Content)"),
          _buildSectionTitle("Certification and Completion Settings"),
          _buildToggleField("Enable Certification"),
          _buildTextField("Certificate Customization", null),
          _buildTextField("Pass Criteria", null),
          _buildSectionTitle("Student Interaction Options"),
          _buildToggleField("Enable Q&A or Discussion Board"),
          _buildToggleField("Enable Feedback and Ratings"),
          _buildToggleField("Enable Direct Messaging (optional)"),
          _buildSectionTitle("Automated Notifications and Reminders"),
          _buildToggleField("Enrollment Confirmation Emails"),
          _buildToggleField("Completion Reminder"),
          _buildToggleField("Feedback Request Emails"),
          _buildSectionTitle("Analytics and Performance Tracking (optional)"),
          _buildToggleField("Student Progress Tracking"),
          _buildToggleField("View Enrollment Data"),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Save changes logic here
            },
            child: const Text("Save Changes"),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController? controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
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

  Widget _buildMultiSelectField(String label, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        Wrap(
          spacing: 8.0,
          children: options
              .map((option) => ChoiceChip(
                    label: Text(option),
                    selected: false,
                    onSelected: (isSelected) {},
                  ))
              .toList(),
        ),
      ],
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

// lib/screens/contact_details_screen.dart
import 'package:flutter/material.dart';

class ContactDetailsScreen extends StatelessWidget {
  final TextEditingController primaryEmailController = TextEditingController();
  final TextEditingController alternateEmailController =
      TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController alternateNumberController =
      TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController linkedInController = TextEditingController();
  final TextEditingController twitterController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController youtubeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactHoursController = TextEditingController();

  ContactDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact Details")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle("Email Address"),
          _buildTextField("Primary Contact Email", primaryEmailController),
          _buildTextField(
              "Alternate Email (optional)", alternateEmailController),
          _buildSectionTitle("Phone Number"),
          _buildTextField("Contact Number", contactNumberController),
          _buildTextField(
              "Alternate Phone Number (optional)", alternateNumberController),
          _buildSectionTitle("Organization/Company Website"),
          _buildTextField("Website URL", websiteController),
          _buildSectionTitle("Social Media Links"),
          _buildTextField("LinkedIn", linkedInController),
          _buildTextField("Twitter", twitterController),
          _buildTextField("Facebook (optional)", facebookController),
          _buildTextField("Instagram (optional)", instagramController),
          _buildTextField("YouTube (optional)", youtubeController),
          _buildSectionTitle("Location Information"),
          _buildDropdownField("Country", countryController),
          _buildTextField("City/Region", cityController),
          _buildSectionTitle("Office Address (optional)"),
          _buildTextField("Physical Address", addressController),
          _buildSectionTitle("Communication Preferences"),
          _buildPreferredContactMethod(),
          _buildTextField(
              "Available Contact Hours (optional)", contactHoursController),
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

  Widget _buildTextField(String label, TextEditingController controller) {
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

  Widget _buildDropdownField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: [
          "USA",
          "Canada",
          "India",
          "Australia",
          "UK"
        ] // Add other countries as needed
            .map((country) => DropdownMenuItem(
                  value: country,
                  child: Text(country),
                ))
            .toList(),
        onChanged: (value) {
          controller.text = value ?? "";
        },
      ),
    );
  }

  Widget _buildPreferredContactMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text("Preferred Contact Method",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Row(
          children: [
            Expanded(
              child: CheckboxListTile(
                title: const Text("Email"),
                value:
                    true, // Default value, implement actual preference logic here
                onChanged: (value) {},
              ),
            ),
            Expanded(
              child: CheckboxListTile(
                title: const Text("Phone"),
                value:
                    false, // Default value, implement actual preference logic here
                onChanged: (value) {},
              ),
            ),
            Expanded(
              child: CheckboxListTile(
                title: const Text("Social Media"),
                value:
                    false, // Default value, implement actual preference logic here
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
      ),
    );
  }
}

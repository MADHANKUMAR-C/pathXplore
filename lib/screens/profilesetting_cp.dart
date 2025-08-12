// lib/screens/profile_settings_screen.dart
import 'package:flutter/material.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  _ProfileSettingsScreenState createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  // Controllers for text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController organizationController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController linkedInController = TextEditingController();
  final TextEditingController twitterController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController certificationsController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ExpansionTile(
            title: const Text("Basic Information"),
            children: [
              _buildTextField("Name", nameController),
              _buildTextField("Organization Name", organizationController),
              _buildImageUploadSection("Profile Picture"),
              _buildImageUploadSection("Cover Photo"),
            ],
          ),
          ExpansionTile(
            title: const Text("Bio/Description"),
            children: [
              _buildTextArea("Bio", bioController, maxLength: 200),
            ],
          ),
          ExpansionTile(
            title: const Text("Contact Details"),
            children: [
              _buildTextField("Email Address", TextEditingController(),
                  enabled: false),
              _buildTextField("Phone Number", phoneController),
              _buildTextField("Website URL", websiteController),
              _buildTextField("LinkedIn", linkedInController,
                  hint: "Add your LinkedIn profile URL"),
              _buildTextField("Twitter", twitterController,
                  hint: "Add your Twitter profile URL"),
              _buildTextField("Facebook", facebookController,
                  hint: "Add your Facebook profile URL"),
            ],
          ),
          ExpansionTile(
            title: const Text("Location Details"),
            children: [
              _buildTextField("Country", countryController),
              _buildTextField("City/Region", cityController),
            ],
          ),
          ExpansionTile(
            title: const Text("Experience & Credentials"),
            children: [
              _buildTextArea("Educational Background", educationController),
              _buildTextArea("Certifications", certificationsController),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Save changes logic here
            },
            child: const Text("Save Changes"),
          ),
          ElevatedButton(
            onPressed: () {
              // Preview profile logic here
            },
            child: const Text("Preview Profile"),
          ),
          const SizedBox(height: 20),
          _buildProfileTips(),
        ],
      ),
    );
  }

  // Helper widget for text fields
  Widget _buildTextField(String label, TextEditingController controller,
      {String? hint, bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  // Helper widget for text areas with character limit
  Widget _buildTextArea(String label, TextEditingController controller,
      {int maxLength = 500}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        maxLines: 4,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  // Helper widget for image upload section
  Widget _buildImageUploadSection(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.image, size: 40),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  // Logic for image upload
                },
                child: const Text("Upload Image"),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text("Upload a 200x200px image in JPG or PNG format"),
        ],
      ),
    );
  }

  // Helper widget for profile tips
  Widget _buildProfileTips() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Profile Tips",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("• Keep your bio engaging."),
          Text("• Add a profile picture for a personal touch."),
        ],
      ),
    );
  }
}

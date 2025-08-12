// lib/screens/social_media_links_screen.dart
import 'package:flutter/material.dart';

class SocialMediaLinksScreen extends StatelessWidget {
  final TextEditingController linkedInController = TextEditingController();
  final TextEditingController twitterController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController youtubeController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();

  // Additional custom link controllers
  final List<TextEditingController> customLinkControllers = [];
  final List<TextEditingController> customLabelControllers = [];

  SocialMediaLinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Social Media Links")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle("LinkedIn Profile"),
          _buildTextField("LinkedIn URL", linkedInController),
          _buildSectionTitle("Twitter Handle"),
          _buildTextField("Twitter URL", twitterController),
          _buildSectionTitle("Facebook Page"),
          _buildTextField("Facebook Page URL", facebookController),
          _buildSectionTitle("Instagram Profile (optional)"),
          _buildTextField("Instagram URL", instagramController),
          _buildSectionTitle("YouTube Channel"),
          _buildTextField("YouTube Channel URL", youtubeController),
          _buildSectionTitle("Personal Website or Blog (optional)"),
          _buildTextField("Website URL", websiteController),
          _buildSectionTitle("Other Social Media Platforms (optional)"),
          _buildCustomLinksSection(),
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

  Widget _buildCustomLinksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < customLinkControllers.length; i++)
          Column(
            children: [
              _buildTextField("Custom Link Label", customLabelControllers[i]),
              _buildTextField("Custom Link URL", customLinkControllers[i]),
              const SizedBox(height: 10),
            ],
          ),
        TextButton.icon(
          onPressed: () {
            customLabelControllers.add(TextEditingController());
            customLinkControllers.add(TextEditingController());
          },
          icon: const Icon(Icons.add),
          label: const Text("Add Additional Link"),
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

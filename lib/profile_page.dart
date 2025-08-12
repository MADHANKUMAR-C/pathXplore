import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _userType = '';
  String _mobile = '';
  String _age = '';
  String _experience = '';
  List<String> _skills = [];
  String _companyName = '';
  String _companyLocation = '';
  String _companyYear = '';
  String _companyType = '';
  bool _isLoading = false;
  bool _isEditing = false; // Flag to check if we are in edit mode

  // Method to get user data
  Future<Map<String, dynamic>?> _getUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      return userDoc.data() as Map<String, dynamic>?;
    }
    return null;
  }

  // Method to update profile
  Future<void> _updateProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        Map<String, dynamic> updatedData = {};
        if (_userType == 'user') {
          updatedData = {
            'name': _name,
            'mobile': _mobile,
            'age': _age,
            'experience': _experience,
            'skills': _skills,  // Store skills as a list
          };
        } else if (_userType == 'company') {
          updatedData = {
            'companyName': _companyName,
            'companyLocation': _companyLocation,
            'companyYear': _companyYear,
            'companyType': _companyType,
          };
        }
        // Update Firestore document
        await FirebaseFirestore.instance.collection('users').doc(uid).update(updatedData);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated successfully')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating profile: $e')));
    }

    setState(() {
      _isLoading = false;
      _isEditing = false; // Exit edit mode
    });
  }

  // Method to handle logout
  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logout success')),
      );
    }
  }

  // Method to select skills
  Future<void> _selectSkills() async {
    List<String> predefinedSkills = ['Flutter', 'Dart', 'Java', 'Python', 'SQL', 'JavaScript']; // Example skills
    List<String> selectedSkills = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          title: const Text('Select Skills'),
          items: predefinedSkills.map((skill) {
            return MultiSelectDialogItem<String>(skill, skill);
          }).toList(),
          initialSelectedItems: _skills,
        );
      },
    ) ?? [];

    setState(() {
      _skills = selectedSkills;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>( 
      future: _getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Center(child: Text('Could not load profile information'));
        }

        Map<String, dynamic> userData = snapshot.data!;

        // Get user type and populate fields
        _userType = userData['userType'] ?? '';
        _name = userData['name'] ?? '';
        _email = userData['email'] ?? '';
        if (_userType == 'user') {
          _mobile = userData['mobile'] ?? '';
          _age = userData['age'] ?? '';
          _experience = userData['experience'] ?? '';
          _skills = List<String>.from(userData['skills'] ?? []);  // Initialize skills as a list
        } else if (_userType == 'company') {
          _companyName = userData['companyName'] ?? '';
          _companyLocation = userData['companyLocation'] ?? '';
          _companyYear = userData['companyYear'] ?? '';
          _companyType = userData['companyType'] ?? '';
        }
        else if(_userType=='provider'){
          
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            backgroundColor: Colors.green.shade800,
            actions: [
              IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () => _logout(context),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email: $_email', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),

                // Display user profile fields
                if (_userType == 'user') ...[
                  Text('Name: $_name', style: const TextStyle(fontSize: 18)),
                  Text('Mobile: $_mobile', style: const TextStyle(fontSize: 18)),
                  Text('Age: $_age', style: const TextStyle(fontSize: 18)),
                  Text('Experience: $_experience', style: const TextStyle(fontSize: 18)),
                  Text('Skills: ${_skills.join(', ')}', style: const TextStyle(fontSize: 18)),
                ],

                // Display company profile fields
                if (_userType == 'company') ...[
                  Text('Company Name: $_companyName', style: const TextStyle(fontSize: 18)),
                  Text('Location: $_companyLocation', style: const TextStyle(fontSize: 18)),
                  Text('Year of Starting: $_companyYear', style: const TextStyle(fontSize: 18)),
                  Text('Company Type: $_companyType', style: const TextStyle(fontSize: 18)),
                ],

                const SizedBox(height: 20),

                // Update Profile Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = true; // Enter editing mode when button is clicked
                      });
                    },
                    child: const Text('Update Profile', style: TextStyle(fontSize: 16)),
                  ),
                ),

                const SizedBox(height: 20),

                // If in editing mode, show form fields to update profile
                if (_isEditing) ...[
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_userType == 'user') ...[
                          TextFormField(
                            initialValue: _name,
                            decoration: const InputDecoration(labelText: 'Name'),
                            onChanged: (value) => _name = value,
                          ),
                          TextFormField(
                            initialValue: _mobile,
                            decoration: const InputDecoration(labelText: 'Mobile Number'),
                            keyboardType: TextInputType.phone,
                            onChanged: (value) => _mobile = value,
                          ),
                          TextFormField(
                            initialValue: _age,
                            decoration: const InputDecoration(labelText: 'Age'),
                            keyboardType: TextInputType.number,
                            onChanged: (value) => _age = value,
                          ),
                          TextFormField(
                            initialValue: _experience,
                            decoration: const InputDecoration(labelText: 'Experience'),
                            onChanged: (value) => _experience = value,
                          ),

                          // Button to select skills
                          ElevatedButton(
                            onPressed: _selectSkills,
                            child: Text('Select Skills (${_skills.length})'),
                          ),
                        ],

                        if (_userType == 'company') ...[
                          TextFormField(
                            initialValue: _companyName,
                            decoration: const InputDecoration(labelText: 'Company Name'),
                            onChanged: (value) => _companyName = value,
                          ),
                          TextFormField(
                            initialValue: _companyLocation,
                            decoration: const InputDecoration(labelText: 'Location'),
                            onChanged: (value) => _companyLocation = value,
                          ),
                          TextFormField(
                            initialValue: _companyYear,
                            decoration: const InputDecoration(labelText: 'Year of Starting'),
                            keyboardType: TextInputType.number,
                            onChanged: (value) => _companyYear = value,
                          ),
                          TextFormField(
                            initialValue: _companyType,
                            decoration: const InputDecoration(labelText: 'Company Type'),
                            onChanged: (value) => _companyType = value,
                          ),
                        ],

                        const SizedBox(height: 20),

                        // Submit Button to save changes
                        Center(
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _updateProfile,
                            child: _isLoading
                                ? const CircularProgressIndicator()
                                : const Text('Save Changes'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

// MultiSelectDialog widget
class MultiSelectDialog extends StatefulWidget {
  final List<MultiSelectDialogItem<String>> items;
  final List<String> initialSelectedItems;
  final Widget title;

  const MultiSelectDialog({
    super.key,
    required this.items,
    required this.initialSelectedItems,
    required this.title,
  });

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  late List<String> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.initialSelectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.title,
      content: SingleChildScrollView(
        child: Column(
          children: widget.items.map((item) {
            return CheckboxListTile(
              title: Text(item.label),
              value: _selectedItems.contains(item.value),
              onChanged: (bool? selected) {
                setState(() {
                  if (selected == true) {
                    _selectedItems.add(item.value);
                  } else {
                    _selectedItems.remove(item.value);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, _selectedItems);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class MultiSelectDialogItem<T> {
  final T value;
  final String label;

  MultiSelectDialogItem(this.value, this.label);
}

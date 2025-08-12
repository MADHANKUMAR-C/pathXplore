import 'package:flutter/material.dart';
import 'auth_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _name = '';
  String _userType = 'user';
  String? _error;
  bool _isLoading = false;
  final List<String> _skills = [];
  final List<String> _selectedSkills = [];

  final List<String> predefinedSkills = [
    'Flutter',
    'Dart',
    'JavaScript',
    'Python',
    'Java',
    'HTML',
    'CSS',
    'C++',
    'SQL',
    'Node.js',
  ];

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      // Send skills along with other user details if userType is 'user'
      String? result = await _auth.signUp(
        email: _email,
        password: _password,
        name: _name,
        userType: _userType,
        skills: _userType == 'user' ? _selectedSkills : [],
      );

      setState(() {
        _isLoading = false;
      });

      if (result != null) {
        setState(() {
          _error = result;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully')),
        );
        Navigator.pop(context);
      }
    }
  }

  void _toggleSkillSelection(String skill) {
    setState(() {
      if (_selectedSkills.contains(skill)) {
        _selectedSkills.remove(skill);
      } else {
        _selectedSkills.add(skill);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.purple[700]!, Colors.purple[300]!],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Create an Account',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              prefixIcon: const Icon(Icons.person, color: Colors.purple),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Enter your full name' : null,
                            onChanged: (value) => _name = value.trim(),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: const Icon(Icons.email, color: Colors.purple),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Enter an email' : null,
                            onChanged: (value) => _email = value.trim(),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock, color: Colors.purple),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            obscureText: true,
                            validator: (value) =>
                                value!.isEmpty ? 'Enter a password' : null,
                            onChanged: (value) => _password = value.trim(),
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Account Type',
                              prefixIcon: const Icon(Icons.category, color: Colors.purple),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            value: _userType,
                            items: const [
                              DropdownMenuItem(value: 'user', child: Text('Job Seeker')),
                              DropdownMenuItem(value: 'company', child: Text('Company')),
                              DropdownMenuItem(value: 'provider', child: Text('Course Provider')),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _userType = value!;
                                // Reset selected skills if the userType changes
                                _selectedSkills.clear();
                              });
                            },
                          ),
                          const SizedBox(height: 24),
                          // Show skill selection only if userType is 'user'
                          if (_userType == 'user') ...[
                            const Text(
                              'Select your skills:',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            Column(
                              children: predefinedSkills.map((skill) {
                                return CheckboxListTile(
                                  title: Text(skill),
                                  value: _selectedSkills.contains(skill),
                                  onChanged: (bool? selected) {
                                    if (selected != null) {
                                      _toggleSkillSelection(skill);
                                    }
                                  },
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 24),
                          ],
                          if (_error != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Text(
                                _error!,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ElevatedButton(
                            onPressed: _isLoading ? null : _submit,
                            child: _isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text(
                                    'Sign Up',
                                    style: TextStyle(fontSize: 18),
                                  ),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Already have an account? Login',
                              style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

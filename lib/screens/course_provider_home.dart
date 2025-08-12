// lib/screens/course_provider_home.dart
import 'package:flutter/material.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import 'courseScreen.dart'; // Importing the CoursesScreen file
import 'search_cp.dart';
import 'settings_cp.dart';
import 'addcourse_cp.dart';
import 'dashbord_cp.dart';
import 'profile_cp.dart'; // Importing the ProfileScreen

class CourseProviderHome extends StatefulWidget {
  const CourseProviderHome({super.key});

  @override
  _CourseProviderHomeState createState() => _CourseProviderHomeState();
}

class _CourseProviderHomeState extends State<CourseProviderHome> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const CourseProviderPage(), // Adding CoursesScreen for navigation
    const SearchScreen(),
    const AddCourseScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'pathXplore',
          style: AppTextStyles.heading,
        ),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Navigate to the ProfileScreen when the icon is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Add Course',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

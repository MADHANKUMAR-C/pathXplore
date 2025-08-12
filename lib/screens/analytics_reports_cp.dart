// lib/screens/analytics_reports_screen.dart
import 'package:flutter/material.dart';

class AnalyticsReportsScreen extends StatelessWidget {
  const AnalyticsReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Analytics and Reports")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Overview Dashboard Section
          _buildSectionTitle("Overview Dashboard"),
          _buildMetricCard("Total Enrollments", "1,200"),
          _buildMetricCard("Total Course Views", "15,000"),
          _buildMetricCard("Average Rating", "4.5 / 5"),
          _buildMetricCard("Revenue Summary", "\$20,000"),

          // Course Performance Metrics Section
          _buildSectionTitle("Course Performance Metrics"),
          _buildCoursePerformanceTable(),

          // Student Engagement Insights Section
          _buildSectionTitle("Student Engagement Insights"),
          _buildEngagementInsights(),

          // Ratings and Feedback Analysis Section
          _buildSectionTitle("Ratings and Feedback Analysis"),
          _buildRatingsDistribution(),

          // Revenue and Earnings Insights Section
          _buildSectionTitle("Revenue and Earnings Insights"),
          _buildRevenueInsights(),

          // Course Improvement Suggestions Section
          _buildSectionTitle("Course Improvement Suggestions"),
          _buildSuggestionsList(),

          // Demographic Insights Section
          _buildSectionTitle("Demographic Insights"),
          _buildDemographics(),

          // Engagement and Retention Trends Section
          _buildSectionTitle("Engagement and Retention Trends"),
          _buildEngagementRetention(),

          // Downloadable Reports Section
          _buildSectionTitle("Downloadable Reports"),
          _buildDownloadReportButton(),

          // Save and Customize Analytics Preferences Section
          _buildSectionTitle("Save and Customize Preferences"),
          _buildCustomizeDashboardButton(),
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
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 16.0)),
            Text(value,
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildCoursePerformanceTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Course')),
        DataColumn(label: Text('Enrollments')),
        DataColumn(label: Text('Views')),
        DataColumn(label: Text('Rating')),
        DataColumn(label: Text('Completion Rate')),
      ],
      rows: const [
        DataRow(cells: [
          DataCell(Text('Course A')),
          DataCell(Text('250')),
          DataCell(Text('3,000')),
          DataCell(Text('4.7')),
          DataCell(Text('85%')),
        ]),
        DataRow(cells: [
          DataCell(Text('Course B')),
          DataCell(Text('350')),
          DataCell(Text('4,200')),
          DataCell(Text('4.5')),
          DataCell(Text('90%')),
        ]),
        // More rows can be added here
      ],
    );
  }

  Widget _buildEngagementInsights() {
    return const Column(
      children: [
        Text('Session Duration: 45 minutes (Avg)'),
        Text('Student Drop-Off Points: 60% drop-off after module 3'),
        // Can add additional engagement-related metrics here
      ],
    );
  }

  Widget _buildRatingsDistribution() {
    return const Column(
      children: [
        ListTile(title: Text('5 Stars: 50%')),
        ListTile(title: Text('4 Stars: 30%')),
        ListTile(title: Text('3 Stars: 15%')),
        ListTile(title: Text('2 Stars: 5%')),
        // Can add more rating breakdown here
      ],
    );
  }

  Widget _buildRevenueInsights() {
    return const Column(
      children: [
        ListTile(title: Text('Earnings Breakdown by Course')),
        ListTile(title: Text('Course A: \$5,000')),
        ListTile(title: Text('Course B: \$8,000')),
        // More revenue breakdown can be added
      ],
    );
  }

  Widget _buildSuggestionsList() {
    return const Column(
      children: [
        ListTile(title: Text('Suggestion: Offer advanced courses in Business')),
        ListTile(title: Text('Suggestion: Update content for Course B')),
        // More suggestions can be added here
      ],
    );
  }

  Widget _buildDemographics() {
    return const Column(
      children: [
        ListTile(title: Text('Age: 18-24 (60%)')),
        ListTile(title: Text('Location: USA (50%)')),
        ListTile(title: Text('Profession: Students (40%)')),
        // More demographic data can be added
      ],
    );
  }

  Widget _buildEngagementRetention() {
    return const Column(
      children: [
        ListTile(title: Text('New Students: 60%')),
        ListTile(title: Text('Returning Students: 40%')),
        // More engagement and retention metrics can be added
      ],
    );
  }

  Widget _buildDownloadReportButton() {
    return ElevatedButton(
      onPressed: () {
        // Logic for exporting reports
      },
      child: const Text("Download Report"),
    );
  }

  Widget _buildCustomizeDashboardButton() {
    return ElevatedButton(
      onPressed: () {
        // Logic for customizing dashboard view
      },
      child: const Text("Customize Dashboard"),
    );
  }
}

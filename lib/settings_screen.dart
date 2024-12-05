import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Determine the AppBar text color based on the theme
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final appBarTextColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 22.0,
            color: appBarTextColor, // Dynamically set text color
          ),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Currency'),
              trailing: Text('USD'),
            ),
            ListTile(
              title: Text('Backup Data'),
              trailing: Icon(Icons.cloud_upload),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle settings actions
              },
              child: Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

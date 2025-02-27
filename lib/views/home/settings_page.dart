import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 16),
            decoration: const BoxDecoration(
              color: Color(0xFFD76D2C),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                // Title
                Text(
                  'Settings',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                // User Avatar
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/user_avatar.png"), // Add your avatar image in assets
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Settings Options
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: ListView(
                children: [
                  SwitchListTile(
                    title: Text(
                      "Enable Notifications",
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    value: _notificationsEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text(
                      "Enable Dark Mode",
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    value: _darkModeEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        _darkModeEnabled = value;
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.lock),
                    title: Text(
                      "Change Password",
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    onTap: () {
                      // Navigate to change password page
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.language),
                    title: Text(
                      "Language",
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    onTap: () {
                      // Navigate to language settings page
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text(
                      "About",
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    onTap: () {
                      // Navigate to about page
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
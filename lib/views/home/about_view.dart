
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  
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
                    // Navigator.pop(context);
                  },
                ),

                // Title
                Text(
                  'About Us',
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


          // Chapter Section
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome to Mirathi Tanzania", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16,color: Color(0xFFD76D2C))),
                    const SizedBox(height: 10),
                    Text(
                      "Your trusted guide to inheritance matters in Tanzania. This app is designed to provide clear and reliable information on inheritance laws, helping individuals and families navigate estate planning, succession, and legal procedures with ease.\n\n"
                      "Whether you are planning for the future or handling an inheritance case, Mirathi Tanzania offers valuable insights and resources tailored to the Tanzanian legal framework.\n\n"
                      "Please note that the content within this app is for informational purposes only and should not be considered legal advice."
                      ,style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[800]),
                    ),
                    const SizedBox(height: 20),
                    Text("Additionally", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16,color: Color(0xFFD76D2C))),
                    const SizedBox(height: 10),
                    Text(
                      "This book and all its contents are protected—users are strictly prohibited from taking screenshots, recording videos, or selling the materials without prior consent.\n\n"
                      "Unauthorized distribution or reproduction may result in legal action."
                      ,style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[800]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
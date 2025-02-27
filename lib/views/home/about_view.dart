
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
                    Text("Chapter 1:", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam ac felis id elit consequat tincidunt. Nulla facilisi. Duis nec purus quis purus vehicula fringilla ut vel purus. Vestibulum varius, quam at efficitur venenatis, felis lectus tincidunt eros, sed tristique odio lectus vel nisi.\n\n"
                      "Donec eget risus et sem ullamcorper consectetur. Etiam tincidunt auctor mi, sed gravida magna ullamcorper sit amet. Vivamus nec erat eu nisi condimentum malesuada. Vestibulum aliquet enim ut magna elementum, id gravida justo vestibulum. Fusce in nisl nec libero gravida volutpat.\n\n"
                      "Suspendisse id cursus metus. Nam interdum, purus nec faucibus vehicula, turpis justo rhoncus nulla, sit amet suscipit orci risus nec orci. Duis facilisis justo et convallis interdum.\n\n"
                      "Fusce consectetur diam felis, non accumsan nunc posuere a. Integer porta euismod diam, et tincidunt orci pharetra eu. Integer non erat eget odio euismod ultrices.\n\n"
                      "Integer nec felis libero. Phasellus varius, erat in rhoncus sodales, ligula libero luctus sem, ac rhoncus quam turpis a nunc. Sed a mi id turpis interdum efficitur. Vestibulum et quam nulla.",
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[800]),
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
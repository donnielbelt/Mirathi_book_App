import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:mirathi_book_app/views/home/edit_profile.dart';


class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          // Header Section
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 16),
                decoration: const BoxDecoration(
                  color: Color(0xFFD76D2C),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                    bottomRight: Radius.circular(70),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back Button
                    // IconButton(
                    //   icon: const Icon(Icons.arrow_back, color: Colors.white),
                    //   onPressed: () {
                    //     Navigator.pop(context);
                    //   },
                    // ),

                    // Title
                    Padding(
                      padding: const EdgeInsets.only(top: 2, left: 16, right: 16, bottom: 80),
                      child: Text(
                        'Profile',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // User Avatar
                    // const CircleAvatar(
                    //   backgroundImage: AssetImage("assets/user_avatar.png"), // Add your avatar image in assets
                    // ),
                  ],
                ),
              ),
              Positioned(
                bottom: -70, // Adjust this value to control how much the image is out of the container
                left: 0,
                right: 0,
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 150, // Adjust the size of the image container
                        height: 150,
                        decoration: BoxDecoration(
                          color: Color(0xff73544C),
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            "assets/user_avatar.png", // Add your avatar image in assets
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () async {
                            // final ImagePicker _picker = ImagePicker();
                            // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                            // if (image != null) {
                            //   // Handle the selected image
                            // }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Color(0xff73544C),
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 100), // Adjust this value to provide space for the image

          // Profile Details Section
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditProfilePage()),
                        );
                      },
                      child: Text("Edit Profile",style: TextStyle(fontSize: 14),),
                    ),
                    const SizedBox(height: 20),
                    Text("Name:", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    Text(
                      "User Name",
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[800]),
                    ),
                    const SizedBox(height: 20),

                    Text("Email:", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    Text(
                      "Username@example.com",
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[800]),
                    ),
                    const SizedBox(height: 20),

                    Text("Bio:", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam ac felis id elit consequat tincidunt. Nulla facilisi. Duis nec purus quis purus vehicula fringilla ut vel purus. Vestibulum varius, quam at efficitur venenatis, felis lectus tincidunt eros, sed tristique odio lectus vel nisi.",
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[800]),
                    ),
                    const SizedBox(height: 20),

                    Text("Interests:", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    Text(
                      "Reading, Traveling, Coding",
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
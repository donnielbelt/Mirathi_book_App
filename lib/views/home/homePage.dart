import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mirathi_book_app/views/auth/login.dart';
import 'package:mirathi_book_app/views/home/book_view.dart';
import 'package:mirathi_book_app/views/home/settings_page.dart';
import 'package:mirathi_book_app/views/home/share_page.dart';
import 'package:mirathi_book_app/views/home/terms_and_conditions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: const Color(0xFFD76D2C),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Text(
          "MIRATHI TANZANIA",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/user_avatar.png"), // Add an avatar image in assets
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.transparent,
        elevation: 100000,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.45,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color(0xFFD76D2C).withOpacity(0.7),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/user_avatar.png"), // Add your avatar image in assets
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'John Doe',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'john.doe@example.com',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
                  color: Colors.white.withOpacity(0.8),
                ),
                height: MediaQuery.of(context).size.height * 0.45,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Home'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.info),
                      title: Text('About'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.description),
                      title: Text('Terms & Conditions'),
                      onTap: () {
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => TermsPage()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                      onTap: () {
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => SettingsPage()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.share),
                      title: Text('Share'),
                      onTap: () {
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => SharePage()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                      onTap: () {
                         Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // Search Bar
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search for Book",
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Main Books Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Main Book", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    Text("Show All", style: TextStyle(color: Colors.red)),
                  ],
                ),
                const SizedBox(height: 10),

                // Main Book List
                SizedBox(
                  height: 220,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      bookCard(context, "Book Title 1", "Main Book Author 1", "Main Book Description 1"),
                      bookCard(context, "Book Title 2", "Main Book Author 2", "Main Book Description 2"),
                      bookCard(context, "Book Title 3", "Main Book Author 2", "Main Book Description 3"),
                      bookCard(context, "Book Title 4", "Main Book Author 2", "Main Book Description 4"),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Other Books Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Other Books", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    Text("Show All", style: TextStyle(color: Colors.red)),
                  ],
                ),
                const SizedBox(height: 10),

                // Other Book List
                Column(
                  children: [
                    bookListTile(context, "Other Book Title 1", "Other Book Author 1", "Other Book Description 1"),
                    bookListTile(context, "Other Book Title 2", "Other Book Author 2", "Other Book Description 2"),
                    bookListTile(context, "Other Book Title 3", "Other Book Author 3", "Other Book Description 3"),
                    bookListTile(context, "Other Book Title 4", "Other Book Author 4", "Other Book Description 4"),
                    bookListTile(context, "Other Book Title 5", "Other Book Author 4", "Other Book Description 5"),
                    bookListTile(context, "Other Book Title 6", "Other Book Author 4", "Other Book Description 6"),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Main Book Card Widget
  Widget bookCard(BuildContext context, String title, String author, String description) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookPage(title: title, author: author, description: description),
          ),
        );
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.red.withOpacity(0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                color: Colors.red.withOpacity(0.2),
                child: Center(
                  child: Text(
                    "Book Cover",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[800],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            Text(author, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  // Other Books List Tile
  Widget bookListTile(BuildContext context, String title, String author, String description) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookPage(title: title, author: author, description: description),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5, offset: const Offset(0, 3))],
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 80,
              color: Colors.red.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Book Cover",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.red[800]),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  Text(author, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                  Text(description, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
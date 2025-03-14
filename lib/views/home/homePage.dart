import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mirathi_book_app/views/auth/login.dart';
import 'package:mirathi_book_app/views/book_cover.dart';
import 'package:mirathi_book_app/views/home/book_view.dart';
import 'package:mirathi_book_app/views/home/settings_page.dart';
import 'package:mirathi_book_app/views/home/share_page.dart';
import 'package:mirathi_book_app/views/home/terms_and_conditions.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

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
                    Text("Show All", style: TextStyle(color: Color(0xFFD76D2C))),
                  ],
                ),
                const SizedBox(height: 10),

                // Main Book List
                SizedBox(
                  height: 220,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      bookCard(context, "MIRATHI", "Main Book Author 1", "Main Book Description 1","assets/pdf/MIRATHI.pdf"),
                      bookCard(context, "Book Title 2", "Main Book Author 2", "Main Book Description 2","assets/pdf/MIRATHI.pdf"),
                      bookCard(context, "Book Title 3", "Main Book Author 2", "Main Book Description 3","assets/pdf/MIRATHI.pdf"),
                      bookCard(context, "Book Title 4", "Main Book Author 2", "Main Book Description 4","assets/pdf/MIRATHI.pdf"),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Other Books Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Other writings", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    Text("Show All", style: TextStyle(color: Color(0xFFD76D2C))),
                  ],
                ),
                const SizedBox(height: 10),

                // Other Book List
                Column(
                  children: [
                    bookListTile(context, "Quick Guidelines", "Other  Author 1", "Other  Description 1", "assets/pdf/QUICK.pdf"),
                    bookListTile(context, "Quick Guidelines", "Other  Author 2", "Other  Description 2", "assets/pdf/QUICK.pdf"),
                    bookListTile(context, "Quick Guidelines", "Other  Author 3", "Other  Description 3", "assets/pdf/QUICK.pdf"),
                    bookListTile(context, "Quick Guidelines", "Other  Author 4", "Other  Description 4", "assets/pdf/QUICK.pdf"),
                    bookListTile(context, "Quick Guidelines", "Other  Author 4", "Other  Description 5", "assets/pdf/QUICK.pdf"),
                    bookListTile(context, "Quick Guidelines", "Other  Author 4", "Other  Description 6", "assets/pdf/QUICK.pdf"),
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
  Widget bookCard(BuildContext context, String title, String author, String description, String pdfPath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookPage(title: title, author: author, pdfPath: pdfPath, description: description,)),
        );
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFFD76D2C).withOpacity(0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: SizedBox.expand(child: BookCover(pdfPath: pdfPath)), // First page preview
              ),
            ),
            const SizedBox(height: 8),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(author, style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  // Other Books List Tile
  Widget bookListTile(BuildContext context, String title, String author, String description, String pdfPath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookPage(title: title, author: author, description: description, pdfPath: pdfPath),
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
              color: Color(0xFFD76D2C).withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: SizedBox.expand(child: BookCover(pdfPath: pdfPath)), // First page preview
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
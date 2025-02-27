import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:share/share.dart';

class SharePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD76D2C),
        title: Text(
          'Share',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Instructions to Share',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'To share this app with your friends, please click the button below. You will be presented with a list of apps that you can use to share.',
              style: GoogleFonts.poppins(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: const Color(0xFFD76D2C),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return ShareBottomSheet();
                    },
                  );
                },
                child: Text(
                  'Share Now',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShareBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Share using',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email'),
            onTap: () {
              // Share.share('Check out this app: [App Link]');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Messages'),
            onTap: () {
              // Share.share('Check out this app: [App Link]');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Other Apps'),
            onTap: () {
              // Share.share('Check out this app: [App Link]');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookPage extends StatefulWidget {
  final String title;
  final String author;
  final String description;

  BookPage({required this.title, required this.author, required this.description});

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  double _progress = 0.0;
  int _currentChapterIndex = 0;

  final List<String> _chapters = [
    "Chapter 1: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam ac felis id elit consequat tincidunt. Nulla facilisi. Duis nec purus quis purus vehicula fringilla ut vel purus. Vestibulum varius, quam at efficitur venenatis, felis lectus tincidunt eros, sed tristique odio lectus vel nisi.\n\n"
    "Donec eget risus et sem ullamcorper consectetur. Etiam tincidunt auctor mi, sed gravida magna ullamcorper sit amet. Vivamus nec erat eu nisi condimentum malesuada. Vestibulum aliquet enim ut magna elementum, id gravida justo vestibulum. Fusce in nisl nec libero gravida volutpat.\n\n"
    "Suspendisse id cursus metus. Nam interdum, purus nec faucibus vehicula, turpis justo rhoncus nulla, sit amet suscipit orci risus nec orci. Duis facilisis justo et convallis interdum.\n\n"
    "Fusce consectetur diam felis, non accumsan nunc posuere a. Integer porta euismod diam, et tincidunt orci pharetra eu. Integer non erat eget odio euismod ultrices.\n\n"
    "Suspendisse id cursus metus. Nam interdum, purus nec faucibus vehicula, turpis justo rhoncus nulla, sit amet suscipit orci risus nec orci. Duis facilisis justo et convallis interdum.\n\n"
    "Fusce consectetur diam felis, non accumsan nunc posuere a. Integer porta euismod diam, et tincidunt orci pharetra eu. Integer non erat eget odio euismod ultrices.\n\n"
    "Integer nec felis libero. Phasellus varius, erat in rhoncus sodales, ligula libero luctus sem, ac rhoncus quam turpis a nunc. Sed a mi id turpis interdum efficitur. Vestibulum et quam nulla.",
    "Chapter 2: Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.\n\n"
    "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
    "Chapter 3: At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus.\n\n"
    "Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.",
  ];

  void _updateProgress(double progress) {
    setState(() {
      _progress = progress;
    });
  }

  void _nextChapter() {
    if (_currentChapterIndex < _chapters.length - 1) {
      setState(() {
        _currentChapterIndex++;
      });
    }
  }

  void _previousChapter() {
    if (_currentChapterIndex > 0) {
      setState(() {
        _currentChapterIndex--;
      });
    }
  }

  void _showChaptersBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: _chapters.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Chapter ${index + 1}'),
              onTap: () {
                setState(() {
                  _currentChapterIndex = index;
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.axis == Axis.vertical) {
                _updateProgress(scrollInfo.metrics.pixels / scrollInfo.metrics.maxScrollExtent);
              }
              return true;
            },
            child: SingleChildScrollView(
              child: Column(
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
                          widget.title,
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

                  // Book Overview Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Book Cover
                        Container(
                          width: 80,
                          height: 100,
                          color: Colors.red.withOpacity(0.2),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "Book Cover",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[800],
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Book Details
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(widget.author, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                            const SizedBox(height: 8),
                            Text("Overview", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14)),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                widget.description,
                                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Chapter Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Chapter ${_currentChapterIndex + 1}:", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 10),
                        Text(
                          _chapters[_currentChapterIndex],
                          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[800]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Floating Progress Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD76D2C)),
              ),
            ),
          ),

          // Floating Buttons
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FloatingActionButton(
                backgroundColor: Color(0xFFD76D2C),
                onPressed: _previousChapter,
                child: Icon(Icons.arrow_back),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FloatingActionButton(
                backgroundColor: Color(0xFFD76D2C),
                onPressed: _nextChapter,
                child: Icon(Icons.arrow_forward),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: FloatingActionButton(
                backgroundColor: Color(0xFFD76D2C),
                onPressed: () => _showChaptersBottomSheet(context),
                child: Icon(Icons.list),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
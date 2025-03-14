import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PdfReaderPage extends StatefulWidget {
  final String pdfPath;

  const PdfReaderPage({required this.pdfPath});

  @override
  _PdfReaderPageState createState() => _PdfReaderPageState();
}

class _PdfReaderPageState extends State<PdfReaderPage> {
  late PdfController _pdfController;
  int _currentPage = 1;
  int _totalPages = 0;
  bool _isLoading = true;
  bool _isNightMode = false;

  @override
  void initState() {
    super.initState();
    _initializePdfController();
  }

  Future<void> _initializePdfController() async {
    final document = await PdfDocument.openAsset(widget.pdfPath);
    _pdfController = PdfController(document: Future.value(document));
    await _loadLastPage();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _loadLastPage() async {
    final prefs = await SharedPreferences.getInstance();
    final lastPage = prefs.getInt('lastPage_${widget.pdfPath}') ?? 1;
    if (lastPage <= _totalPages) {
      _pdfController.jumpToPage(lastPage);
    }
  }

  Future<void> _saveLastPage(int page) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastPage_${widget.pdfPath}', page);
  }

  Future<void> _addBookmark(int page) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarksStr = prefs.getString('bookmarks_${widget.pdfPath}') ?? '';
    final bookmarks = bookmarksStr.split(',').where((s) => s.isNotEmpty).map(int.parse).toList();
    if (!bookmarks.contains(page)) {
      bookmarks.add(page);
      bookmarks.sort();
      await prefs.setString('bookmarks_${widget.pdfPath}', bookmarks.join(','));
    }
  }

  Future<List<int>> _getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarksStr = prefs.getString('bookmarks_${widget.pdfPath}') ?? '';
    return bookmarksStr.split(',').where((s) => s.isNotEmpty).map(int.parse).toList();
  }

  void _showBookmarksDialog() async {
    final bookmarks = await _getBookmarks();
    if (bookmarks.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Bookmarks'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                itemCount: bookmarks.length,
                itemBuilder: (context, index) {
                  final page = bookmarks[index];
                  return ListTile(
                    title: Text('Page $page'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        final updatedBookmarks = List<int>.from(bookmarks)..remove(page);
                        await prefs.setString('bookmarks_${widget.pdfPath}', updatedBookmarks.join(','));
                        Navigator.pop(context);
                        _showBookmarksDialog(); // Refresh the dialog
                      },
                    ),
                    onTap: () {
                      _pdfController.jumpToPage(page);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No bookmarks yet')),
      );
    }
  }

  @override
  void dispose() {
    _saveLastPage(_currentPage);
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Read Book"),
        backgroundColor: const Color(0xFFD76D2C),
        actions: [
          IconButton(
            icon: Icon(_isNightMode ? Icons.wb_sunny : Icons.nights_stay),
            onPressed: () {
              setState(() {
                _isNightMode = !_isNightMode;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_add),
            onPressed: () {
              _addBookmark(_currentPage);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Bookmarked page $_currentPage')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _showBookmarksDialog,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : PdfView(
              scrollDirection: Axis.vertical,
              controller: _pdfController,
              pageSnapping: false,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
                _saveLastPage(page);
              },
              onDocumentLoaded: (PdfDocument document) {
                setState(() {
                  _totalPages = document.pagesCount;
                });
              },
              backgroundDecoration: BoxDecoration(
                color: _isNightMode ? Colors.black : Colors.white,
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFD76D2C),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_totalPages > 0)
                Slider(
                  value: _currentPage.toDouble(),
                  min: 1,
                  max: _totalPages.toDouble(),
                  divisions: _totalPages - 1,
                  label: 'Page $_currentPage',
                  onChanged: (double value) {
                    setState(() {
                      _currentPage = value.toInt();
                    });
                    _pdfController.jumpToPage(_currentPage);
                  },
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: _currentPage > 1
                        ? () => _pdfController.jumpToPage(_currentPage - 1)
                        : null,
                  ),
                  Text('Page $_currentPage of $_totalPages'),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: _currentPage < _totalPages
                        ? () => _pdfController.jumpToPage(_currentPage + 1)
                        : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
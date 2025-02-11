// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final VoidCallback? Function(String searchKey)? performSearch;

  const SearchWidget({super.key, required this.performSearch});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _isSearchActive = false;

  void _onSearchChanged(String query) {
    setState(() {
      _isSearchActive = query.isNotEmpty;
    });
  }

  void _clearSearch() {
    _controller.clear();
    setState(() {
      _isSearchActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              if (widget.performSearch != null) {
                widget.performSearch!(_controller.text);
              }
            },
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          if (_isSearchActive)
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: _clearSearch,
            ),
        ],
      ),
    );
  }
}

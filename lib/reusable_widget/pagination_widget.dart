import 'package:flutter/material.dart';
import 'package:mirathi_book_app/model/response_model.dart' as response;

class PaginationWidget extends StatelessWidget {
  final response.Page page;
  final List<int> pageSizes;
  final int currentPageSizes;
  final VoidCallback? goToNext;
  final VoidCallback? goToPrevious;
  final VoidCallback? Function(int pageNumber)? goToCertainPage;
  final bool? viewBanner;
  final bool? viewButtonLists;
  final bool? viewNextPreviousAction;
  final bool? viewPageSizeSelector;
  final Function(int)? onPageSizeChanged;

  const PaginationWidget({
    super.key,
    required this.page,
    required this.pageSizes,
    required this.currentPageSizes,
    this.goToCertainPage,
    this.goToNext,
    this.goToPrevious,
    this.viewBanner,
    this.viewButtonLists,
    this.viewNextPreviousAction,
    this.onPageSizeChanged,
    this.viewPageSizeSelector,
  });

  @override
  Widget build(BuildContext context) {
    bool canGoToNext = page.pages.contains(page.number! + 1);
    bool canGoToPrevious = page.pages.contains(page.number! - 1);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (viewButtonLists != null && viewButtonLists!)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _buildPageList(),
            ),
          if (viewBanner != null && viewBanner!)
            Text(
              'Page ${page.number} of ${page.numberOfPages}',
              style: TextStyle(fontSize: 24),
            ),
          if (viewNextPreviousAction != null && viewNextPreviousAction!)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: canGoToPrevious ? goToPrevious : null,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  disabledColor: Colors.grey,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: canGoToNext ? goToNext : null,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  disabledColor: Colors.grey,
                ),
              ],
            ),
          if (viewPageSizeSelector != null && viewPageSizeSelector!)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: _buildPageSizeSelector(),
            ),
        ],
      ),
    );
  }

  Widget _buildPageList() {
    List<Widget> pageButtons = [];
    for (int i in page.pages) {
      pageButtons
          .add(_buildPageButton(currentPage: page.number!, pageNumber: i));
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: pageButtons,
      ),
    );
  }

  Widget _buildPageButton({required int pageNumber, required int currentPage}) {
    return GestureDetector(
      onTap: () {
        if (goToCertainPage != null) {
          goToCertainPage!(pageNumber);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          color: currentPage == pageNumber ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.blue),
        ),
        child: Text(
          '$pageNumber',
          style: TextStyle(
            color: currentPage == pageNumber ? Colors.white : Colors.blue,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildPageSizeSelector() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Items per page:'),
        SizedBox(width: 10),
        DropdownButton<int>(
          value: currentPageSizes,
          onChanged: (newSize) {
            if (newSize != null && onPageSizeChanged != null) {
              onPageSizeChanged!(newSize);
            }
          },
          items: pageSizes.map((size) {
            return DropdownMenuItem<int>(
              value: size,
              child: Text(size.toString()),
            );
          }).toList(),
        ),
      ],
    );
  }
}

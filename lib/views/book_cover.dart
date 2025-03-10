import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render.dart';
import 'package:image/image.dart' as img;

class BookCover extends StatefulWidget {
  final String pdfPath;
  const BookCover({super.key, required this.pdfPath});

  @override
  _BookCoverState createState() => _BookCoverState();
}

class _BookCoverState extends State<BookCover> {
  PdfPageImage? _pageImage;
  Uint8List? _convertedImage;
  String? _errorMessage;
  double? _croppedWidth;
  double? _croppedHeight;

  @override
  void initState() {
    super.initState();
    _loadFirstPage();
  }

  img.Image cropToContent(img.Image image) {
    int minX = image.width;
    int minY = image.height;
    int maxX = 0;
    int maxY = 0;

    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        var pixel = image.getPixel(x, y);
        if (img.getRed(pixel) != 255 || img.getGreen(pixel) != 255 || img.getBlue(pixel) != 255) {
          if (x < minX) minX = x;
          if (x > maxX) maxX = x;
          if (y < minY) minY = y;
          if (y > maxY) maxY = y;
        }
      }
    }

    if (minX > maxX || minY > maxY) return image;

    return img.copyCrop(image, minX, minY, maxX - minX + 1, maxY - minY + 1);
  }

  Future<void> _loadFirstPage() async {
    try {
      final doc = await PdfDocument.openAsset(widget.pdfPath);
      if (doc.pageCount == 0) {
        setState(() {
          _errorMessage = 'No pages found in the PDF.';
        });
        await doc.dispose();
        return;
      }

      final page = await doc.getPage(1);
      final pageImage = await page.render(
        fullWidth: 300,
        fullHeight: 400,
      );

      if (pageImage != null) {
        final image = img.Image.fromBytes(
          pageImage.width,
          pageImage.height,
          pageImage.pixels,
          format: img.Format.rgba,
        );
        final croppedImage = cropToContent(image);
        final pngBytes = Uint8List.fromList(img.encodePng(croppedImage));

        setState(() {
          _pageImage = pageImage;
          _convertedImage = pngBytes;
          _croppedWidth = croppedImage.width.toDouble();
          _croppedHeight = croppedImage.height.toDouble();
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to render PDF page.';
        });
      }

      await doc.dispose();
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load PDF page: $e';
      });
    }
  }

  @override
  void dispose() {
    _pageImage?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) {
      return Center(child: Text(_errorMessage!));
    }

    if (_convertedImage == null || _croppedWidth == null || _croppedHeight == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return FittedBox(
      fit: BoxFit.fill,
      child: SizedBox(
        width: _croppedWidth,
        height: _croppedHeight,
        child: Image.memory(
          _convertedImage!,
          errorBuilder: (context, error, stackTrace) {
            return Center(child: Text('Failed to load image: $error'));
          },
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class SinglePhotoScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String heroTag;

  const SinglePhotoScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('API aktif di halaman ini'),
                  content: const Text(
                    '✅ API #1 : PhotoView()\n'
                    '✅ API #6 : minScale\n'
                    '✅ API #7 : maxScale\n'
                    '✅ API #8 : enableRotation = true\n'
                    '✅ API #9 : backgroundDecoration\n'
                    '✅ API #10: heroAttributes\n\n',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: PhotoView(
        // API #1: PhotoView()
        imageProvider: AssetImage(imageUrl),

        // API #6: minScale
        minScale: PhotoViewComputedScale.contained * 0.8,

        // API #7: maxScale
        maxScale: PhotoViewComputedScale.covered * 3.0,

        // API #8: enableRotation 
        enableRotation: true,

        // API #9: backgroundDecoration 
        backgroundDecoration: const BoxDecoration(color: Colors.black),

        // API #10: heroAttributes
        heroAttributes: PhotoViewHeroAttributes(tag: heroTag),

        errorBuilder: (context, error, stack) => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.broken_image, color: Colors.white54, size: 64),
              SizedBox(height: 8),
              Text('Gambar tidak ditemukan',
                  style: TextStyle(color: Colors.white54)),
            ],
          ),
        ),
      ),
    );
  }
}
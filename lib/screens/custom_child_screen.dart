import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

// ============================================================
// CUSTOM CHILD SCREEN
// API yang digunakan:
//   #2 PhotoView.customChild() — zoom widget apapun
// ============================================================
class CustomChildScreen extends StatelessWidget {
  const CustomChildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('API #2: customChild'),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.teal.shade900,
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            child: const Text(
              'PhotoView.customChild() — zoom widget apapun, bukan hanya gambar!\n'
              'Pinch untuk zoom, drag untuk pan, putar dengan 2 jari.',
              style: TextStyle(color: Colors.white70, fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            // API #2: PhotoView.customChild()
            child: PhotoView.customChild(
              childSize: const Size(400, 400),

              // API #9: backgroundDecoration gradient
              backgroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.teal.shade900, Colors.black],
                ),
              ),

              // API #6 & #7: minScale & maxScale
              minScale: PhotoViewComputedScale.contained * 0.5,
              maxScale: PhotoViewComputedScale.covered * 4.0,

              // API #8: enableRotation
              enableRotation: true,

              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.tealAccent, width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.zoom_in, size: 80, color: Colors.tealAccent),
                    SizedBox(height: 16),
                    Text(
                      'Ini adalah Widget\nbukan gambar!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'PhotoView.customChild()\nbisa zoom Container, Text,\nbahkan widget kompleks!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 14),
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
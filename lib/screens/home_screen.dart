import 'package:flutter/material.dart';
import '../data/image_data.dart';
import '../widgets/buttons.dart';
import 'single_photo_screen.dart';
import 'gallery_screen.dart';
import 'custom_child_screen.dart';
import 'controller_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ahmad Nidzomunnashil',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('607012400122 | Kelas 48-02',
                style: TextStyle(fontSize: 11)),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
          ),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.2,
            ),
            itemCount: imageList.length,
            itemBuilder: (context, index) {
              final item = imageList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SinglePhotoScreen(
                        imageUrl: item['url']!,
                        title: item['title']!,
                        heroTag: 'photo_$index',
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: 'photo_$index',
                        child: Image.asset(
                          item['url']!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stack) => Container(
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.broken_image,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          color: Colors.black54,
                          child: Text(
                            item['title']!,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),

          MenuButton(
            icon: Icons.photo_library,
            label: 'Gallery Swipe (API #3: PhotoViewGallery)',
            color: Colors.purple,
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const GalleryScreen())),
          ),
          const SizedBox(height: 8),
          MenuButton(
            icon: Icons.widgets,
            label: 'Custom Child (API #2: PhotoView.customChild)',
            color: Colors.teal,
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const CustomChildScreen())),
          ),
          const SizedBox(height: 8),
          MenuButton(
            icon: Icons.settings,
            label: 'Controller Demo (API #4 & #5)',
            color: Colors.orange,
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ControllerScreen())),
          ),
        ],
      ),
    );
  }
}
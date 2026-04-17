import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../widgets/buttons.dart';
import '../data/image_data.dart';

class ControllerScreen extends StatefulWidget {
  const ControllerScreen({super.key});

  @override
  State<ControllerScreen> createState() => _ControllerScreenState();
}

class _ControllerScreenState extends State<ControllerScreen> {
  // API #4: PhotoViewController
  late PhotoViewController _controller;

  // API #5: PhotoViewScaleStateController
  late PhotoViewScaleStateController _scaleStateController;

  double _currentScale = 1.0;
  Offset _currentPosition = Offset.zero;

  @override
  void initState() {
    super.initState();

    // API #4: inisialisasi & listen stream perubahan
    _controller = PhotoViewController()
      ..outputStateStream.listen((value) {
        if (mounted) {
          setState(() {
            _currentScale = value.scale ?? 1.0;
            _currentPosition = value.position;
          });
        }
      });

    // API #5: inisialisasi scale state controller
    _scaleStateController = PhotoViewScaleStateController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scaleStateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('API #4 & #5: Controller'),
      ),
      body: Column(
        children: [
          // Panel info realtime (dari API #4)
          Container(
            color: Colors.orange.shade900,
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _InfoTile(
                  label: 'Scale\n(API #4)',
                  value: _currentScale.toStringAsFixed(2),
                ),
                _InfoTile(
                  label: 'Position X',
                  value: _currentPosition.dx.toStringAsFixed(1),
                ),
                _InfoTile(
                  label: 'Position Y',
                  value: _currentPosition.dy.toStringAsFixed(1),
                ),
              ],
            ),
          ),

          // PhotoView dengan controller
          Expanded(
            child: PhotoView(
              imageProvider: AssetImage(imageList[0]['url']!),
              controller: _controller,             // API #4
              scaleStateController: _scaleStateController, // API #5
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 3.0,
              backgroundDecoration: const BoxDecoration(color: Colors.black),
              errorBuilder: (context, error, stack) => const Center(
                child: Icon(Icons.broken_image, color: Colors.white54, size: 64),
              ),
            ),
          ),

          // Tombol kontrol (API #4 & #5)
          Container(
            color: Colors.grey.shade900,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: ControlButton(
                    label: 'Reset Zoom\n(API #5)',
                    icon: Icons.zoom_out_map,
                    onTap: () {
                      // API #5: reset ke initial
                      _scaleStateController.scaleState =
                          PhotoViewScaleState.initial;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ControlButton(
                    label: 'Original\n(API #5)',
                    icon: Icons.crop_original,
                    onTap: () {
                      // API #5: set ke ukuran asli
                      _scaleStateController.scaleState =
                          PhotoViewScaleState.originalSize;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ControlButton(
                    label: 'Zoom In\n(API #4)',
                    icon: Icons.zoom_in,
                    onTap: () {
                      // API #4: ubah scale programatik
                      _controller.scale =
                          (_currentScale * 1.5).clamp(0.1, 5.0);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget helper info tile
class _InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 10)),
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
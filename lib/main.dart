import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: ModelBook()),
  );
}

class ModelBook extends StatefulWidget {
  const ModelBook({super.key});

  @override
  State<ModelBook> createState() => _ModelBookState();
}

class _ModelBookState extends State<ModelBook> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 4) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget buildModel(String path) {
    return Center(
      child: ModelViewer(
        src: path,
        alt: "3D Model",
        autoRotate: true,
        cameraControls: true,
        backgroundColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3D Model Viewer Book'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: buildModel('assets/models/burger.glb')),
                  Expanded(
                    child: buildModel('assets/models/courage_eggplant.glb'),
                  ),
                ],
              ),

              buildModel('assets/models/lightning_mcqueen_cars.glb'),

              buildModel('assets/models/RIGGED_REXY.glb'),

              buildModel('assets/models/spider-man_mcu.glb'),

              buildModel('assets/models/woody_toy_story.glb'),
            ],
          ),

          Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton(
              heroTag: 'prev',
              onPressed: _previousPage,
              backgroundColor: Colors.teal,
              child: const Icon(Icons.arrow_back),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              heroTag: 'next',
              onPressed: _nextPage,
              backgroundColor: Colors.teal,
              child: const Icon(Icons.arrow_forward),
            ),
          ),
        ],
      ),
    );
  }
}

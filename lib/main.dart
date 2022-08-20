import 'package:flutter/material.dart';
import 'package:image_gallery_app/features/gallery/presentation/gallery/gallery_page.dart';
import 'package:image_gallery_app/injection_container.dart' as di;

void main() {
  // Initialize dependency injection
  di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Gallery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GalleryPage(),
    );
  }
}

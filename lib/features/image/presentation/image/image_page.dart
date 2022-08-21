// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_app/features/gallery/data/models/image_model/image_model.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({
    Key? key,
    required this.imageModel,
  }) : super(key: key);

  final ImageModel imageModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image')),
      body: Hero(
        tag: imageModel.id,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: CachedNetworkImageProvider(
                imageModel.downloadUrl,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_app/features/gallery/domain/repositories/gallery_repository.dart';
import 'package:image_gallery_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:image_gallery_app/features/gallery/presentation/widgets/gallery_grid.dart';
import 'package:image_gallery_app/injection_container.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Gallery')),
      body: Center(
        child: BlocProvider(
          // Blocs are not dependency injected with GetIt because BlocProvider
          // automatically manages the lifecycle of bloc instances (when to
          // return the same instance and when to dispose of it)
          create: (context) =>
              GalleryBloc(galleryRepository: sl<GalleryRepository>())
                ..add(const GalleryEvent.getGalleryImages(1)),
          child: const GalleryGrid(),
        ),
      ),
    );
  }
}

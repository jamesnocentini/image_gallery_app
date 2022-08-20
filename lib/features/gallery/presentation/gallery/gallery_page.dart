import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:image_gallery_app/injection_container.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Gallery')),
      body: Center(
        child: BlocProvider(
          create: (context) => sl<GalleryBloc>(),
          child: BlocBuilder<GalleryBloc, GalleryState>(
            bloc: sl<GalleryBloc>()..add(const GalleryEvent.getGalleryImages()),
            builder: (context, state) {
              return state.when(
                initial: () => const CircularProgressIndicator(),
                loading: () => const CircularProgressIndicator(),
                loaded: (galleryModel) => GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    crossAxisCount: 3,
                  ),
                  itemCount: galleryModel.imageModels.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                galleryModel.imageModels[index].downloadUrl),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                error: () => const Text('There was an error'),
              );
            },
          ),
        ),
      ),
    );
  }
}

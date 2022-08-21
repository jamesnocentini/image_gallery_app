import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:image_gallery_app/features/image/presentation/image/image_page.dart';

class GalleryGrid extends StatefulWidget {
  const GalleryGrid({super.key});

  @override
  State<GalleryGrid> createState() => _GalleryGridState();
}

class _GalleryGridState extends State<GalleryGrid> {
  final ScrollController _scrollController = ScrollController();

  int pageNumber = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      pageNumber++;
      BlocProvider.of<GalleryBloc>(context)
          .add(GalleryEvent.getGalleryImages(pageNumber));
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryBloc, GalleryState>(
      builder: (context, state) {
        return state.when(
          initial: () => Container(),
          loading: () => const CircularProgressIndicator(),
          loaded: (galleryModel) => GridView.builder(
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              crossAxisCount: 3,
            ),
            itemCount: galleryModel.imageModels.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // For the page transition to be like a modal
                      fullscreenDialog: true,
                      builder: (context) => ImagePage(
                        image: galleryModel.imageModels[index].downloadUrl,
                        name: galleryModel.imageModels[index].author,
                      ),
                    ),
                  );
                },
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
    );
  }
}

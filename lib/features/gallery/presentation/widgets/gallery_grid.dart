import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:image_gallery_app/core/animations/page_route_transitions.dart';
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
            // Defines the area to render before and after the viewport.
            // A higher value results in a smoother scrolling experience
            // but can hinder the initial loading experience as many images are
            // rendered concurrently.
            cacheExtent: 9999,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              crossAxisCount: 3,
            ),
            itemCount: galleryModel.imageModels.length,
            itemBuilder: (context, index) {
              final imageModel = galleryModel.imageModels[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push<void>(
                    context,
                    PageRouteTransitions.fadeThrough(
                      ImagePage(
                        imageModel: imageModel,
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: imageModel.id,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          imageModel.downloadUrl,
                        ),
                      ),
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

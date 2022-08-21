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
    return BlocConsumer<GalleryBloc, GalleryState>(
      listener: (context, state) {
        state.whenOrNull(
          error: () {
            const snackBar = SnackBar(
              content: Text('There was an error'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        );
      },
      buildWhen: (previous, current) {
        return previous.maybeMap(
              loaded: (value) {
                return current.maybeMap(
                  // Don't build when the new state is an error and the previous one is a
                  // loaded state. This means some images were loaded but the next page
                  // in the pagination process failed to load images. By doing so, images
                  // that are already displayed remain visible.
                  error: (value) => false,
                  orElse: () => true,
                );
              },
              orElse: () => true,
            ) ??
            true;
      },
      builder: (context, state) {
        return state.maybeWhen(
          initial: () => Container(),
          loading: () => const CircularProgressIndicator(color: Colors.black),
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
          orElse: () => ElevatedButton(
            onPressed: () => BlocProvider.of<GalleryBloc>(context)
                .add(const GalleryEvent.getGalleryImages(1)),
            child: const Text('Try again'),
          ),
        );
      },
    );
  }
}

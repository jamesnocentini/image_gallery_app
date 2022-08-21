import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_gallery_app/features/gallery/data/models/gallery_model/gallery_model.dart';
import 'package:image_gallery_app/features/gallery/domain/repositories/gallery_repository.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';
part 'gallery_bloc.freezed.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final GalleryRepository galleryRepository;

  GalleryBloc({
    required this.galleryRepository,
  }) : super(const _Initial()) {
    on<_GetGalleryImages>((event, emit) async {
      // Only show a circular indicator the first time the page is shown.
      // During pagination, the grid isn't rebuilt until data or an error
      // is received.
      if (state is! _Loaded) {
        emit(const _Loading());
      }

      final result = await galleryRepository.getGalleryImages(event.pageNumber);
      result.fold(
        (l) => emit(const _Error()),
        (r) {
          state.whenOrNull(
            loading: () => emit(
              _Loaded(r),
            ),
            // If the current state is _Loaded then it means the user is
            // requesting more images from the back end so we append them to
            // the existing state.galleryModel.imageModels
            loaded: (galleryModel) {
              final imageModels = [
                ...galleryModel.imageModels,
                ...r.imageModels
              ];
              emit(_Loaded(galleryModel.copyWith(imageModels: imageModels)));
            },
          );
        },
      );
    });
  }
}

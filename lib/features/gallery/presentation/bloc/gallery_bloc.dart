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
      emit(const _Loading());
      final result = await galleryRepository.getGalleryImages();
      result.fold(
        (l) => emit(const _Error()),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}

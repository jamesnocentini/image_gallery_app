part of 'gallery_bloc.dart';

@freezed
class GalleryState with _$GalleryState {
  const factory GalleryState.initial() = _Initial;
  const factory GalleryState.loading() = _Loading;
  const factory GalleryState.loaded(GalleryModel galleryModel) = _Loaded;
  const factory GalleryState.error() = _Error;
}

part of 'gallery_bloc.dart';

@freezed
class GalleryEvent with _$GalleryEvent {
  const factory GalleryEvent.getGalleryImages(int pageNumber) =
      _GetGalleryImages;
}

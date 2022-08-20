import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_gallery_app/features/gallery/data/models/image_model/image_model.dart';

part 'gallery_model.freezed.dart';
part 'gallery_model.g.dart';

@freezed
class GalleryModel with _$GalleryModel {
  factory GalleryModel({
    required final List<ImageModel> imageModels,
  }) = _GalleryModel;

  factory GalleryModel.fromJson(Map<String, dynamic> json) =>
      _$GalleryModelFromJson(json);
}

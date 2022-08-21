// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:image_gallery_app/core/exceptions/exceptions.dart';
import 'package:image_gallery_app/features/gallery/data/models/gallery_model/gallery_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const cacheKey = 'GALLERY_IMAGES_';

class GalleryLocalDataSource {
  final SharedPreferences sharedPreferences;

  GalleryLocalDataSource({
    required this.sharedPreferences,
  });

  Future<GalleryModel> getLocalGalleryImages(int pageNumber) async {
    final result = sharedPreferences.getString('${cacheKey}_$pageNumber');

    if (result != null) {
      return GalleryModel.fromJson(jsonDecode(result));
    }
    throw CacheException();
  }

  Future<bool> cacheGalleryImages(
      int pageNumber, GalleryModel galleryModel) async {
    return sharedPreferences.setString(
        '${cacheKey}_$pageNumber', jsonEncode(galleryModel.toJson()));
  }
}

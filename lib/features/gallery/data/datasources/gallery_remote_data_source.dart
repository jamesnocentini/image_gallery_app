// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:http/http.dart';

import 'package:image_gallery_app/core/exceptions/exceptions.dart';
import 'package:image_gallery_app/features/gallery/data/models/gallery_model/gallery_model.dart';

const _baseUrl = 'https://picsum.photos/v2';

class GalleryRemoteDataSource {
  final Client httpClient;

  GalleryRemoteDataSource(this.httpClient);

  Future<GalleryModel> getGalleryImages(int pageNumber) async {
    try {
      final uri = Uri.parse('$_baseUrl/list?page=$pageNumber');
      final response = await httpClient.get(uri);
      if (response.statusCode == 200) {
        return GalleryModel.fromJson(
            {'image_models': jsonDecode(response.body)});
      }
      // Throw when the status is not 200
      throw ServerException();
    } catch (e) {
      // Throw when the connection failed due to connectivity
      throw ServerException();
    }
  }
}

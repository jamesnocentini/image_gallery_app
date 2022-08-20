// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:http/http.dart';

import 'package:image_gallery_app/core/exceptions/exceptions.dart';
import 'package:image_gallery_app/features/gallery/data/models/gallery_model/gallery_model.dart';

const _baseUrl = 'https://picsum.photos/v2';

class GalleryRemoteDataSource {
  final Client httpClient;

  GalleryRemoteDataSource(this.httpClient);

  Future<GalleryModel> getGalleryImages() async {
    final uri = Uri.parse('$_baseUrl/list');
    final response = await httpClient.get(uri);
    if (response.statusCode == 200) {
      return GalleryModel.fromJson({'imageModels': jsonDecode(response.body)});
    }
    throw ServerException();
  }
}

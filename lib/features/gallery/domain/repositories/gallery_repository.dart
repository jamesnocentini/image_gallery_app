import 'package:dartz/dartz.dart';
import 'package:image_gallery_app/core/exceptions/server_exception.dart';
import 'package:image_gallery_app/features/gallery/data/models/image_model.dart';

abstract class GalleryRepository {
  Future<Either<ServerException, List<ImageModel>>> getGalleryImages();
}

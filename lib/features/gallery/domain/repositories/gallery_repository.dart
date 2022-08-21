import 'package:dartz/dartz.dart';
import 'package:image_gallery_app/core/exceptions/failures.dart';
import 'package:image_gallery_app/features/gallery/data/models/gallery_model/gallery_model.dart';

abstract class GalleryRepository {
  Future<Either<ServerFailure, GalleryModel>> getGalleryImages(int pageNumber);
}

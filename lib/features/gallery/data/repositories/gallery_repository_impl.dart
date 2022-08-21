import 'package:dartz/dartz.dart';
import 'package:image_gallery_app/core/exceptions/exceptions.dart';
import 'package:image_gallery_app/core/exceptions/failures.dart';
import 'package:image_gallery_app/features/gallery/data/datasources/gallery_remote_data_source.dart';
import 'package:image_gallery_app/features/gallery/data/models/gallery_model/gallery_model.dart';
import 'package:image_gallery_app/features/gallery/domain/repositories/gallery_repository.dart';

class GalleryRepositoryImpl implements GalleryRepository {
  final GalleryRemoteDataSource galleryRemoteDataSource;

  GalleryRepositoryImpl({
    required this.galleryRemoteDataSource,
  });

  @override
  Future<Either<ServerFailure, GalleryModel>> getGalleryImages(
      int pageNumber) async {
    try {
      final galleryModel =
          await galleryRemoteDataSource.getGalleryImages(pageNumber);
      return Right(galleryModel);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:image_gallery_app/core/exceptions/exceptions.dart';
import 'package:image_gallery_app/core/exceptions/failures.dart';
import 'package:image_gallery_app/core/network/network_info.dart';
import 'package:image_gallery_app/features/gallery/data/datasources/gallery_local_data_source.dart';
import 'package:image_gallery_app/features/gallery/data/datasources/gallery_remote_data_source.dart';
import 'package:image_gallery_app/features/gallery/data/models/gallery_model/gallery_model.dart';
import 'package:image_gallery_app/features/gallery/domain/repositories/gallery_repository.dart';

class GalleryRepositoryImpl implements GalleryRepository {
  final GalleryRemoteDataSource galleryRemoteDataSource;
  final NetworkInfo networkInfo;
  final GalleryLocalDataSource galleryLocalDataSource;

  GalleryRepositoryImpl({
    required this.galleryRemoteDataSource,
    required this.networkInfo,
    required this.galleryLocalDataSource,
  });

  @override
  Future<Either<Failure, GalleryModel>> getGalleryImages(int pageNumber) async {
    if (await networkInfo.isConnected) {
      try {
        final galleryModel =
            await galleryRemoteDataSource.getGalleryImages(pageNumber);
        await galleryLocalDataSource.cacheGalleryImages(
            pageNumber, galleryModel);
        return Right(galleryModel);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final galleryModel =
            await galleryLocalDataSource.getLocalGalleryImages(pageNumber);
        return Right(galleryModel);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}

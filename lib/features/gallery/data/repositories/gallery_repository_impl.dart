import 'package:dartz/dartz.dart';
import 'package:image_gallery_app/core/exceptions/server_exception.dart';
import 'package:image_gallery_app/features/gallery/data/datasources/gallery_remote_data_source.dart';
import 'package:image_gallery_app/features/gallery/data/models/image_model.dart';
import 'package:image_gallery_app/features/gallery/domain/repositories/gallery_repository.dart';

class GalleryRepositoryImpl implements GalleryRepository {
  final GalleryRemoteDataSource galleryRemoteDataSource;

  GalleryRepositoryImpl({
    required this.galleryRemoteDataSource,
  });

  @override
  Future<Either<ServerException, List<ImageModel>>> getGalleryImages() async {
    return galleryRemoteDataSource.getGalleryImages();
  }
}

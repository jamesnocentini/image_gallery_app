import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_gallery_app/core/exceptions/exceptions.dart';
import 'package:image_gallery_app/core/exceptions/failures.dart';
import 'package:image_gallery_app/features/gallery/data/datasources/gallery_remote_data_source.dart';
import 'package:image_gallery_app/features/gallery/data/models/gallery_model/gallery_model.dart';
import 'package:image_gallery_app/features/gallery/data/models/image_model/image_model.dart';
import 'package:image_gallery_app/features/gallery/data/repositories/gallery_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockGalleryRemoteDataSource extends Mock
    implements GalleryRemoteDataSource {}

void main() {
  late GalleryRemoteDataSource mockGalleryRemoteDataSource;
  late GalleryRepositoryImpl sut;

  setUp(() {
    mockGalleryRemoteDataSource = MockGalleryRemoteDataSource();
    sut = GalleryRepositoryImpl(
        galleryRemoteDataSource: mockGalleryRemoteDataSource);
  });
  group('getGalleryImages', () {
    final tGalleryModel =
        GalleryModel(imageModels: [ImageModel(id: '1', downloadUrl: '')]);
    test(
      'should return Right(tGalleryModel) when the call is successful',
      () async {
        // arrange
        when(() => mockGalleryRemoteDataSource.getGalleryImages(1))
            .thenAnswer((_) async => tGalleryModel);
        // act
        final result = await sut.getGalleryImages(1);
        // assert
        verify(() => mockGalleryRemoteDataSource.getGalleryImages(1));
        expect(result, Right(tGalleryModel));
      },
    );

    test(
      'should return Left(ServerFailure) when the call is unsuccesful',
      () async {
        // arrange
        when(() => mockGalleryRemoteDataSource.getGalleryImages(1))
            .thenThrow(ServerException());
        // act
        final response = await sut.getGalleryImages(1);
        // assert
        verify(() => mockGalleryRemoteDataSource.getGalleryImages(1));
        expect(response, Left(ServerFailure()));
      },
    );
  });
}

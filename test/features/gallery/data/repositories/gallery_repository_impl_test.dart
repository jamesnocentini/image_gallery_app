import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_gallery_app/features/gallery/data/datasources/gallery_remote_data_source.dart';
import 'package:image_gallery_app/features/gallery/data/models/image_model.dart';
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
    final tImageList = [ImageModel()];
    test(
      'should throw an UnimpletedError when called',
      () async {
        // arrange
        when(() => mockGalleryRemoteDataSource.getGalleryImages())
            .thenAnswer((_) async => Right(tImageList));
        // act
        final result = await sut.getGalleryImages();
        // assert
        verify(() => mockGalleryRemoteDataSource.getGalleryImages());
        expect(result, Right(tImageList));
      },
    );
  });
}

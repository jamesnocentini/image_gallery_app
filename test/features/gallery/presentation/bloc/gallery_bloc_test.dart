import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_gallery_app/core/exceptions/failures.dart';
import 'package:image_gallery_app/features/gallery/data/models/gallery_model/gallery_model.dart';
import 'package:image_gallery_app/features/gallery/domain/repositories/gallery_repository.dart';
import 'package:image_gallery_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockGalleryRepository extends Mock implements GalleryRepository {}

void main() {
  late MockGalleryRepository mockGalleryRepository;
  late GalleryBloc sut;

  setUp(() {
    mockGalleryRepository = MockGalleryRepository();
    sut = GalleryBloc(galleryRepository: mockGalleryRepository);
  });

  test(
    'initialState should be GalleryState.initial()',
    () async {
      // assert
      expect(sut.state, const GalleryState.initial());
    },
  );

  group('GalleryBloc', () {
    final tGallery = GalleryModel.fromJson(
        {'image_models': jsonDecode(fixture('gallery.json'))});

    test(
      'should emit [GalleryState.loading(), GalleryState.loaded(tGallery)] when the repository call is successful',
      () async {
        // arrange
        when(() => mockGalleryRepository.getGalleryImages(1))
            .thenAnswer((_) async => Right(tGallery));
        // assert
        expectLater(
          sut.stream.asBroadcastStream(),
          emitsInOrder([
            const GalleryState.loading(),
            GalleryState.loaded(tGallery),
          ]),
        );
        // act
        sut.add(const GalleryEvent.getGalleryImages(1));
      },
    );
  });

  test(
    'should emit [GalleryState.loading(), GalleryState.loaded(tGallery)] when the repository call is successful',
    () async {
      // arrange
      when(() => mockGalleryRepository.getGalleryImages(1))
          .thenAnswer((_) async => Left(ServerFailure()));
      // assert
      expectLater(
        sut.stream.asBroadcastStream(),
        emitsInOrder([
          const GalleryState.loading(),
          const GalleryState.error(),
        ]),
      );
      // act
      sut.add(const GalleryEvent.getGalleryImages(1));
    },
  );
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:image_gallery_app/core/exceptions/exceptions.dart';
import 'package:image_gallery_app/features/gallery/data/datasources/gallery_remote_data_source.dart';
import 'package:image_gallery_app/features/gallery/data/models/gallery_model/gallery_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockClient extends Mock implements Client {}

main() {
  late MockClient mockClient;
  late GalleryRemoteDataSource sut;

  setUp(() {
    mockClient = MockClient();
    sut = GalleryRemoteDataSource(mockClient);
    registerFallbackValue(Uri());
  });

  group('getGalleryImages', () {
    final tSuccessfulResponse = Response(fixture('gallery.json'), 200);
    final tUnsuccessfulResponse = Response('', 400);

    test(
      'should return the deserialized gallery model when the call is successful',
      () async {
        // arrange
        when(() => mockClient.get(any()))
            .thenAnswer((_) async => tSuccessfulResponse);
        // act
        final result = await sut.getGalleryImages(1);
        // assert
        verify(() =>
            mockClient.get(Uri.parse('https://picsum.photos/v2/list?page=1')));
        expect(
          result,
          GalleryModel.fromJson(
            {'image_models': jsonDecode(fixture('gallery.json'))},
          ),
        );
      },
    );

    test(
      'should throw a ServerException when the call is unsuccessful',
      () async {
        // arrange
        when(() => mockClient.get(any()))
            .thenAnswer((_) async => tUnsuccessfulResponse);
        // act
        final call = sut.getGalleryImages;
        // assert
        expect(() => call(1), throwsA(isA<ServerException>()));
        verify(() =>
            mockClient.get(Uri.parse('https://picsum.photos/v2/list?page=1')));
      },
    );
  });
}

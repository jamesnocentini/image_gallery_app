import 'package:flutter_test/flutter_test.dart';
import 'package:image_gallery_app/features/gallery/data/repositories/gallery_repository_impl.dart';

void main() {
  late GalleryRepositoryImpl sut;

  setUp(() {
    sut = GalleryRepositoryImpl();
  });
  group('getGalleryImages', () {
    test(
      'should throw an UnimpletedError when called',
      () async {
        // act
        final call = sut.getGalleryImages;
        // assert
        expect(() => call(), throwsUnimplementedError);
      },
    );
  });
}

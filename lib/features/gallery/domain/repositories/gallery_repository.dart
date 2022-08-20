import 'package:image_gallery_app/features/gallery/data/models/image_model.dart';

abstract class GalleryRepository {
  Future<List<ImageModel>> getGalleryImages();
}

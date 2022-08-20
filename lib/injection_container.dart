import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:image_gallery_app/features/gallery/data/datasources/gallery_remote_data_source.dart';
import 'package:image_gallery_app/features/gallery/data/repositories/gallery_repository_impl.dart';
import 'package:image_gallery_app/features/gallery/domain/repositories/gallery_repository.dart';
import 'package:image_gallery_app/features/gallery/presentation/bloc/gallery_bloc.dart';

final sl = GetIt.instance;

void init() {
  // Bloc
  sl.registerFactory(() => GalleryBloc(galleryRepository: sl()));
  // Repository
  sl.registerLazySingleton<GalleryRepository>(
    () => GalleryRepositoryImpl(galleryRemoteDataSource: sl()),
  );
  // Data source
  sl.registerLazySingleton(() => GalleryRemoteDataSource(sl()));
  // Utils
  sl.registerLazySingleton(() => Client());
}

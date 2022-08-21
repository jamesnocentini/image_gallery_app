import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:image_gallery_app/core/network/network_info.dart';
import 'package:image_gallery_app/features/gallery/data/datasources/gallery_local_data_source.dart';
import 'package:image_gallery_app/features/gallery/data/datasources/gallery_remote_data_source.dart';
import 'package:image_gallery_app/features/gallery/data/repositories/gallery_repository_impl.dart';
import 'package:image_gallery_app/features/gallery/domain/repositories/gallery_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Repository
  sl.registerLazySingleton<GalleryRepository>(
    () => GalleryRepositoryImpl(
        galleryRemoteDataSource: sl(),
        galleryLocalDataSource: sl(),
        networkInfo: sl()),
  );
  // Data source
  sl.registerLazySingleton(() => GalleryRemoteDataSource(sl()));
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(
      () => GalleryLocalDataSource(sharedPreferences: sharedPreferences));
  // Utils
  sl.registerLazySingleton(() => Client());
  final internetConnectionChecker = InternetConnectionChecker.createInstance(
    // Set the timeout to 1 second for test
    checkTimeout: const Duration(seconds: 1),
  );
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker));
}

import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/data/data_source/remote_data_source.dart';
import 'package:tut_app/data/network/app_api.dart';
import 'package:tut_app/data/network/dio_factory.dart';
import 'package:tut_app/data/network/network_info.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/presentation/login/login_view_model.dart';
import '../data/repository/repository_impl.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final pref = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => pref);

  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  InternetConnectionChecker internetConnectionChecker =
      InternetConnectionChecker();
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker));

  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementor(instance()));

  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginScreenViewModel>(
        () => LoginScreenViewModel(instance<LoginUseCase>()));
  }
}

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:infinistone/core/network/api_service.dart';
import 'package:infinistone/core/network/hive_service.dart';
import 'package:infinistone/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:infinistone/features/auth/data/data_source/remote_data_source/auth_remote_datasource.dart';
import 'package:infinistone/features/auth/data/repository/auth_local_repository.dart';
import 'package:infinistone/features/auth/data/repository/auth_remote_repository.dart';
import 'package:infinistone/features/auth/domain/use_case/login_usecase.dart';
import 'package:infinistone/features/auth/domain/use_case/register_usecase.dart';
import 'package:infinistone/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:infinistone/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:infinistone/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:infinistone/features/home/presentation/view_model/dashboard_cubit.dart';
import 'package:infinistone/features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initApiService();

  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();

  await _initSplashScreenDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initApiService() {
  // init Api
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initRegisterDependencies() {
  // init local data source
  getIt.registerLazySingleton(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  //  Remote Data Source course
  getIt.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(getIt<Dio>()),
  );

  // init local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  // remote Repository register
  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(getIt<AuthRemoteDatasource>()),
  );

  // register use usecase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt(),
      uploadImageUsecase: getIt(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initLoginDependencies() async {
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<LoginBloc>()),
  );
}

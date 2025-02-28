import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:infinistone/app/shared_prefs/token_shared_prefs.dart';
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
import 'package:infinistone/features/bottom/presentation/view_model/home_cubit.dart';
import 'package:infinistone/features/shop/data/data_source/remote_data_source/item_remote_datasource.dart';
import 'package:infinistone/features/shop/data/repository/item_remote_repository.dart';
import 'package:infinistone/features/shop/domain/use_case/create_item_usecase.dart';
import 'package:infinistone/features/shop/domain/use_case/delete_item_usecase.dart';
import 'package:infinistone/features/shop/domain/use_case/get_all_item_usecase.dart';
import 'package:infinistone/features/shop/presentation/view_model/shop_bloc.dart';
import 'package:infinistone/features/splash/presentation/view_model/onboarding_cubit.dart';
import 'package:infinistone/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initOnboardingScreenDependencies();
  await _initSplashScreenDependencies();
  await _initShopDependencies();
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
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
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
      getIt<TokenSharedPrefs>(),
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

_initShopDependencies() async {
  // =========================== Data Source ===========================
  // getIt.registerFactory<BatchLocalDataSource>(
  //     () => BatchLocalDataSource(hiveService: getIt<HiveService>()));

  getIt.registerLazySingleton<ItemRemoteDataSource>(
    () => ItemRemoteDataSource(
      getIt<Dio>(),
    ),
  );

  // =========================== Repository ===========================

  // getIt.registerLazySingleton<ItemLocalRepository>(() => BatchLocalRepository(
  //     batchLocalDataSource: getIt<BatchLocalDataSource>()));

  getIt.registerLazySingleton(
    () => ItemRemoteRepository(
      remoteDataSource: getIt<ItemRemoteDataSource>(),
    ),
  );

  // =========================== Usecases ===========================

  getIt.registerLazySingleton<CreateItemUseCase>(
    () => CreateItemUseCase(itemRepository: getIt<ItemRemoteRepository>()),
  );

  getIt.registerLazySingleton<GetAllItemUseCase>(
    () => GetAllItemUseCase(itemRepository: getIt<ItemRemoteRepository>()),
  );

  getIt.registerLazySingleton<DeleteItemUsecase>(
    () => DeleteItemUsecase(
      itemRepository: getIt<ItemRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );

  // =========================== Bloc ===========================
  getIt.registerFactory<ShopBloc>(
    () => ShopBloc(
      createItemUseCase: getIt<CreateItemUseCase>(),
      getAllItemUseCase: getIt<GetAllItemUseCase>(),
      deleteItemUsecase: getIt<DeleteItemUsecase>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<OnboardingCubit>()),
  );
}

_initOnboardingScreenDependencies() async {
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(),
  );
}

// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:s_c/app/data/datasources/app_local_data_source.dart';
import 'package:s_c/app/data/repositories/app_repository_impl.dart';
import 'package:s_c/app/domain/usecases/clear_remembered_account.dart';
import 'package:s_c/core/extensions/number_input_converter.dart';
import 'package:s_c/features/change_pw/data/datasources/change_pw_local_data_source.dart';
import 'package:s_c/features/change_pw/data/datasources/change_pw_remote_data_source.dart';
import 'package:s_c/features/change_pw/data/repositories/change_pw_repository_impl.dart';
import 'package:s_c/features/change_pw/domain/repositories/change_pw_repository.dart';
import 'package:s_c/features/change_pw/domain/usecases/change_pw.dart';
import 'package:s_c/features/change_pw/presentation/cubit/change_pw_cubit.dart';
import 'package:s_c/features/login/domain/repositories/login_repository.dart';
import 'package:s_c/features/register/data/repositories/register_repository_impl.dart';
import 'package:s_c/features/register/domain/repositories/register_repository.dart';
import 'package:s_c/features/register/domain/usecases/create_user_tasks_category.dart';
import 'package:s_c/features/register/domain/usecases/create_user_with_email_and_password.dart';
import 'package:s_c/features/register/presentation/cubit/register_cubit.dart';
import 'package:s_c/features/tasks/domain/repositories/tasks_repository.dart';
import 'package:s_c/features/tasks/domain/usecases/add_new_task.dart';
import 'package:s_c/features/tasks/domain/usecases/delete_task.dart';
import 'package:s_c/features/tasks/domain/usecases/get_tasks.dart';
import 'package:s_c/features/tasks/domain/usecases/update_task.dart';
import 'package:s_c/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:s_c/features/user_profile/data/datasources/user_profile_remote_data_source.dart';
import 'package:s_c/features/user_profile/data/repositories/user_profile_repository_impl.dart';
import 'package:s_c/features/user_profile/domain/repositories/user_profile_repository.dart';
import 'package:s_c/features/user_profile/domain/usecases/get_user_profile.dart';
import 'package:s_c/features/user_profile/domain/usecases/set_user_profile.dart';
import 'package:s_c/features/user_profile/presentation/cubit/user_profile_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/domain/repositories/app_repository.dart';
import 'app/domain/usecases/remember_account.dart';
import 'app/presentation/cubit/app_cubit.dart';
import 'core/network/network_info.dart';

import 'features/login/data/datasources/login_remote_data_source.dart';
import 'features/login/data/repositories/login_repository_impl.dart';
import 'features/login/domain/usecases/login_with_username_and_pw.dart';
import 'features/login/presentation/cubit/login_cubit.dart';
import 'features/number_trivia/data/datasources/number_trivia_local_data_soucre.dart';
import 'features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'features/number_trivia/presentation/cubit/number_trivia_cubit.dart';
import 'features/register/data/datasources/register_remote_datasource.dart';
import 'features/splash/data/datasources/splash_local_data_source.dart';
import 'features/splash/data/repositories/splash_repository_impl.dart';
import 'features/splash/domain/repositories/splash_repository.dart';
import 'features/splash/domain/usecases/check_first_launch.dart';
import 'features/splash/domain/usecases/check_remembered_login.dart';
import 'features/splash/presentation/cubit/splash_cubit.dart';
import 'features/tasks/data/datasources/tasks_remote_datasource.dart';
import 'features/tasks/data/repositories/tasks_repository_impl.dart';

// service locator
final sl = GetIt.instance;

Future<void> init({required FirebaseApp firebaseApp}) async {
  //! Features - NumberTrivia
  sl.registerFactory(() => NumberTriviaCubit(
      getConcreteNumberTrivia: sl(),
      getRandomNumberTrivia: sl(),
      numberInputConverter: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(
            remoteDataSource: sl(),
            localDataSource: sl(),
            networkInfo: sl(),
          ));

  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));

  //! Features - Splash
  sl.registerFactory(() => SplashCubit(
        checkFirstLaunch: sl(),
        checkRememberedLogin: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => CheckFirstLaunch(repository: sl()));
  sl.registerLazySingleton(() => CheckRememberedLogin(repository: sl()));

  // Repository
  sl.registerLazySingleton<SplashRepository>(() => SplashRepositoryImpl(
        localDataSource: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<SplashLocalDataSource>(
      () => SplashLocalDataSourceImpl(sharedPreferences: sl()));

  //! Features - Login
  sl.registerFactory(() => LoginCubit(
        loginWithUsernameAndPw: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => LoginWithUsernameAndPw(repository: sl()));

  // Repository
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(fir: sl()));

  //! Features - Register
  sl.registerFactory(() => RegisterCubit(
        createUserWithEmailAndPassword: sl(),
        createUserTasksCategory: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(
      () => CreateUserWithEmailAndPassword(repository: sl()));
  // Use cases
  sl.registerLazySingleton(() => CreateUserTasksCategory(repository: sl()));

  // Repository
  sl.registerLazySingleton<RegisterRepository>(() => RegisterRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<RegisterRemoteDataSource>(() =>
      RegisterRemoteDataSourceImpl(fir: sl(), firApp: firebaseApp, dio: sl()));

  //! Features - Task
  sl.registerFactory(() => TasksCubit(
      getTasks: sl(), addNewTask: sl(), updateTask: sl(), deleteTask: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetTasks(repository: sl()));
  sl.registerLazySingleton(() => AddNewTask(repository: sl()));
  sl.registerLazySingleton(() => UpdateTask(repository: sl()));
  sl.registerLazySingleton(() => DeleteTask(repository: sl()));
  // Repository
  sl.registerLazySingleton<TasksRepository>(() => TasksRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<TasksRemoteDataSource>(
      () => TasksRemoteDataSourceImpl(dio: sl(), firebaseApp: firebaseApp));

  //! Features - Change PW
  sl.registerFactory(() => ChangePwCubit(changePw: sl()));

  // Use cases
  sl.registerLazySingleton(() => ChangePw(repository: sl()));
  // Repository
  sl.registerLazySingleton<ChangePwRepository>(() => ChangePwRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<ChangePwRemoteDataSource>(
      () => ChangePwRemoteDataSourceImpl(firebaseAuth: sl()));
  sl.registerLazySingleton<ChangePwLocalDataSource>(
      () => ChangePwLocalDataSourceImpl(sharedPreferences: sl()));

  //! Features - UserProfile
  sl.registerFactory(
      () => UserProfileCubit(getUserProfile: sl(), setUserProfile: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetUserProfile(repositoty: sl()));
  sl.registerLazySingleton(() => SetUserProfile(repositoty: sl()));
  // Repository
  sl.registerLazySingleton<UserProfileRepository>(
      () => UserProfileRepositoryImpl(
            remoteDataSource: sl(),
            networkInfo: sl(),
          ));

  // Data sources
  sl.registerLazySingleton<UserProfileRemoteDataSource>(
      () => UserProfileRemoteDataSourceImpl(
            dio: sl(),
            firebaseApp: firebaseApp,
          ));

  //! Features - App
  sl.registerFactory(() => AppCubit(
        clearRememberedAccount: sl(),
        rememberAccount: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => ClearRememberedAccount(repository: sl()));
  sl.registerLazySingleton(() => RememberAccount(repository: sl()));

  // Repository
  sl.registerLazySingleton<AppRepository>(() => AppRepositoryImpl(
        localDataSource: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<AppLocalDataSource>(
      () => AppLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton(() => NumberInputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  // Localization

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio()..interceptors.add(PrettyDioLogger()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseApp>(() => firebaseApp);
}

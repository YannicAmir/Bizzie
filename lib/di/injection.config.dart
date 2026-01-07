// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:firebase_remote_config/firebase_remote_config.dart' as _i627;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../core/network/network_info.dart' as _i6;
import '../core/network/network_module.dart' as _i419;
import '../features/auth/data/datasources/remote_auth_data_source.dart'
    as _i877;
import '../features/auth/data/repositories/auth_repository_impl.dart' as _i570;
import '../features/auth/domain/interfaces/i_auth_repository.dart' as _i685;
import '../features/auth/domain/usecases/delete_account.dart' as _i739;
import '../features/auth/domain/usecases/reset_password.dart' as _i73;
import '../features/auth/domain/usecases/sign_in_with_apple.dart' as _i538;
import '../features/auth/domain/usecases/sign_in_with_email.dart' as _i33;
import '../features/auth/domain/usecases/sign_in_with_google.dart' as _i345;
import '../features/auth/domain/usecases/sign_out.dart' as _i472;
import '../features/auth/domain/usecases/sign_up_with_email.dart' as _i588;
import '../features/auth/presentation/bloc/auth_bloc.dart' as _i59;
import '../features/notifications/data/datasources/fcm_remote_datasource.dart'
    as _i640;
import '../features/notifications/data/datasources/local_notification_datasource.dart'
    as _i982;
import '../features/notifications/data/repositories/notification_repository_impl.dart'
    as _i648;
import '../features/notifications/domain/interfaces/i_notification_repository.dart'
    as _i622;
import '../features/notifications/domain/usecases/get_fcm_token.dart' as _i69;
import '../features/notifications/domain/usecases/listen_to_messages.dart'
    as _i954;
import '../features/notifications/domain/usecases/request_notification_permission.dart'
    as _i332;
import '../features/notifications/domain/usecases/subscribe_to_topic.dart'
    as _i327;
import '../features/notifications/domain/usecases/unsubscribe_from_topic.dart'
    as _i999;
import '../features/notifications/presentation/bloc/notification_bloc.dart'
    as _i687;
import '../features/onboarding/data/datasources/onboarding_remote_datasource.dart'
    as _i1016;
import '../features/onboarding/data/repositories/onboarding_repository_impl.dart'
    as _i379;
import '../features/onboarding/domain/interfaces/i_onboarding_repository.dart'
    as _i329;
import '../features/onboarding/presentation/bloc/onboarding_bloc.dart' as _i593;
import '../features/search/data/datasources/ai_product_search_service.dart'
    as _i977;
import '../features/search/data/datasources/stock_local_datasource.dart'
    as _i191;
import '../features/search/data/repositories/recommended_brands_repository.dart'
    as _i230;
import '../features/search/data/repositories/stock_repository.dart' as _i392;
import '../features/search/domain/interfaces/i_recommended_brands_repository.dart'
    as _i1012;
import '../features/search/domain/interfaces/i_stock_repository.dart' as _i456;
import '../features/search/domain/services/stock_search_service.dart' as _i269;
import '../features/search/domain/usecases/find_stock_for_product_usecase.dart'
    as _i691;
import '../features/search/domain/usecases/get_recommended_brands_usecase.dart'
    as _i693;
import '../features/search/domain/usecases/get_search_dashboard_data_usecase.dart'
    as _i555;
import '../features/search/domain/usecases/search_stocks_usecase.dart' as _i130;
import '../features/search/presentation/bloc/search_bloc.dart' as _i348;
import '../features/user/data/datasources/user_local_datasource.dart' as _i147;
import '../features/user/data/datasources/user_remote_datasource.dart' as _i481;
import '../features/user/data/repositories/user_repository_impl.dart' as _i272;
import '../features/user/domain/interfaces/user_repository.dart' as _i615;
import '../features/user/domain/usecases/get_user_usecase.dart' as _i561;
import '../features/user/presentation/bloc/user_bloc.dart' as _i200;
import '../services/config_service.dart' as _i216;
import '../services/firestore_service.dart' as _i52;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    final networkModule = _$NetworkModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.factory<_i640.FcmRemoteDataSource>(() => _i640.FcmRemoteDataSource());
    await gh.singletonAsync<_i982.LocalNotificationDataSource>(() {
      final i = _i982.LocalNotificationDataSource();
      return i.init().then((_) => i);
    }, preResolve: true);
    await gh.singletonAsync<_i216.ConfigService>(
      () => _i216.ConfigService.init(),
      preResolve: true,
    );
    gh.singleton<_i52.FirestoreService>(() => _i52.FirestoreService.init());
    gh.lazySingleton<_i974.FirebaseFirestore>(() => registerModule.firestore);
    gh.lazySingleton<_i892.FirebaseMessaging>(
      () => registerModule.firebaseMessaging,
    );
    gh.lazySingleton<_i627.FirebaseRemoteConfig>(
      () => registerModule.remoteConfig,
    );
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i116.GoogleSignIn>(() => registerModule.googleSignIn);
    gh.lazySingleton<_i457.FirebaseStorage>(() => registerModule.storage);
    gh.lazySingleton<_i622.INotificationRepository>(
      () => _i648.NotificationRepositoryImpl(
        gh<_i640.FcmRemoteDataSource>(),
        gh<_i982.LocalNotificationDataSource>(),
      ),
    );
    gh.singleton<_i361.Dio>(
      () => networkModule.fmpDio(gh<_i216.ConfigService>()),
      instanceName: 'FmpDio',
    );
    gh.factory<_i1016.IOnboardingRemoteDataSource>(
      () => _i1016.OnboardingRemoteDataSource(
        gh<_i52.FirestoreService>(),
        gh<_i216.ConfigService>(),
      ),
    );
    gh.factory<_i69.GetFcmToken>(
      () => _i69.GetFcmToken(gh<_i622.INotificationRepository>()),
    );
    gh.factory<_i954.ListenToMessages>(
      () => _i954.ListenToMessages(gh<_i622.INotificationRepository>()),
    );
    gh.factory<_i332.RequestNotificationPermission>(
      () => _i332.RequestNotificationPermission(
        gh<_i622.INotificationRepository>(),
      ),
    );
    gh.factory<_i327.SubscribeToTopic>(
      () => _i327.SubscribeToTopic(gh<_i622.INotificationRepository>()),
    );
    gh.factory<_i999.UnsubscribeFromTopic>(
      () => _i999.UnsubscribeFromTopic(gh<_i622.INotificationRepository>()),
    );
    gh.factory<_i191.IStockLocalDataSource>(
      () => _i191.StockLocalDataSource(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i147.IUserLocalDataSource>(
      () => _i147.UserLocalDataSource(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i6.NetworkInfo>(() => _i6.NetworkInfoImpl());
    gh.factory<_i481.IUserRemoteDataSource>(
      () => _i481.UserRemoteDataSource(gh<_i52.FirestoreService>()),
    );
    gh.lazySingleton<_i615.IUserRepository>(
      () => _i272.UserRepositoryImpl(
        gh<_i481.IUserRemoteDataSource>(),
        gh<_i147.IUserLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i329.IOnboardingRepository>(
      () => _i379.OnboardingRepositoryImpl(
        gh<_i1016.IOnboardingRemoteDataSource>(),
        gh<_i892.FirebaseMessaging>(),
      ),
    );
    gh.factory<_i687.NotificationBloc>(
      () => _i687.NotificationBloc(
        gh<_i332.RequestNotificationPermission>(),
        gh<_i69.GetFcmToken>(),
        gh<_i954.ListenToMessages>(),
        gh<_i327.SubscribeToTopic>(),
        gh<_i999.UnsubscribeFromTopic>(),
      ),
    );
    gh.singleton<_i977.AiProductSearchService>(
      () => _i977.AiProductSearchService(gh<_i216.ConfigService>()),
    );
    gh.lazySingleton<_i877.RemoteAuthDataSource>(
      () => _i877.RemoteAuthDataSourceImpl(
        firebaseAuth: gh<_i59.FirebaseAuth>(),
        googleSignIn: gh<_i116.GoogleSignIn>(),
      ),
    );
    gh.lazySingleton<_i1012.IRecommendedBrandsRepository>(
      () => _i230.RecommendedBrandsRepository(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i691.FindStockForProductUseCase>(
      () =>
          _i691.FindStockForProductUseCase(gh<_i977.AiProductSearchService>()),
    );
    gh.lazySingleton<_i693.GetRecommendedBrandsUseCase>(
      () => _i693.GetRecommendedBrandsUseCase(
        gh<_i1012.IRecommendedBrandsRepository>(),
      ),
    );
    gh.lazySingleton<_i456.IStockRepository>(
      () => _i392.StockRepository(
        gh<_i457.FirebaseStorage>(),
        gh<_i191.IStockLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i561.GetUserUseCase>(
      () => _i561.GetUserUseCase(gh<_i615.IUserRepository>()),
    );
    gh.lazySingleton<_i685.IAuthRepository>(
      () => _i570.AuthRepositoryImpl(
        remoteDataSource: gh<_i877.RemoteAuthDataSource>(),
      ),
    );
    gh.lazySingleton<_i200.UserBloc>(
      () => _i200.UserBloc(gh<_i561.GetUserUseCase>()),
    );
    gh.lazySingleton<_i739.DeleteAccount>(
      () => _i739.DeleteAccount(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i73.ResetPassword>(
      () => _i73.ResetPassword(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i538.SignInWithApple>(
      () => _i538.SignInWithApple(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i33.SignInWithEmail>(
      () => _i33.SignInWithEmail(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i345.SignInWithGoogle>(
      () => _i345.SignInWithGoogle(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i472.SignOut>(
      () => _i472.SignOut(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i588.SignUpWithEmail>(
      () => _i588.SignUpWithEmail(gh<_i685.IAuthRepository>()),
    );
    gh.factory<_i555.GetSearchDashboardDataUseCase>(
      () => _i555.GetSearchDashboardDataUseCase(
        gh<_i685.IAuthRepository>(),
        gh<_i561.GetUserUseCase>(),
        gh<_i693.GetRecommendedBrandsUseCase>(),
      ),
    );
    gh.lazySingleton<_i269.StockSearchService>(
      () => _i269.StockSearchService(gh<_i456.IStockRepository>()),
    );
    gh.lazySingleton<_i59.AuthBloc>(
      () => _i59.AuthBloc(
        authRepository: gh<_i685.IAuthRepository>(),
        signInWithGoogle: gh<_i345.SignInWithGoogle>(),
        signInWithApple: gh<_i538.SignInWithApple>(),
        signInWithEmail: gh<_i33.SignInWithEmail>(),
        signUpWithEmail: gh<_i588.SignUpWithEmail>(),
        signOut: gh<_i472.SignOut>(),
        resetPassword: gh<_i73.ResetPassword>(),
        deleteAccount: gh<_i739.DeleteAccount>(),
      ),
    );
    gh.factory<_i593.OnboardingBloc>(
      () => _i593.OnboardingBloc(
        gh<_i329.IOnboardingRepository>(),
        gh<_i685.IAuthRepository>(),
      ),
    );
    gh.factory<_i130.SearchStocksUseCase>(
      () => _i130.SearchStocksUseCase(gh<_i269.StockSearchService>()),
    );
    gh.factory<_i348.SearchBloc>(
      () => _i348.SearchBloc(
        gh<_i130.SearchStocksUseCase>(),
        gh<_i555.GetSearchDashboardDataUseCase>(),
        gh<_i691.FindStockForProductUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}

class _$NetworkModule extends _i419.NetworkModule {}

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
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;

import '../core/network/network_info.dart' as _i6;
import '../core/network/network_module.dart' as _i419;
import '../features/auth/data/datasources/remote_auth_data_source.dart'
    as _i877;
import '../features/auth/data/repositories/auth_repository_impl.dart' as _i570;
import '../features/auth/domain/interfaces/i_auth_repository.dart' as _i685;
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
    gh.lazySingleton<_i6.NetworkInfo>(() => _i6.NetworkInfoImpl());
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
    gh.lazySingleton<_i877.RemoteAuthDataSource>(
      () => _i877.RemoteAuthDataSourceImpl(
        firebaseAuth: gh<_i59.FirebaseAuth>(),
        googleSignIn: gh<_i116.GoogleSignIn>(),
      ),
    );
    gh.lazySingleton<_i685.IAuthRepository>(
      () => _i570.AuthRepositoryImpl(
        remoteDataSource: gh<_i877.RemoteAuthDataSource>(),
      ),
    );
    gh.factory<_i593.OnboardingBloc>(
      () => _i593.OnboardingBloc(
        gh<_i329.IOnboardingRepository>(),
        gh<_i685.IAuthRepository>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}

class _$NetworkModule extends _i419.NetworkModule {}

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:cloud_functions/cloud_functions.dart' as _i809;
import 'package:device_info_plus/device_info_plus.dart' as _i833;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:firebase_remote_config/firebase_remote_config.dart' as _i627;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as _i163;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../core/domain/models/sector.dart' as _i162;
import '../core/interfaces/i_firebase_functions_service.dart' as _i347;
import '../core/interfaces/i_local_storage_service.dart' as _i583;
import '../core/interfaces/i_notification_service.dart' as _i430;
import '../core/interfaces/i_permission_service.dart' as _i202;
import '../core/network/network_info.dart' as _i6;
import '../core/network/network_module.dart' as _i419;
import '../core/services/app_info_service.dart' as _i248;
import '../core/services/local_storage_service.dart' as _i1003;
import '../env/app_env.dart' as _i915;
import '../env/env_impl.dart' as _i343;
import '../features/auth/data/datasources/remote_auth_data_source.dart'
    as _i877;
import '../features/auth/data/repositories/auth_repository_impl.dart' as _i570;
import '../features/auth/domain/interfaces/i_auth_repository.dart' as _i685;
import '../features/auth/domain/usecases/delete_account.dart' as _i739;
import '../features/auth/domain/usecases/get_auth_stream.dart' as _i427;
import '../features/auth/domain/usecases/get_current_user.dart' as _i318;
import '../features/auth/domain/usecases/reauthenticate_usecase.dart' as _i205;
import '../features/auth/domain/usecases/reset_password.dart' as _i73;
import '../features/auth/domain/usecases/sign_in_with_apple.dart' as _i538;
import '../features/auth/domain/usecases/sign_in_with_email.dart' as _i33;
import '../features/auth/domain/usecases/sign_in_with_google.dart' as _i345;
import '../features/auth/domain/usecases/sign_out.dart' as _i472;
import '../features/auth/domain/usecases/sign_up_with_email.dart' as _i588;
import '../features/auth/presentation/bloc/auth_bloc.dart' as _i59;
import '../features/company_profile/business/data/datasources/business_firestore_data_source.dart'
    as _i379;
import '../features/company_profile/business/data/datasources/business_remote_data_source.dart'
    as _i706;
import '../features/company_profile/business/data/repositories/business_repository_impl.dart'
    as _i606;
import '../features/company_profile/business/domain/interfaces/i_business_repository.dart'
    as _i872;
import '../features/company_profile/business/domain/usecases/get_business_profile_usecase.dart'
    as _i582;
import '../features/company_profile/business/presentation/bloc/company_business_bloc.dart'
    as _i505;
import '../features/company_profile/dividends/data/datasources/dividends_firestore_data_source.dart'
    as _i584;
import '../features/company_profile/dividends/data/datasources/dividends_remote_data_source.dart'
    as _i473;
import '../features/company_profile/dividends/data/repositories/dividend_repository_impl.dart'
    as _i418;
import '../features/company_profile/dividends/domain/interfaces/i_dividend_repository.dart'
    as _i468;
import '../features/company_profile/dividends/domain/usecases/get_dividend_info_usecase.dart'
    as _i754;
import '../features/company_profile/dividends/presentation/bloc/company_dividends/company_dividends_bloc.dart'
    as _i723;
import '../features/company_profile/eps/data/repositories/eps_repository_impl.dart'
    as _i390;
import '../features/company_profile/eps/domain/interfaces/i_eps_repository.dart'
    as _i695;
import '../features/company_profile/eps/domain/usecases/get_eps_stats_usecase.dart'
    as _i107;
import '../features/company_profile/eps/presentation/bloc/company_eps_bloc.dart'
    as _i683;
import '../features/company_profile/fcps/data/repositories/fcps_repository_impl.dart'
    as _i724;
import '../features/company_profile/fcps/domain/interfaces/i_fcps_repository.dart'
    as _i368;
import '../features/company_profile/fcps/domain/usecases/get_fcps_stats_usecase.dart'
    as _i805;
import '../features/company_profile/fcps/presentation/bloc/company_fcps_bloc.dart'
    as _i178;
import '../features/company_profile/financial_statements/data/datasources/financial_statements_firestore_data_source.dart'
    as _i806;
import '../features/company_profile/financial_statements/data/datasources/financial_statements_remote_data_source.dart'
    as _i348;
import '../features/company_profile/financial_statements/data/repositories/financial_statements_repository_impl.dart'
    as _i741;
import '../features/company_profile/financial_statements/domain/interfaces/i_financial_statements_repository.dart'
    as _i865;
import '../features/company_profile/financial_statements/domain/usecases/get_balance_sheets_usecase.dart'
    as _i1054;
import '../features/company_profile/financial_statements/domain/usecases/get_cash_flow_statements_usecase.dart'
    as _i64;
import '../features/company_profile/financial_statements/domain/usecases/get_full_financials_usecase.dart'
    as _i606;
import '../features/company_profile/financial_statements/domain/usecases/get_income_statements_usecase.dart'
    as _i204;
import '../features/company_profile/financial_statements/presentation/bloc/financial_statements_bloc.dart'
    as _i191;
import '../features/company_profile/free_cash_flow/data/repositories/free_cash_flow_repository_impl.dart'
    as _i269;
import '../features/company_profile/free_cash_flow/domain/interfaces/i_free_cash_flow_repository.dart'
    as _i581;
import '../features/company_profile/free_cash_flow/domain/usecases/get_free_cash_flow_stats_usecase.dart'
    as _i106;
import '../features/company_profile/free_cash_flow/presentation/bloc/company_free_cash_flow_bloc.dart'
    as _i991;
import '../features/company_profile/net_income/data/repositories/net_income_repository_impl.dart'
    as _i13;
import '../features/company_profile/net_income/domain/interfaces/i_net_income_repository.dart'
    as _i814;
import '../features/company_profile/net_income/domain/usecases/get_net_income_stats_usecase.dart'
    as _i775;
import '../features/company_profile/net_income/presentation/bloc/company_net_income_bloc.dart'
    as _i614;
import '../features/company_profile/news/data/datasources/news_firestore_data_source.dart'
    as _i634;
import '../features/company_profile/news/data/datasources/news_remote_data_source.dart'
    as _i1043;
import '../features/company_profile/news/data/repositories/news_repository_impl.dart'
    as _i368;
import '../features/company_profile/news/domain/interfaces/i_news_repository.dart'
    as _i15;
import '../features/company_profile/news/domain/usecases/get_company_news_usecase.dart'
    as _i654;
import '../features/company_profile/news/presentation/bloc/company_news/company_news_bloc.dart'
    as _i501;
import '../features/company_profile/pe_ratio/data/repositories/pe_ratio_repository_impl.dart'
    as _i260;
import '../features/company_profile/pe_ratio/domain/interfaces/i_pe_ratio_repository.dart'
    as _i943;
import '../features/company_profile/pe_ratio/domain/usecases/get_pe_ratio_usecase.dart'
    as _i657;
import '../features/company_profile/pe_ratio/presentation/bloc/company_pe_ratio_bloc.dart'
    as _i423;
import '../features/company_profile/pfcf_ratio/data/repositories/pfcf_ratio_repository_impl.dart'
    as _i398;
import '../features/company_profile/pfcf_ratio/domain/interfaces/i_pfcf_ratio_repository.dart'
    as _i1019;
import '../features/company_profile/pfcf_ratio/domain/usecases/get_pfcf_ratio_usecase.dart'
    as _i912;
import '../features/company_profile/pfcf_ratio/presentation/bloc/company_pfcf_ratio_bloc.dart'
    as _i62;
import '../features/company_profile/revenue/data/repositories/revenue_repository_impl.dart'
    as _i517;
import '../features/company_profile/revenue/domain/interfaces/i_revenue_repository.dart'
    as _i203;
import '../features/company_profile/revenue/domain/usecases/get_revenue_stats_usecase.dart'
    as _i584;
import '../features/company_profile/revenue/presentation/bloc/company_revenue_bloc.dart'
    as _i806;
import '../features/company_profile/roe/data/repositories/roe_repository_impl.dart'
    as _i218;
import '../features/company_profile/roe/domain/interfaces/i_roe_repository.dart'
    as _i1025;
import '../features/company_profile/roe/domain/usecases/get_roe_usecase.dart'
    as _i231;
import '../features/company_profile/roe/presentation/bloc/company_roe_bloc.dart'
    as _i1033;
import '../features/company_profile/security/data/datasources/security_firestore_data_source.dart'
    as _i595;
import '../features/company_profile/security/data/datasources/security_remote_data_source.dart'
    as _i481;
import '../features/company_profile/security/data/repositories/price_repository_impl.dart'
    as _i952;
import '../features/company_profile/security/data/repositories/security_repository_impl.dart'
    as _i503;
import '../features/company_profile/security/domain/interfaces/i_price_repository.dart'
    as _i876;
import '../features/company_profile/security/domain/interfaces/i_security_repository.dart'
    as _i158;
import '../features/company_profile/security/domain/usecases/get_historical_eod_prices_use_case.dart'
    as _i925;
import '../features/company_profile/security/domain/usecases/get_price_history_usecase.dart'
    as _i605;
import '../features/company_profile/security/domain/usecases/get_security_details_usecase.dart'
    as _i190;
import '../features/company_profile/security/domain/usecases/get_upcoming_earnings_usecase.dart'
    as _i1055;
import '../features/company_profile/security/presentation/bloc/company_security_bloc.dart'
    as _i410;
import '../features/company_profile/security/presentation/bloc/historical_price_eod/historical_price_eod_bloc.dart'
    as _i342;
import '../features/company_profile/security/presentation/bloc/price_chart/price_chart_bloc.dart'
    as _i682;
import '../features/company_profile/security/presentation/bloc/upcoming_earnings/upcoming_earnings_bloc.dart'
    as _i73;
import '../features/company_profile/shared/data/datasources/company_firestore_data_source.dart'
    as _i741;
import '../features/company_profile/shared/data/datasources/company_remote_data_source.dart'
    as _i286;
import '../features/company_profile/shared/data/datasources/ratios_firestore_data_source.dart'
    as _i958;
import '../features/company_profile/shared/data/datasources/ratios_remote_data_source.dart'
    as _i423;
import '../features/company_profile/shared/data/repositories/company_repository_impl.dart'
    as _i568;
import '../features/company_profile/shared/domain/interfaces/i_company_repository.dart'
    as _i376;
import '../features/company_profile/shares/data/repositories/shares_repository_impl.dart'
    as _i272;
import '../features/company_profile/shares/domain/interfaces/i_shares_repository.dart'
    as _i786;
import '../features/company_profile/shares/domain/usecases/get_shares_usecase.dart'
    as _i240;
import '../features/company_profile/shares/presentation/bloc/company_shares_bloc.dart'
    as _i807;
import '../features/market/data/datasources/market_local_datasource.dart'
    as _i1009;
import '../features/market/data/datasources/market_remote_datasource.dart'
    as _i454;
import '../features/market/data/repositories/market_repository_impl.dart'
    as _i27;
import '../features/market/domain/interfaces/i_market_repository.dart' as _i607;
import '../features/notifications/data/datasources/fcm_remote_datasource.dart'
    as _i640;
import '../features/notifications/data/datasources/local_notification_datasource.dart'
    as _i982;
import '../features/notifications/data/repositories/notification_repository_impl.dart'
    as _i648;
import '../features/notifications/domain/interfaces/i_notification_repository.dart'
    as _i622;
import '../features/notifications/domain/usecases/clear_cached_token.dart'
    as _i961;
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
import '../features/onboarding/domain/usecases/complete_onboarding_usecase.dart'
    as _i874;
import '../features/onboarding/domain/usecases/get_sectors_usecase.dart'
    as _i920;
import '../features/onboarding/domain/usecases/get_sp500_history_usecase.dart'
    as _i952;
import '../features/onboarding/presentation/bloc/onboarding_bloc.dart' as _i593;
import '../features/onboarding/select_brands/data/datasources/select_brands_remote_datasource.dart'
    as _i6;
import '../features/onboarding/select_brands/data/repositories/select_brands_repository_impl.dart'
    as _i432;
import '../features/onboarding/select_brands/domain/interfaces/i_select_brands_repository.dart'
    as _i990;
import '../features/onboarding/select_brands/domain/usecases/get_daily_brands_usecase.dart'
    as _i422;
import '../features/onboarding/select_brands/presentation/bloc/select_brands_bloc.dart'
    as _i709;
import '../features/profile/domain/usecases/change_password_usecase.dart'
    as _i797;
import '../features/profile/domain/usecases/delete_account_usecase.dart' as _i5;
import '../features/profile/domain/usecases/get_profile_display_data_usecase.dart'
    as _i687;
import '../features/profile/domain/usecases/update_profile_usecase.dart'
    as _i586;
import '../features/profile/presentation/bloc/change_password_bloc.dart'
    as _i980;
import '../features/profile/presentation/bloc/edit_profile_bloc.dart' as _i875;
import '../features/profile/presentation/bloc/profile_bloc.dart' as _i570;
import '../features/reports/data/datasources/reports_remote_datasource.dart'
    as _i532;
import '../features/reports/data/repositories/reports_repository_impl.dart'
    as _i1028;
import '../features/reports/domain/interfaces/i_reports_repository.dart'
    as _i882;
import '../features/reports/domain/usecases/get_dashboard_reports_usecase.dart'
    as _i273;
import '../features/reports/domain/usecases/get_user_activity_use_case.dart'
    as _i1014;
import '../features/reports/domain/usecases/mark_reports_viewed_use_case.dart'
    as _i261;
import '../features/reports/presentation/bloc/reports_bloc.dart' as _i1023;
import '../features/search/data/datasources/ai_product_search_service.dart'
    as _i977;
import '../features/search/data/datasources/recommended_brands_remote_datasource.dart'
    as _i792;
import '../features/search/data/datasources/stock_local_datasource.dart'
    as _i191;
import '../features/search/data/datasources/stock_remote_datasource.dart'
    as _i60;
import '../features/search/data/datasources/vertex_ai_provider.dart' as _i501;
import '../features/search/data/repositories/ai_product_search_repository.dart'
    as _i1008;
import '../features/search/data/repositories/recommended_brands_repository.dart'
    as _i230;
import '../features/search/data/repositories/stock_repository.dart' as _i392;
import '../features/search/domain/interfaces/i_ai_product_search_repository.dart'
    as _i608;
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
import '../features/settings/domain/usecases/get_settings_display_data_usecase.dart'
    as _i594;
import '../features/settings/domain/usecases/get_subscription_status_usecase.dart'
    as _i714;
import '../features/settings/domain/usecases/launch_url_usecase.dart' as _i936;
import '../features/settings/domain/usecases/open_app_settings_usecase.dart'
    as _i579;
import '../features/settings/domain/usecases/reset_password_usecase.dart'
    as _i244;
import '../features/settings/domain/usecases/sign_out_usecase.dart' as _i83;
import '../features/settings/domain/usecases/submit_feedback_usecase.dart'
    as _i526;
import '../features/settings/domain/usecases/toggle_notifications_usecase.dart'
    as _i596;
import '../features/settings/domain/usecases/update_favorite_sector_usecase.dart'
    as _i925;
import '../features/settings/domain/usecases/update_profile_usecase.dart'
    as _i242;
import '../features/settings/presentation/bloc/select_sector_bloc.dart'
    as _i502;
import '../features/settings/presentation/bloc/settings_bloc.dart' as _i419;
import '../features/subscription/data/datasources/subscription_remote_data_source.dart'
    as _i1061;
import '../features/subscription/data/interfaces/i_subscription_remote_data_source.dart'
    as _i592;
import '../features/subscription/data/repositories/subscription_repository_impl.dart'
    as _i221;
import '../features/subscription/di/subscription_module.dart' as _i364;
import '../features/subscription/domain/interfaces/i_subscription_repository.dart'
    as _i659;
import '../features/subscription/domain/usecases/get_offerings_use_case.dart'
    as _i343;
import '../features/subscription/domain/usecases/get_subscription_status_use_case.dart'
    as _i217;
import '../features/subscription/domain/usecases/purchase_subscription_use_case.dart'
    as _i803;
import '../features/subscription/domain/usecases/refresh_subscription_status_use_case.dart'
    as _i423;
import '../features/subscription/domain/usecases/restore_purchases_use_case.dart'
    as _i566;
import '../features/subscription/domain/usecases/sync_identity_use_case.dart'
    as _i15;
import '../features/subscription/domain/usecases/sync_subscription_use_case.dart'
    as _i25;
import '../features/subscription/domain/usecases/watch_subscription_status_use_case.dart'
    as _i630;
import '../features/subscription/presentation/bloc/subscription_bloc.dart'
    as _i1066;
import '../features/user/data/datasources/user_local_datasource.dart' as _i147;
import '../features/user/data/datasources/user_remote_datasource.dart' as _i481;
import '../features/user/data/repositories/user_repository_impl.dart' as _i272;
import '../features/user/domain/interfaces/user_repository.dart' as _i615;
import '../features/user/domain/usecases/get_user_usecase.dart' as _i561;
import '../features/user/domain/usecases/watch_user_usecase.dart' as _i836;
import '../features/user/presentation/bloc/user_bloc.dart' as _i200;
import '../features/watchlist/data/datasources/watchlist_local_datasource.dart'
    as _i114;
import '../features/watchlist/data/datasources/watchlist_remote_datasource.dart'
    as _i444;
import '../features/watchlist/data/repositories/watchlist_repository_impl.dart'
    as _i259;
import '../features/watchlist/domain/interfaces/watchlist_repository.dart'
    as _i1039;
import '../features/watchlist/domain/usecases/add_to_watchlist_usecase.dart'
    as _i258;
import '../features/watchlist/domain/usecases/get_watchlist_usecase.dart'
    as _i759;
import '../features/watchlist/domain/usecases/remove_from_watchlist_usecase.dart'
    as _i320;
import '../features/watchlist/domain/usecases/sync_watchlist_usecase.dart'
    as _i1003;
import '../features/watchlist/presentation/bloc/watchlist_bloc.dart' as _i63;
import '../services/config_service.dart' as _i216;
import '../services/firebase_functions_service.dart' as _i382;
import '../services/firestore_service.dart' as _i52;
import '../services/notification_service.dart' as _i941;
import '../services/permission_service.dart' as _i165;
import 'register_module.dart' as _i291;

const String _qa = 'qa';
const String _dev = 'dev';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    final networkModule = _$NetworkModule();
    final subscriptionModule = _$SubscriptionModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.factory<_i682.PriceChartBloc>(() => _i682.PriceChartBloc());
    gh.singleton<_i809.FirebaseFunctions>(
      () => networkModule.firebaseFunctions,
    );
    await gh.singletonAsync<_i216.ConfigService>(
      () => _i216.ConfigService.init(),
      preResolve: true,
    );
    gh.singleton<_i52.FirestoreService>(() => _i52.FirestoreService.init());
    gh.lazySingleton<_i163.FlutterLocalNotificationsPlugin>(
      () => registerModule.flutterLocalNotificationsPlugin,
    );
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
    gh.lazySingleton<_i833.DeviceInfoPlugin>(() => registerModule.deviceInfo);
    gh.lazySingleton<_i936.LaunchUrlUseCase>(() => _i936.LaunchUrlUseCase());
    gh.lazySingleton<_i526.SubmitFeedbackUseCase>(
      () => _i526.SubmitFeedbackUseCase(),
    );
    gh.factory<_i501.IVertexAIProvider>(() => _i501.VertexAIProvider());
    gh.factory<_i1016.IOnboardingRemoteDataSource>(
      () => _i1016.OnboardingRemoteDataSource(
        gh<_i52.FirestoreService>(),
        gh<_i216.ConfigService>(),
      ),
    );
    gh.factory<_i444.IWatchlistRemoteDataSource>(
      () => _i444.WatchlistRemoteDataSource(gh<_i52.FirestoreService>()),
    );
    gh.factory<_i191.IStockLocalDataSource>(
      () => _i191.StockLocalDataSource(gh<_i460.SharedPreferences>()),
    );
    await gh.singletonAsync<_i982.LocalNotificationDataSource>(() {
      final i = _i982.LocalNotificationDataSource(
        gh<_i163.FlutterLocalNotificationsPlugin>(),
      );
      return i.init().then((_) => i);
    }, preResolve: true);
    gh.factory<_i147.IUserLocalDataSource>(
      () => _i147.UserLocalDataSource(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i6.NetworkInfo>(() => _i6.NetworkInfoImpl());
    gh.singleton<_i915.AppEnv>(() => _i343.QaEnvImpl(), registerFor: {_qa});
    gh.lazySingleton<_i481.IUserRemoteDataSource>(
      () => _i481.UserRemoteDataSource(gh<_i52.FirestoreService>()),
    );
    gh.lazySingleton<_i248.IAppInfoService>(() => _i248.AppInfoServiceImpl());
    gh.factory<_i114.IWatchlistLocalDataSource>(
      () => _i114.WatchlistLocalDataSource(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i202.IPermissionService>(
      () => _i165.PermissionServiceImpl(),
    );
    gh.lazySingleton<_i579.OpenAppSettingsUseCase>(
      () => _i579.OpenAppSettingsUseCase(gh<_i202.IPermissionService>()),
    );
    gh.singleton<_i977.AiProductSearchService>(
      () => _i977.AiProductSearchService(
        gh<_i216.ConfigService>(),
        gh<_i501.IVertexAIProvider>(),
      ),
    );
    gh.factory<_i60.IStockRemoteDataSource>(
      () => _i60.StockRemoteDataSource(gh<_i457.FirebaseStorage>()),
    );
    gh.singleton<_i915.AppEnv>(() => _i343.DevEnvImpl(), registerFor: {_dev});
    gh.lazySingleton<_i532.IReportsRemoteDataSource>(
      () => _i532.ReportsRemoteDataSource(gh<_i52.FirestoreService>()),
    );
    gh.lazySingleton<_i1009.MarketLocalDataSource>(
      () => _i1009.MarketLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i6.ISelectBrandsRemoteDataSource>(
      () => _i6.SelectBrandsRemoteDataSource(gh<_i52.FirestoreService>()),
    );
    gh.factory<_i640.FcmRemoteDataSource>(
      () => _i640.FcmRemoteDataSource(gh<_i892.FirebaseMessaging>()),
    );
    gh.lazySingleton<_i583.ILocalStorageService>(
      () => _i1003.LocalStorageService(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i634.NewsFirestoreDataSource>(
      () => _i634.NewsFirestoreDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i958.RatiosFirestoreDataSource>(
      () => _i958.RatiosFirestoreDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i792.IRecommendedBrandsRemoteDataSource>(
      () => _i792.RecommendedBrandsRemoteDataSource(
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i877.RemoteAuthDataSource>(
      () => _i877.RemoteAuthDataSourceImpl(
        gh<_i59.FirebaseAuth>(),
        gh<_i116.GoogleSignIn>(),
      ),
    );
    gh.lazySingleton<_i990.ISelectBrandsRepository>(
      () => _i432.SelectBrandsRepositoryImpl(
        gh<_i6.ISelectBrandsRemoteDataSource>(),
        gh<_i216.ConfigService>(),
      ),
    );
    gh.lazySingleton<_i1039.IWatchlistRepository>(
      () => _i259.WatchlistRepositoryImpl(
        gh<_i444.IWatchlistRemoteDataSource>(),
        gh<_i114.IWatchlistLocalDataSource>(),
        gh<_i892.FirebaseMessaging>(),
      ),
    );
    gh.lazySingleton<_i595.SecurityFirestoreDataSource>(
      () =>
          _i595.SecurityFirestoreDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i806.FinancialStatementsFirestoreDataSource>(
      () => _i806.FinancialStatementsFirestoreDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i741.CompanyFirestoreDataSource>(
      () => _i741.CompanyFirestoreDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i456.IStockRepository>(
      () => _i392.StockRepository(
        gh<_i60.IStockRemoteDataSource>(),
        gh<_i191.IStockLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i347.IFirebaseFunctionsService>(
      () => _i382.FirebaseFunctionsService(gh<_i809.FirebaseFunctions>()),
    );
    gh.singleton<_i915.AppEnv>(() => _i343.ProdEnvImpl(), registerFor: {_prod});
    gh.lazySingleton<_i584.DividendsFirestoreDataSource>(
      () =>
          _i584.DividendsFirestoreDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.singleton<_i361.Dio>(
      () => networkModule.fmpDio(gh<_i216.ConfigService>(), gh<_i915.AppEnv>()),
      instanceName: 'FmpDio',
    );
    gh.lazySingleton<_i379.BusinessFirestoreDataSource>(
      () =>
          _i379.BusinessFirestoreDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i1043.NewsRemoteDataSource>(
      () => _i1043.NewsRemoteDataSourceImpl(
        gh<_i361.Dio>(instanceName: 'FmpDio'),
        gh<_i216.ConfigService>(),
      ),
    );
    gh.lazySingleton<_i329.IOnboardingRepository>(
      () => _i379.OnboardingRepositoryImpl(
        gh<_i1016.IOnboardingRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i481.SecurityRemoteDataSource>(
      () => _i481.SecurityRemoteDataSourceImpl(
        gh<_i361.Dio>(instanceName: 'FmpDio'),
        gh<_i216.ConfigService>(),
      ),
    );
    gh.lazySingleton<_i876.IPriceRepository>(
      () => _i952.PriceRepositoryImpl(
        gh<_i481.SecurityRemoteDataSource>(),
        gh<_i595.SecurityFirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i592.ISubscriptionRemoteDataSource>(
      () => _i1061.SubscriptionRemoteDataSource(gh<_i915.AppEnv>()),
      registerFor: {_prod, _qa, _dev},
    );
    gh.lazySingleton<_i1012.IRecommendedBrandsRepository>(
      () => _i230.RecommendedBrandsRepository(
        gh<_i792.IRecommendedBrandsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i608.IAiProductSearchRepository>(
      () =>
          _i1008.AiProductSearchRepository(gh<_i977.AiProductSearchService>()),
    );
    gh.lazySingleton<_i15.INewsRepository>(
      () => _i368.NewsRepositoryImpl(
        gh<_i1043.NewsRemoteDataSource>(),
        gh<_i634.NewsFirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i622.INotificationRepository>(
      () => _i648.NotificationRepositoryImpl(gh<_i640.FcmRemoteDataSource>()),
    );
    gh.factory<_i422.GetDailyBrandsUseCase>(
      () => _i422.GetDailyBrandsUseCase(gh<_i990.ISelectBrandsRepository>()),
    );
    gh.lazySingleton<_i654.GetCompanyNewsUseCase>(
      () => _i654.GetCompanyNewsUseCase(gh<_i15.INewsRepository>()),
    );
    gh.lazySingleton<_i454.MarketRemoteDataSource>(
      () => _i454.MarketRemoteDataSourceImpl(
        gh<_i361.Dio>(instanceName: 'FmpDio'),
        gh<_i216.ConfigService>(),
      ),
    );
    gh.factory<_i920.GetSectorsUseCase>(
      () => _i920.GetSectorsUseCase(gh<_i329.IOnboardingRepository>()),
    );
    gh.factory<_i952.GetSp500HistoryUseCase>(
      () => _i952.GetSp500HistoryUseCase(gh<_i329.IOnboardingRepository>()),
    );
    gh.lazySingleton<_i348.FinancialStatementsRemoteDataSource>(
      () => _i348.FinancialStatementsRemoteDataSourceImpl(
        gh<_i361.Dio>(instanceName: 'FmpDio'),
        gh<_i216.ConfigService>(),
      ),
    );
    gh.lazySingleton<_i814.INetIncomeRepository>(
      () => _i13.NetIncomeRepositoryImpl(
        gh<_i348.FinancialStatementsRemoteDataSource>(),
        gh<_i806.FinancialStatementsFirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i473.DividendsRemoteDataSource>(
      () => _i473.DividendsRemoteDataSourceImpl(
        gh<_i361.Dio>(instanceName: 'FmpDio'),
        gh<_i216.ConfigService>(),
      ),
    );
    gh.lazySingleton<_i659.ISubscriptionRepository>(
      () => _i221.SubscriptionRepositoryImpl(
        gh<_i592.ISubscriptionRemoteDataSource>(),
        gh<_i347.IFirebaseFunctionsService>(),
      ),
    );
    gh.lazySingleton<_i581.IFreeCashFlowRepository>(
      () => _i269.FreeCashFlowRepositoryImpl(
        gh<_i348.FinancialStatementsRemoteDataSource>(),
        gh<_i806.FinancialStatementsFirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i695.IEpsRepository>(
      () => _i390.EpsRepositoryImpl(
        gh<_i348.FinancialStatementsRemoteDataSource>(),
        gh<_i806.FinancialStatementsFirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i882.IReportsRepository>(
      () => _i1028.ReportsRepositoryImpl(
        gh<_i532.IReportsRemoteDataSource>(),
        gh<_i456.IStockRepository>(),
      ),
    );
    gh.lazySingleton<_i865.IFinancialStatementsRepository>(
      () => _i741.FinancialStatementsRepositoryImpl(
        gh<_i348.FinancialStatementsRemoteDataSource>(),
        gh<_i806.FinancialStatementsFirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i685.IAuthRepository>(
      () => _i570.AuthRepositoryImpl(
        remoteDataSource: gh<_i877.RemoteAuthDataSource>(),
        sharedPreferences: gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i468.IDividendRepository>(
      () => _i418.DividendRepositoryImpl(
        gh<_i473.DividendsRemoteDataSource>(),
        gh<_i584.DividendsFirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i423.RatiosRemoteDataSource>(
      () => _i423.RatiosRemoteDataSourceImpl(
        gh<_i361.Dio>(instanceName: 'FmpDio'),
        gh<_i216.ConfigService>(),
      ),
    );
    gh.lazySingleton<_i706.BusinessRemoteDataSource>(
      () => _i706.BusinessRemoteDataSourceImpl(
        gh<_i361.Dio>(instanceName: 'FmpDio'),
        gh<_i216.ConfigService>(),
      ),
    );
    gh.factory<_i258.AddToWatchlistUseCase>(
      () => _i258.AddToWatchlistUseCase(gh<_i1039.IWatchlistRepository>()),
    );
    gh.factory<_i320.RemoveFromWatchlistUseCase>(
      () => _i320.RemoveFromWatchlistUseCase(gh<_i1039.IWatchlistRepository>()),
    );
    gh.factory<_i1003.SyncWatchlistUseCase>(
      () => _i1003.SyncWatchlistUseCase(gh<_i1039.IWatchlistRepository>()),
    );
    gh.lazySingleton<_i759.GetWatchlistUseCase>(
      () => _i759.GetWatchlistUseCase(gh<_i1039.IWatchlistRepository>()),
    );
    gh.lazySingleton<_i269.StockSearchService>(
      () => _i269.StockSearchService(gh<_i456.IStockRepository>()),
    );
    gh.lazySingleton<_i203.IRevenueRepository>(
      () => _i517.RevenueRepositoryImpl(
        gh<_i348.FinancialStatementsRemoteDataSource>(),
        gh<_i806.FinancialStatementsFirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i286.CompanyRemoteDataSource>(
      () => _i286.CompanyRemoteDataSourceImpl(
        gh<_i361.Dio>(instanceName: 'FmpDio'),
        gh<_i216.ConfigService>(),
      ),
    );
    gh.lazySingleton<_i368.IFcpsRepository>(
      () => _i724.FcpsRepositoryImpl(
        gh<_i348.FinancialStatementsRemoteDataSource>(),
        gh<_i806.FinancialStatementsFirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i805.GetFcpsStatsUseCase>(
      () => _i805.GetFcpsStatsUseCase(gh<_i368.IFcpsRepository>()),
    );
    gh.lazySingleton<_i925.GetHistoricalEodPricesUseCase>(
      () => _i925.GetHistoricalEodPricesUseCase(gh<_i876.IPriceRepository>()),
    );
    gh.lazySingleton<_i605.GetPriceHistoryUseCase>(
      () => _i605.GetPriceHistoryUseCase(gh<_i876.IPriceRepository>()),
    );
    gh.lazySingleton<_i376.ICompanyRepository>(
      () => _i568.CompanyRepositoryImpl(
        gh<_i286.CompanyRemoteDataSource>(),
        gh<_i741.CompanyFirestoreDataSource>(),
      ),
    );
    gh.factory<_i63.WatchlistBloc>(
      () => _i63.WatchlistBloc(
        gh<_i759.GetWatchlistUseCase>(),
        gh<_i258.AddToWatchlistUseCase>(),
        gh<_i320.RemoveFromWatchlistUseCase>(),
        gh<_i1003.SyncWatchlistUseCase>(),
        gh<_i685.IAuthRepository>(),
      ),
    );
    gh.factory<_i205.ReauthenticateUseCase>(
      () => _i205.ReauthenticateUseCase(gh<_i685.IAuthRepository>()),
    );
    gh.factory<_i797.ChangePasswordUseCase>(
      () => _i797.ChangePasswordUseCase(gh<_i685.IAuthRepository>()),
    );
    gh.factory<_i5.DeleteAccountUseCase>(
      () => _i5.DeleteAccountUseCase(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i427.GetAuthStream>(
      () => _i427.GetAuthStream(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i318.GetCurrentUser>(
      () => _i318.GetCurrentUser(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i244.ResetPasswordUseCase>(
      () => _i244.ResetPasswordUseCase(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i607.IMarketRepository>(
      () => _i27.MarketRepositoryImpl(
        gh<_i454.MarketRemoteDataSource>(),
        gh<_i1009.MarketLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i693.GetRecommendedBrandsUseCase>(
      () => _i693.GetRecommendedBrandsUseCase(
        gh<_i1012.IRecommendedBrandsRepository>(),
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
    gh.lazySingleton<_i786.ISharesRepository>(
      () => _i272.SharesRepositoryImpl(
        gh<_i376.ICompanyRepository>(),
        gh<_i348.FinancialStatementsRemoteDataSource>(),
        gh<_i806.FinancialStatementsFirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i943.IPeRatioRepository>(
      () => _i260.PeRatioRepositoryImpl(
        gh<_i423.RatiosRemoteDataSource>(),
        gh<_i958.RatiosFirestoreDataSource>(),
      ),
    );
    gh.factory<_i691.FindStockForProductUseCase>(
      () => _i691.FindStockForProductUseCase(
        gh<_i608.IAiProductSearchRepository>(),
      ),
    );
    gh.lazySingleton<_i343.GetOfferingsUseCase>(
      () => _i343.GetOfferingsUseCase(gh<_i659.ISubscriptionRepository>()),
    );
    gh.lazySingleton<_i217.GetSubscriptionStatusUseCase>(
      () => _i217.GetSubscriptionStatusUseCase(
        gh<_i659.ISubscriptionRepository>(),
      ),
    );
    gh.lazySingleton<_i803.PurchaseSubscriptionUseCase>(
      () => _i803.PurchaseSubscriptionUseCase(
        gh<_i659.ISubscriptionRepository>(),
      ),
    );
    gh.lazySingleton<_i423.RefreshSubscriptionStatusUseCase>(
      () => _i423.RefreshSubscriptionStatusUseCase(
        gh<_i659.ISubscriptionRepository>(),
      ),
    );
    gh.lazySingleton<_i566.RestorePurchasesUseCase>(
      () => _i566.RestorePurchasesUseCase(gh<_i659.ISubscriptionRepository>()),
    );
    gh.lazySingleton<_i15.SyncIdentityUseCase>(
      () => _i15.SyncIdentityUseCase(gh<_i659.ISubscriptionRepository>()),
    );
    gh.lazySingleton<_i25.SyncSubscriptionUseCase>(
      () => _i25.SyncSubscriptionUseCase(gh<_i659.ISubscriptionRepository>()),
    );
    gh.lazySingleton<_i630.WatchSubscriptionStatusUseCase>(
      () => _i630.WatchSubscriptionStatusUseCase(
        gh<_i659.ISubscriptionRepository>(),
      ),
    );
    gh.factory<_i178.CompanyFcpsBloc>(
      () => _i178.CompanyFcpsBloc(gh<_i805.GetFcpsStatsUseCase>()),
    );
    gh.lazySingleton<_i1019.IPfcfRatioRepository>(
      () => _i398.PfcfRatioRepositoryImpl(
        gh<_i423.RatiosRemoteDataSource>(),
        gh<_i958.RatiosFirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i775.GetNetIncomeStatsUseCase>(
      () => _i775.GetNetIncomeStatsUseCase(gh<_i814.INetIncomeRepository>()),
    );
    gh.lazySingleton<_i584.GetRevenueStatsUseCase>(
      () => _i584.GetRevenueStatsUseCase(gh<_i203.IRevenueRepository>()),
    );
    gh.lazySingleton<_i106.GetFreeCashFlowStatsUseCase>(
      () => _i106.GetFreeCashFlowStatsUseCase(
        gh<_i581.IFreeCashFlowRepository>(),
      ),
    );
    gh.factory<_i501.CompanyNewsBloc>(
      () => _i501.CompanyNewsBloc(gh<_i654.GetCompanyNewsUseCase>()),
    );
    gh.lazySingleton<_i1025.IRoeRepository>(
      () => _i218.RoeRepositoryImpl(
        gh<_i423.RatiosRemoteDataSource>(),
        gh<_i958.RatiosFirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i240.GetSharesUseCase>(
      () => _i240.GetSharesUseCase(gh<_i786.ISharesRepository>()),
    );
    gh.lazySingleton<_i657.GetPeRatioUseCase>(
      () => _i657.GetPeRatioUseCase(gh<_i943.IPeRatioRepository>()),
    );
    gh.lazySingleton<_i231.GetRoeUseCase>(
      () => _i231.GetRoeUseCase(gh<_i1025.IRoeRepository>()),
    );
    gh.factory<_i614.CompanyNetIncomeBloc>(
      () => _i614.CompanyNetIncomeBloc(gh<_i775.GetNetIncomeStatsUseCase>()),
    );
    gh.factory<_i806.CompanyRevenueBloc>(
      () => _i806.CompanyRevenueBloc(gh<_i584.GetRevenueStatsUseCase>()),
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
    gh.lazySingleton<_i1054.GetBalanceSheetsUseCase>(
      () => _i1054.GetBalanceSheetsUseCase(
        gh<_i865.IFinancialStatementsRepository>(),
      ),
    );
    gh.lazySingleton<_i64.GetCashFlowStatementsUseCase>(
      () => _i64.GetCashFlowStatementsUseCase(
        gh<_i865.IFinancialStatementsRepository>(),
      ),
    );
    gh.lazySingleton<_i606.GetFullFinancialsUseCase>(
      () => _i606.GetFullFinancialsUseCase(
        gh<_i865.IFinancialStatementsRepository>(),
      ),
    );
    gh.lazySingleton<_i204.GetIncomeStatementsUseCase>(
      () => _i204.GetIncomeStatementsUseCase(
        gh<_i865.IFinancialStatementsRepository>(),
      ),
    );
    gh.factory<_i130.SearchStocksUseCase>(
      () => _i130.SearchStocksUseCase(gh<_i269.StockSearchService>()),
    );
    gh.lazySingleton<_i83.SignOutUseCase>(
      () => _i83.SignOutUseCase(
        gh<_i685.IAuthRepository>(),
        gh<_i659.ISubscriptionRepository>(),
      ),
    );
    gh.lazySingleton<_i714.GetSubscriptionStatusUseCase>(
      () => _i714.GetSubscriptionStatusUseCase(
        gh<_i659.ISubscriptionRepository>(),
      ),
    );
    gh.lazySingleton<_i273.GetDashboardReportsUseCase>(
      () => _i273.GetDashboardReportsUseCase(gh<_i882.IReportsRepository>()),
    );
    gh.factory<_i1014.GetUserActivityUseCase>(
      () => _i1014.GetUserActivityUseCase(gh<_i882.IReportsRepository>()),
    );
    gh.factory<_i261.MarkReportsViewedUseCase>(
      () => _i261.MarkReportsViewedUseCase(gh<_i882.IReportsRepository>()),
    );
    gh.lazySingleton<_i107.GetEpsStatsUseCase>(
      () => _i107.GetEpsStatsUseCase(gh<_i695.IEpsRepository>()),
    );
    gh.factory<_i423.CompanyPeRatioBloc>(
      () => _i423.CompanyPeRatioBloc(gh<_i657.GetPeRatioUseCase>()),
    );
    gh.factory<_i980.ChangePasswordBloc>(
      () => _i980.ChangePasswordBloc(gh<_i797.ChangePasswordUseCase>()),
    );
    gh.lazySingleton<_i158.ISecurityRepository>(
      () => _i503.SecurityRepositoryImpl(
        gh<_i376.ICompanyRepository>(),
        gh<_i481.SecurityRemoteDataSource>(),
        gh<_i595.SecurityFirestoreDataSource>(),
        gh<_i423.RatiosRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i615.IUserRepository>(
      () => _i272.UserRepositoryImpl(
        gh<_i481.IUserRemoteDataSource>(),
        gh<_i147.IUserLocalDataSource>(),
        gh<_i685.IAuthRepository>(),
      ),
    );
    gh.factory<_i754.GetDividendInfoUseCase>(
      () => _i754.GetDividendInfoUseCase(gh<_i468.IDividendRepository>()),
    );
    gh.lazySingleton<_i912.GetPfcfRatioUseCase>(
      () => _i912.GetPfcfRatioUseCase(gh<_i1019.IPfcfRatioRepository>()),
    );
    gh.lazySingleton<_i59.AuthBloc>(
      () => _i59.AuthBloc(
        getAuthStream: gh<_i427.GetAuthStream>(),
        getCurrentUser: gh<_i318.GetCurrentUser>(),
        signInWithGoogle: gh<_i345.SignInWithGoogle>(),
        signInWithApple: gh<_i538.SignInWithApple>(),
        signInWithEmail: gh<_i33.SignInWithEmail>(),
        signUpWithEmail: gh<_i588.SignUpWithEmail>(),
        signOut: gh<_i472.SignOut>(),
        resetPassword: gh<_i73.ResetPassword>(),
        deleteAccount: gh<_i739.DeleteAccount>(),
      ),
    );
    gh.factory<_i191.FinancialStatementsBloc>(
      () => _i191.FinancialStatementsBloc(
        gh<_i204.GetIncomeStatementsUseCase>(),
        gh<_i1054.GetBalanceSheetsUseCase>(),
        gh<_i64.GetCashFlowStatementsUseCase>(),
      ),
    );
    gh.factory<_i1033.CompanyRoeBloc>(
      () => _i1033.CompanyRoeBloc(gh<_i231.GetRoeUseCase>()),
    );
    gh.factory<_i342.HistoricalPriceEodBloc>(
      () => _i342.HistoricalPriceEodBloc(
        gh<_i925.GetHistoricalEodPricesUseCase>(),
      ),
    );
    gh.lazySingleton<_i872.IBusinessRepository>(
      () => _i606.BusinessRepositoryImpl(
        gh<_i376.ICompanyRepository>(),
        gh<_i706.BusinessRemoteDataSource>(),
        gh<_i379.BusinessFirestoreDataSource>(),
        gh<_i348.FinancialStatementsRemoteDataSource>(),
        gh<_i806.FinancialStatementsFirestoreDataSource>(),
      ),
    );
    gh.factory<_i723.CompanyDividendsBloc>(
      () => _i723.CompanyDividendsBloc(gh<_i754.GetDividendInfoUseCase>()),
    );
    await gh.lazySingletonAsync<_i430.INotificationService>(() {
      final i = _i941.NotificationService(
        gh<_i622.INotificationRepository>(),
        gh<_i982.LocalNotificationDataSource>(),
        gh<_i833.DeviceInfoPlugin>(),
        gh<_i892.FirebaseMessaging>(),
        gh<_i583.ILocalStorageService>(),
        gh<_i615.IUserRepository>(),
      );
      return i.initialize().then((_) => i);
    }, preResolve: true);
    gh.lazySingleton<_i961.ClearCachedToken>(
      () => _i961.ClearCachedToken(gh<_i430.INotificationService>()),
    );
    gh.factory<_i62.CompanyPfcfRatioBloc>(
      () => _i62.CompanyPfcfRatioBloc(gh<_i912.GetPfcfRatioUseCase>()),
    );
    gh.lazySingleton<_i687.Stream<bool>>(
      () => subscriptionModule.isSubscribedStream(gh<_i615.IUserRepository>()),
      instanceName: 'isSubscribedStream',
    );
    gh.factory<_i807.CompanySharesBloc>(
      () => _i807.CompanySharesBloc(gh<_i240.GetSharesUseCase>()),
    );
    gh.lazySingleton<_i561.GetUserUseCase>(
      () => _i561.GetUserUseCase(gh<_i615.IUserRepository>()),
    );
    gh.factory<_i586.UpdateProfileUseCase>(
      () => _i586.UpdateProfileUseCase(
        gh<_i615.IUserRepository>(),
        gh<_i685.IAuthRepository>(),
      ),
    );
    gh.lazySingleton<_i925.UpdateFavoriteSectorUseCase>(
      () => _i925.UpdateFavoriteSectorUseCase(
        gh<_i615.IUserRepository>(),
        gh<_i685.IAuthRepository>(),
      ),
    );
    gh.factoryParam<_i502.SelectSectorBloc, _i162.Sector?, dynamic>(
      (initialSector, _) => _i502.SelectSectorBloc(
        initialSector,
        gh<_i925.UpdateFavoriteSectorUseCase>(),
        gh<_i216.ConfigService>(),
      ),
    );
    gh.factory<_i991.CompanyFreeCashFlowBloc>(
      () => _i991.CompanyFreeCashFlowBloc(
        gh<_i106.GetFreeCashFlowStatsUseCase>(),
      ),
    );
    gh.lazySingleton<_i242.UpdateProfileUseCase>(
      () => _i242.UpdateProfileUseCase(gh<_i615.IUserRepository>()),
    );
    gh.lazySingleton<_i836.WatchUserUseCase>(
      () => _i836.WatchUserUseCase(gh<_i615.IUserRepository>()),
    );
    gh.lazySingleton<_i190.GetSecurityDetailsUseCase>(
      () => _i190.GetSecurityDetailsUseCase(gh<_i158.ISecurityRepository>()),
    );
    gh.lazySingleton<_i1055.GetUpcomingEarningsUseCase>(
      () => _i1055.GetUpcomingEarningsUseCase(gh<_i158.ISecurityRepository>()),
    );
    gh.lazySingleton<_i594.GetSettingsDisplayDataUseCase>(
      () => _i594.GetSettingsDisplayDataUseCase(
        gh<_i685.IAuthRepository>(),
        gh<_i615.IUserRepository>(),
        gh<_i659.ISubscriptionRepository>(),
        gh<_i248.IAppInfoService>(),
        gh<_i430.INotificationService>(),
      ),
    );
    gh.factory<_i1023.ReportsBloc>(
      () => _i1023.ReportsBloc(
        gh<_i273.GetDashboardReportsUseCase>(),
        gh<_i1039.IWatchlistRepository>(),
        gh<_i685.IAuthRepository>(),
        gh<_i1014.GetUserActivityUseCase>(),
        gh<_i261.MarkReportsViewedUseCase>(),
        gh<_i615.IUserRepository>(),
      ),
    );
    gh.factory<_i683.CompanyEpsBloc>(
      () => _i683.CompanyEpsBloc(gh<_i107.GetEpsStatsUseCase>()),
    );
    gh.factory<_i687.NotificationBloc>(
      () => _i687.NotificationBloc(
        gh<_i332.RequestNotificationPermission>(),
        gh<_i69.GetFcmToken>(),
        gh<_i954.ListenToMessages>(),
        gh<_i327.SubscribeToTopic>(),
        gh<_i999.UnsubscribeFromTopic>(),
        gh<_i961.ClearCachedToken>(),
      ),
    );
    gh.lazySingleton<_i596.ToggleNotificationsUseCase>(
      () => _i596.ToggleNotificationsUseCase(
        gh<_i685.IAuthRepository>(),
        gh<_i615.IUserRepository>(),
        gh<_i430.INotificationService>(),
      ),
    );
    gh.lazySingleton<_i687.GetProfileDisplayDataUseCase>(
      () => _i687.GetProfileDisplayDataUseCase(
        gh<_i685.IAuthRepository>(),
        gh<_i615.IUserRepository>(),
        gh<_i607.IMarketRepository>(),
        gh<_i216.ConfigService>(),
      ),
    );
    gh.factory<_i555.GetSearchDashboardDataUseCase>(
      () => _i555.GetSearchDashboardDataUseCase(
        gh<_i685.IAuthRepository>(),
        gh<_i561.GetUserUseCase>(),
        gh<_i693.GetRecommendedBrandsUseCase>(),
      ),
    );
    gh.lazySingleton<_i1066.SubscriptionBloc>(
      () => _i1066.SubscriptionBloc(
        gh<_i630.WatchSubscriptionStatusUseCase>(),
        gh<_i423.RefreshSubscriptionStatusUseCase>(),
        gh<_i15.SyncIdentityUseCase>(),
        gh<_i803.PurchaseSubscriptionUseCase>(),
        gh<_i566.RestorePurchasesUseCase>(),
        gh<_i343.GetOfferingsUseCase>(),
        gh<_i59.AuthBloc>(),
        gh<_i25.SyncSubscriptionUseCase>(),
        gh<_i687.Stream<bool>>(instanceName: 'isSubscribedStream'),
      ),
    );
    gh.factory<_i348.SearchBloc>(
      () => _i348.SearchBloc(
        gh<_i130.SearchStocksUseCase>(),
        gh<_i555.GetSearchDashboardDataUseCase>(),
        gh<_i691.FindStockForProductUseCase>(),
        gh<_i615.IUserRepository>(),
      ),
    );
    gh.factory<_i874.CompleteOnboardingUseCase>(
      () => _i874.CompleteOnboardingUseCase(
        gh<_i329.IOnboardingRepository>(),
        gh<_i430.INotificationService>(),
      ),
    );
    gh.factory<_i73.UpcomingEarningsBloc>(
      () => _i73.UpcomingEarningsBloc(gh<_i1055.GetUpcomingEarningsUseCase>()),
    );
    gh.factory<_i570.ProfileBloc>(
      () => _i570.ProfileBloc(
        gh<_i687.GetProfileDisplayDataUseCase>(),
        gh<_i615.IUserRepository>(),
      ),
    );
    gh.lazySingleton<_i582.GetBusinessProfileUseCase>(
      () => _i582.GetBusinessProfileUseCase(gh<_i872.IBusinessRepository>()),
    );
    gh.factory<_i505.CompanyBusinessBloc>(
      () => _i505.CompanyBusinessBloc(gh<_i582.GetBusinessProfileUseCase>()),
    );
    gh.factory<_i410.CompanySecurityBloc>(
      () => _i410.CompanySecurityBloc(gh<_i190.GetSecurityDetailsUseCase>()),
    );
    gh.factory<_i875.EditProfileBloc>(
      () => _i875.EditProfileBloc(
        gh<_i318.GetCurrentUser>(),
        gh<_i561.GetUserUseCase>(),
        gh<_i586.UpdateProfileUseCase>(),
        gh<_i5.DeleteAccountUseCase>(),
        gh<_i205.ReauthenticateUseCase>(),
      ),
    );
    gh.factory<_i593.OnboardingBloc>(
      () => _i593.OnboardingBloc(
        gh<_i685.IAuthRepository>(),
        gh<_i874.CompleteOnboardingUseCase>(),
        gh<_i920.GetSectorsUseCase>(),
        gh<_i952.GetSp500HistoryUseCase>(),
        gh<_i216.ConfigService>(),
      ),
    );
    gh.lazySingleton<_i200.UserBloc>(
      () => _i200.UserBloc(
        gh<_i561.GetUserUseCase>(),
        gh<_i836.WatchUserUseCase>(),
        gh<_i615.IUserRepository>(),
      ),
    );
    gh.factory<_i419.SettingsBloc>(
      () => _i419.SettingsBloc(
        gh<_i594.GetSettingsDisplayDataUseCase>(),
        gh<_i596.ToggleNotificationsUseCase>(),
        gh<_i526.SubmitFeedbackUseCase>(),
        gh<_i936.LaunchUrlUseCase>(),
        gh<_i83.SignOutUseCase>(),
        gh<_i244.ResetPasswordUseCase>(),
        gh<_i685.IAuthRepository>(),
        gh<_i579.OpenAppSettingsUseCase>(),
        gh<_i714.GetSubscriptionStatusUseCase>(),
      ),
    );
    gh.factory<_i709.SelectBrandsBloc>(
      () => _i709.SelectBrandsBloc(
        gh<_i593.OnboardingBloc>(),
        gh<_i422.GetDailyBrandsUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}

class _$NetworkModule extends _i419.NetworkModule {}

class _$SubscriptionModule extends _i364.SubscriptionModule {}

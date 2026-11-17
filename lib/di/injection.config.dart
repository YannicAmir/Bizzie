// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i688;

import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:cloud_functions/cloud_functions.dart' as _i809;
import 'package:device_info_plus/device_info_plus.dart' as _i833;
import 'package:dio/dio.dart' as _i362;
import 'package:firebase_analytics/firebase_analytics.dart' as _i398;
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

import '../core/analytics/analytics_context.dart' as _i450;
import '../core/domain/interfaces/i_company_filings_repository.dart' as _i657;
import '../core/domain/models/sector.dart' as _i162;
import '../core/interfaces/i_analytics_service.dart' as _i529;
import '../core/interfaces/i_app_info_service.dart' as _i42;
import '../core/interfaces/i_config_service.dart' as _i937;
import '../core/interfaces/i_connectivity_service.dart' as _i28;
import '../core/interfaces/i_device_locale_service.dart' as _i781;
import '../core/interfaces/i_firebase_functions_service.dart' as _i347;
import '../core/interfaces/i_in_app_review_service.dart' as _i65;
import '../core/interfaces/i_lifecycle_service.dart' as _i961;
import '../core/interfaces/i_local_storage_service.dart' as _i583;
import '../core/interfaces/i_notification_service.dart' as _i430;
import '../core/interfaces/i_permission_service.dart' as _i202;
import '../core/interfaces/i_sector_service.dart' as _i1050;
import '../core/interfaces/i_time_provider.dart' as _i879;
import '../core/network/connectivity_service.dart' as _i332;
import '../core/network/network_info.dart' as _i6;
import '../core/network/network_module.dart' as _i421;
import '../core/services/app_info_service.dart' as _i248;
import '../core/services/device_locale_service_impl.dart' as _i894;
import '../core/services/local_storage_service.dart' as _i1003;
import '../core/services/time_provider_impl.dart' as _i157;
import '../env/app_env.dart' as _i915;
import '../env/env_impl.dart' as _i343;
import '../features/app_ratings/data/datasources/app_ratings_local_datasource.dart'
    as _i488;
import '../features/app_ratings/data/interfaces/i_app_ratings_local_datasource.dart'
    as _i705;
import '../features/app_ratings/data/repositories/app_ratings_repository_impl.dart'
    as _i437;
import '../features/app_ratings/domain/interfaces/i_app_ratings_repository.dart'
    as _i507;
import '../features/app_ratings/domain/usecases/track_rating_conditions_usecase.dart'
    as _i849;
import '../features/app_ratings/presentation/analytics/app_ratings_tracker.dart'
    as _i837;
import '../features/app_ratings/presentation/bloc/app_ratings_bloc.dart'
    as _i896;
import '../features/app_status/data/datasources/local_app_status_data_source.dart'
    as _i788;
import '../features/app_status/data/repositories/app_status_repository_impl.dart'
    as _i1044;
import '../features/app_status/domain/interfaces/i_app_status_repository.dart'
    as _i308;
import '../features/app_status/domain/interfaces/i_local_app_status_data_source.dart'
    as _i384;
import '../features/app_status/presentation/analytics/app_status_tracker.dart'
    as _i4;
import '../features/app_status/presentation/bloc/app_status_bloc.dart' as _i984;
import '../features/auth/data/datasources/auth_local_datasource.dart' as _i182;
import '../features/auth/data/datasources/remote_auth_data_source.dart'
    as _i877;
import '../features/auth/data/interfaces/i_auth_local_datasource.dart'
    as _i1025;
import '../features/auth/data/interfaces/i_auth_remote_datasource.dart'
    as _i107;
import '../features/auth/data/repositories/auth_repository_impl.dart' as _i570;
import '../features/auth/domain/interfaces/i_auth_repository.dart' as _i685;
import '../features/auth/domain/usecases/delete_account_usecase.dart' as _i502;
import '../features/auth/domain/usecases/get_auth_stream_usecase.dart' as _i164;
import '../features/auth/domain/usecases/get_current_user_usecase.dart'
    as _i636;
import '../features/auth/domain/usecases/link_with_apple_usecase.dart' as _i596;
import '../features/auth/domain/usecases/link_with_email_usecase.dart' as _i171;
import '../features/auth/domain/usecases/link_with_google_usecase.dart' as _i79;
import '../features/auth/domain/usecases/reauthenticate_usecase.dart' as _i205;
import '../features/auth/domain/usecases/reset_password_usecase.dart' as _i686;
import '../features/auth/domain/usecases/sign_in_anonymously_usecase.dart'
    as _i509;
import '../features/auth/domain/usecases/sign_in_with_apple_usecase.dart'
    as _i598;
import '../features/auth/domain/usecases/sign_in_with_email_usecase.dart'
    as _i356;
import '../features/auth/domain/usecases/sign_in_with_google_usecase.dart'
    as _i635;
import '../features/auth/domain/usecases/sign_out_usecase.dart' as _i190;
import '../features/auth/domain/usecases/sign_up_with_email_usecase.dart'
    as _i1018;
import '../features/auth/presentation/analytics/auth_tracker.dart' as _i701;
import '../features/auth/presentation/bloc/auth_bloc.dart' as _i61;
import '../features/bizzie_chat/data/datasources/bizzie_chat_remote_datasource.dart'
    as _i48;
import '../features/bizzie_chat/data/datasources/chat_rating_remote_datasource.dart'
    as _i750;
import '../features/bizzie_chat/data/interfaces/i_bizzie_chat_remote_datasource.dart'
    as _i364;
import '../features/bizzie_chat/data/interfaces/i_chat_rating_remote_datasource.dart'
    as _i758;
import '../features/bizzie_chat/data/repositories/bizzie_chat_repository_impl.dart'
    as _i495;
import '../features/bizzie_chat/data/repositories/chat_rating_repository_impl.dart'
    as _i747;
import '../features/bizzie_chat/domain/interfaces/i_bizzie_chat_repository.dart'
    as _i711;
import '../features/bizzie_chat/domain/interfaces/i_chat_rating_repository.dart'
    as _i466;
import '../features/bizzie_chat/domain/usecases/get_messages_stream_usecase.dart'
    as _i563;
import '../features/bizzie_chat/domain/usecases/get_sessions_stream_usecase.dart'
    as _i907;
import '../features/bizzie_chat/domain/usecases/send_message_stream_usecase.dart'
    as _i714;
import '../features/bizzie_chat/domain/usecases/send_message_usecase.dart'
    as _i1062;
import '../features/bizzie_chat/domain/usecases/submit_chat_rating_usecase.dart'
    as _i995;
import '../features/bizzie_chat/presentation/bloc/bizzie_chat/bizzie_chat_bloc.dart'
    as _i993;
import '../features/bizzie_chat/presentation/bloc/bizzie_chat_sessions/bizzie_chat_sessions_bloc.dart'
    as _i744;
import '../features/company_profile/ai_reports/domain/usecases/get_company_filings_usecase.dart'
    as _i629;
import '../features/company_profile/ai_reports/presentation/analytics/ai_reports_tab_analytics.dart'
    as _i168;
import '../features/company_profile/ai_reports/presentation/bloc/company_ai_reports_bloc.dart'
    as _i17;
import '../features/company_profile/business/data/datasources/business_firestore_data_source.dart'
    as _i379;
import '../features/company_profile/business/data/interfaces/i_business_firestore_datasource.dart'
    as _i626;
import '../features/company_profile/business/data/repositories/business_repository_impl.dart'
    as _i606;
import '../features/company_profile/business/domain/interfaces/i_business_repository.dart'
    as _i872;
import '../features/company_profile/business/domain/usecases/get_business_profile_usecase.dart'
    as _i582;
import '../features/company_profile/business/presentation/analytics/business_tab_analytics.dart'
    as _i292;
import '../features/company_profile/business/presentation/bloc/company_business_bloc.dart'
    as _i506;
import '../features/company_profile/cp/presentation/analytics/company_profile_analytics.dart'
    as _i228;
import '../features/company_profile/cp/presentation/bloc/company_profile_bloc.dart'
    as _i176;
import '../features/company_profile/cp/presentation/bloc/company_profile_tabs_bloc.dart'
    as _i256;
import '../features/company_profile/cp/presentation/bloc/company_profile_tour_bloc.dart'
    as _i551;
import '../features/company_profile/cp/presentation/bloc/edit_tabs_bloc.dart'
    as _i170;
import '../features/company_profile/dividends/data/datasources/dividends_firestore_data_source.dart'
    as _i584;
import '../features/company_profile/dividends/data/datasources/dividends_remote_data_source.dart'
    as _i473;
import '../features/company_profile/dividends/data/interfaces/i_dividends_firestore_datasource.dart'
    as _i117;
import '../features/company_profile/dividends/data/repositories/dividend_repository_impl.dart'
    as _i418;
import '../features/company_profile/dividends/domain/interfaces/i_dividend_repository.dart'
    as _i468;
import '../features/company_profile/dividends/domain/usecases/get_dividend_info_usecase.dart'
    as _i754;
import '../features/company_profile/dividends/presentation/analytics/dividend_tab_analytics.dart'
    as _i252;
import '../features/company_profile/dividends/presentation/bloc/company_dividends/company_dividends_bloc.dart'
    as _i723;
import '../features/company_profile/eps/data/repositories/eps_repository_impl.dart'
    as _i391;
import '../features/company_profile/eps/domain/interfaces/i_eps_repository.dart'
    as _i695;
import '../features/company_profile/eps/domain/usecases/get_eps_stats_usecase.dart'
    as _i108;
import '../features/company_profile/eps/presentation/analytics/eps_tab_analytics.dart'
    as _i667;
import '../features/company_profile/eps/presentation/bloc/company_eps_bloc.dart'
    as _i683;
import '../features/company_profile/fcps/data/repositories/fcps_repository_impl.dart'
    as _i724;
import '../features/company_profile/fcps/domain/interfaces/i_fcps_repository.dart'
    as _i369;
import '../features/company_profile/fcps/domain/usecases/get_fcps_stats_usecase.dart'
    as _i805;
import '../features/company_profile/fcps/presentation/analytics/fcps_tab_analytics.dart'
    as _i648;
import '../features/company_profile/fcps/presentation/bloc/company_fcps_bloc.dart'
    as _i179;
import '../features/company_profile/financial_statements/data/datasources/financial_statements_firestore_data_source.dart'
    as _i806;
import '../features/company_profile/financial_statements/data/datasources/financial_statements_remote_data_source.dart'
    as _i348;
import '../features/company_profile/financial_statements/data/datasources/frankfurter_remote_data_source_impl.dart'
    as _i77;
import '../features/company_profile/financial_statements/data/datasources/i_exchange_rate_remote_data_source.dart'
    as _i1031;
import '../features/company_profile/financial_statements/data/interfaces/i_financial_statements_firestore_datasource.dart'
    as _i198;
import '../features/company_profile/financial_statements/data/repositories/financial_statements_repository_impl.dart'
    as _i742;
import '../features/company_profile/financial_statements/domain/interfaces/i_financial_statements_repository.dart'
    as _i865;
import '../features/company_profile/financial_statements/domain/usecases/get_balance_sheets_usecase.dart'
    as _i1054;
import '../features/company_profile/financial_statements/domain/usecases/get_cash_flow_statements_usecase.dart'
    as _i64;
import '../features/company_profile/financial_statements/domain/usecases/get_full_financials_usecase.dart'
    as _i609;
import '../features/company_profile/financial_statements/domain/usecases/get_income_statements_usecase.dart'
    as _i206;
import '../features/company_profile/financial_statements/presentation/analytics/bal_stmt_tab_analytics.dart'
    as _i498;
import '../features/company_profile/financial_statements/presentation/analytics/cash_stmt_tab_analytics.dart'
    as _i746;
import '../features/company_profile/financial_statements/presentation/analytics/inc_stmt_tab_analytics.dart'
    as _i906;
import '../features/company_profile/financial_statements/presentation/bloc/financial_statements_bloc.dart'
    as _i194;
import '../features/company_profile/free_cash_flow/data/repositories/free_cash_flow_repository_impl.dart'
    as _i270;
import '../features/company_profile/free_cash_flow/domain/interfaces/i_free_cash_flow_repository.dart'
    as _i581;
import '../features/company_profile/free_cash_flow/domain/usecases/get_free_cash_flow_stats_usecase.dart'
    as _i106;
import '../features/company_profile/free_cash_flow/presentation/analytics/free_cash_flow_tab_analytics.dart'
    as _i167;
import '../features/company_profile/free_cash_flow/presentation/bloc/company_free_cash_flow_bloc.dart'
    as _i991;
import '../features/company_profile/net_income/data/repositories/net_income_repository_impl.dart'
    as _i13;
import '../features/company_profile/net_income/domain/interfaces/i_net_income_repository.dart'
    as _i814;
import '../features/company_profile/net_income/domain/usecases/get_net_income_stats_usecase.dart'
    as _i775;
import '../features/company_profile/net_income/presentation/analytics/net_income_tab_analytics.dart'
    as _i631;
import '../features/company_profile/net_income/presentation/bloc/company_net_income_bloc.dart'
    as _i614;
import '../features/company_profile/news/data/datasources/news_firestore_data_source.dart'
    as _i634;
import '../features/company_profile/news/data/datasources/news_remote_data_source.dart'
    as _i1043;
import '../features/company_profile/news/data/interfaces/i_news_firestore_datasource.dart'
    as _i405;
import '../features/company_profile/news/data/repositories/news_repository_impl.dart'
    as _i368;
import '../features/company_profile/news/domain/interfaces/i_news_repository.dart'
    as _i16;
import '../features/company_profile/news/domain/usecases/get_company_news_usecase.dart'
    as _i654;
import '../features/company_profile/news/presentation/analytics/news_tab_analytics.dart'
    as _i1021;
import '../features/company_profile/news/presentation/bloc/company_news/company_news_bloc.dart'
    as _i505;
import '../features/company_profile/pe_ratio/data/repositories/pe_ratio_repository_impl.dart'
    as _i262;
import '../features/company_profile/pe_ratio/domain/interfaces/i_pe_ratio_repository.dart'
    as _i943;
import '../features/company_profile/pe_ratio/domain/services/pe_ratio_metrics_service.dart'
    as _i304;
import '../features/company_profile/pe_ratio/domain/usecases/get_pe_ratio_usecase.dart'
    as _i660;
import '../features/company_profile/pe_ratio/presentation/analytics/pe_ratio_tab_analytics.dart'
    as _i1027;
import '../features/company_profile/pe_ratio/presentation/bloc/company_pe_ratio_bloc.dart'
    as _i426;
import '../features/company_profile/pfcf_ratio/data/repositories/pfcf_ratio_repository_impl.dart'
    as _i399;
import '../features/company_profile/pfcf_ratio/domain/interfaces/i_pfcf_ratio_repository.dart'
    as _i1019;
import '../features/company_profile/pfcf_ratio/domain/services/pfcf_ratio_stats_service.dart'
    as _i878;
import '../features/company_profile/pfcf_ratio/domain/usecases/get_pfcf_ratio_usecase.dart'
    as _i912;
import '../features/company_profile/pfcf_ratio/presentation/analytics/pfcf_ratio_tab_analytics.dart'
    as _i559;
import '../features/company_profile/pfcf_ratio/presentation/bloc/company_pfcf_ratio_bloc.dart'
    as _i62;
import '../features/company_profile/revenue/data/repositories/revenue_repository_impl.dart'
    as _i517;
import '../features/company_profile/revenue/domain/interfaces/i_revenue_repository.dart'
    as _i203;
import '../features/company_profile/revenue/domain/usecases/get_revenue_stats_usecase.dart'
    as _i585;
import '../features/company_profile/revenue/presentation/analytics/revenue_tab_analytics.dart'
    as _i151;
import '../features/company_profile/revenue/presentation/bloc/company_revenue_bloc.dart'
    as _i810;
import '../features/company_profile/roe/data/repositories/roe_repository_impl.dart'
    as _i218;
import '../features/company_profile/roe/domain/interfaces/i_roe_repository.dart'
    as _i1026;
import '../features/company_profile/roe/domain/services/roe_stats_service.dart'
    as _i1046;
import '../features/company_profile/roe/domain/usecases/get_roe_usecase.dart'
    as _i231;
import '../features/company_profile/roe/presentation/analytics/roe_tab_analytics.dart'
    as _i765;
import '../features/company_profile/roe/presentation/bloc/company_roe_bloc.dart'
    as _i1033;
import '../features/company_profile/security/data/datasources/security_firestore_data_source.dart'
    as _i595;
import '../features/company_profile/security/data/datasources/security_quote_remote_datasource.dart'
    as _i440;
import '../features/company_profile/security/data/datasources/security_remote_data_source.dart'
    as _i482;
import '../features/company_profile/security/data/interfaces/i_security_firestore_datasource.dart'
    as _i486;
import '../features/company_profile/security/data/interfaces/i_security_quote_remote_datasource.dart'
    as _i424;
import '../features/company_profile/security/data/repositories/price_repository_impl.dart'
    as _i952;
import '../features/company_profile/security/data/repositories/security_quote_repository_impl.dart'
    as _i755;
import '../features/company_profile/security/data/repositories/security_repository_impl.dart'
    as _i504;
import '../features/company_profile/security/domain/interfaces/i_price_repository.dart'
    as _i876;
import '../features/company_profile/security/domain/interfaces/i_security_quote_repository.dart'
    as _i620;
import '../features/company_profile/security/domain/interfaces/i_security_repository.dart'
    as _i158;
import '../features/company_profile/security/domain/usecases/get_historical_eod_prices_use_case.dart'
    as _i927;
import '../features/company_profile/security/domain/usecases/get_price_history_usecase.dart'
    as _i605;
import '../features/company_profile/security/domain/usecases/get_security_details_usecase.dart'
    as _i193;
import '../features/company_profile/security/domain/usecases/get_upcoming_earnings_usecase.dart'
    as _i1055;
import '../features/company_profile/security/domain/usecases/watch_security_quote_usecase.dart'
    as _i727;
import '../features/company_profile/security/presentation/analytics/security_tab_analytics.dart'
    as _i258;
import '../features/company_profile/security/presentation/bloc/company_security_bloc.dart'
    as _i410;
import '../features/company_profile/security/presentation/bloc/historical_price_eod/historical_price_eod_bloc.dart'
    as _i342;
import '../features/company_profile/security/presentation/bloc/price_chart/price_chart_bloc.dart'
    as _i682;
import '../features/company_profile/security/presentation/bloc/security_quote/security_quote_bloc.dart'
    as _i213;
import '../features/company_profile/security/presentation/bloc/upcoming_earnings/upcoming_earnings_bloc.dart'
    as _i73;
import '../features/company_profile/segments/data/datasources/segments_firestore_datasource.dart'
    as _i1066;
import '../features/company_profile/segments/data/datasources/segments_remote_datasource.dart'
    as _i574;
import '../features/company_profile/segments/data/interfaces/i_segments_firestore_datasource.dart'
    as _i638;
import '../features/company_profile/segments/data/interfaces/i_segments_remote_datasource.dart'
    as _i333;
import '../features/company_profile/segments/data/repositories/segments_repository_impl.dart'
    as _i90;
import '../features/company_profile/segments/domain/interfaces/i_segments_repository.dart'
    as _i215;
import '../features/company_profile/segments/domain/usecases/get_revenue_geographic_segments_usecase.dart'
    as _i773;
import '../features/company_profile/segments/domain/usecases/get_revenue_product_segments_usecase.dart'
    as _i734;
import '../features/company_profile/segments/presentation/analytics/segments_tab_analytics.dart'
    as _i799;
import '../features/company_profile/segments/presentation/bloc/company_segments_bloc.dart'
    as _i756;
import '../features/company_profile/shared/data/datasources/company_firestore_data_source.dart'
    as _i741;
import '../features/company_profile/shared/data/datasources/company_remote_data_source.dart'
    as _i287;
import '../features/company_profile/shared/data/datasources/ratios_firestore_data_source.dart'
    as _i958;
import '../features/company_profile/shared/data/datasources/ratios_remote_data_source.dart'
    as _i423;
import '../features/company_profile/shared/data/datasources/tab_order_local_datasource.dart'
    as _i726;
import '../features/company_profile/shared/data/interfaces/i_company_firestore_datasource.dart'
    as _i922;
import '../features/company_profile/shared/data/interfaces/i_company_remote_datasource.dart'
    as _i30;
import '../features/company_profile/shared/data/interfaces/i_ratios_firestore_datasource.dart'
    as _i710;
import '../features/company_profile/shared/data/interfaces/i_tab_order_local_datasource.dart'
    as _i415;
import '../features/company_profile/shared/data/repositories/company_repository_impl.dart'
    as _i568;
import '../features/company_profile/shared/data/repositories/exchange_rate_repository_impl.dart'
    as _i112;
import '../features/company_profile/shared/data/repositories/tab_order_repository_impl.dart'
    as _i925;
import '../features/company_profile/shared/domain/interfaces/i_company_repository.dart'
    as _i376;
import '../features/company_profile/shared/domain/interfaces/i_exchange_rate_repository.dart'
    as _i70;
import '../features/company_profile/shared/domain/interfaces/i_tab_activation_service.dart'
    as _i895;
import '../features/company_profile/shared/domain/interfaces/i_tab_order_repository.dart'
    as _i766;
import '../features/company_profile/shared/domain/services/market_hours_freshness_service.dart'
    as _i918;
import '../features/company_profile/shared/domain/services/tab_activation_service.dart'
    as _i618;
import '../features/company_profile/shared/domain/services/tab_content_freshness_service.dart'
    as _i830;
import '../features/company_profile/shared/domain/usecases/get_tab_layout_usecase.dart'
    as _i964;
import '../features/company_profile/shared/domain/usecases/save_tab_layout_usecase.dart'
    as _i630;
import '../features/company_profile/shared/domain/usecases/set_active_tab_usecase.dart'
    as _i713;
import '../features/company_profile/shared/domain/usecases/watch_active_tab_usecase.dart'
    as _i836;
import '../features/company_profile/shares/data/repositories/shares_repository_impl.dart'
    as _i274;
import '../features/company_profile/shares/domain/interfaces/i_shares_repository.dart'
    as _i786;
import '../features/company_profile/shares/domain/services/shares_summary_service.dart'
    as _i889;
import '../features/company_profile/shares/domain/usecases/get_shares_usecase.dart'
    as _i240;
import '../features/company_profile/shares/presentation/analytics/shares_tab_analytics.dart'
    as _i454;
import '../features/company_profile/shares/presentation/bloc/company_shares_bloc.dart'
    as _i808;
import '../features/feedback/data/datasources/feedback_remote_data_source.dart'
    as _i291;
import '../features/feedback/data/repositories/feedback_repository_impl.dart'
    as _i326;
import '../features/feedback/domain/interfaces/i_feedback_repository.dart'
    as _i826;
import '../features/feedback/domain/usecases/submit_feedback_usecase.dart'
    as _i82;
import '../features/feedback/presentation/analytics/feedback_tracker.dart'
    as _i591;
import '../features/feedback/presentation/bloc/feedback_bloc.dart' as _i673;
import '../features/home/data/datasources/watchlist_news_remote_datasource.dart'
    as _i166;
import '../features/home/data/datasources/watchlist_prices_remote_datasource.dart'
    as _i834;
import '../features/home/data/interfaces/i_watchlist_news_remote_datasource.dart'
    as _i745;
import '../features/home/data/interfaces/i_watchlist_prices_remote_datasource.dart'
    as _i784;
import '../features/home/data/repositories/watchlist_news_repository_impl.dart'
    as _i564;
import '../features/home/data/repositories/watchlist_prices_repository_impl.dart'
    as _i434;
import '../features/home/domain/interfaces/i_watchlist_news_repository.dart'
    as _i851;
import '../features/home/domain/interfaces/i_watchlist_prices_repository.dart'
    as _i1047;
import '../features/home/domain/usecases/watch_watchlist_news_usecase.dart'
    as _i510;
import '../features/home/domain/usecases/watch_watchlist_prices_usecase.dart'
    as _i99;
import '../features/home/presentation/analytics/home_analytics.dart' as _i32;
import '../features/home/presentation/bloc/home_bloc.dart' as _i824;
import '../features/home/presentation/bloc/watchlist_news/watchlist_news_bloc.dart'
    as _i770;
import '../features/home/presentation/bloc/watchlist_prices/watchlist_prices_bloc.dart'
    as _i307;
import '../features/market/data/datasources/market_local_datasource.dart'
    as _i1009;
import '../features/market/data/datasources/market_remote_datasource.dart'
    as _i455;
import '../features/market/data/repositories/market_repository_impl.dart'
    as _i27;
import '../features/market/domain/interfaces/i_market_repository.dart' as _i607;
import '../features/market_news/data/datasources/market_news_remote_datasource.dart'
    as _i996;
import '../features/market_news/data/interfaces/i_market_news_remote_datasource.dart'
    as _i601;
import '../features/market_news/data/repositories/market_news_repository_impl.dart'
    as _i419;
import '../features/market_news/domain/interfaces/i_market_news_repository.dart'
    as _i930;
import '../features/market_news/domain/usecases/watch_market_news_usecase.dart'
    as _i954;
import '../features/market_news/presentation/bloc/market_news/market_news_bloc.dart'
    as _i771;
import '../features/notifications/data/datasources/fcm_remote_datasource.dart'
    as _i640;
import '../features/notifications/data/datasources/local_notification_datasource.dart'
    as _i982;
import '../features/notifications/data/repositories/notification_repository_impl.dart'
    as _i649;
import '../features/notifications/domain/interfaces/i_notification_repository.dart'
    as _i622;
import '../features/notifications/domain/usecases/check_notification_permission_usecase.dart'
    as _i390;
import '../features/notifications/domain/usecases/clear_cached_token_usecase.dart'
    as _i940;
import '../features/notifications/domain/usecases/get_fcm_token_usecase.dart'
    as _i311;
import '../features/notifications/domain/usecases/listen_to_messages_usecase.dart'
    as _i615;
import '../features/notifications/domain/usecases/listen_to_notification_interactions_usecase.dart'
    as _i866;
import '../features/notifications/domain/usecases/parse_notification_payload_usecase.dart'
    as _i700;
import '../features/notifications/domain/usecases/request_notification_permission_usecase.dart'
    as _i939;
import '../features/notifications/domain/usecases/setup_notification_interactions_usecase.dart'
    as _i377;
import '../features/notifications/presentation/analytics/notification_tracker.dart'
    as _i1014;
import '../features/notifications/presentation/bloc/notification_bloc.dart'
    as _i689;
import '../features/onboarding/data/datasources/onboarding_remote_datasource.dart'
    as _i1016;
import '../features/onboarding/data/interfaces/i_onboarding_remote_datasource.dart'
    as _i31;
import '../features/onboarding/data/repositories/onboarding_repository_impl.dart'
    as _i380;
import '../features/onboarding/domain/interfaces/i_onboarding_repository.dart'
    as _i329;
import '../features/onboarding/domain/services/guest_username_generator.dart'
    as _i492;
import '../features/onboarding/domain/services/initial_company_resolver.dart'
    as _i709;
import '../features/onboarding/domain/services/onboarding_profile_builder.dart'
    as _i335;
import '../features/onboarding/domain/services/onboarding_watchlist_resolver.dart'
    as _i110;
import '../features/onboarding/domain/services/skipped_onboarding_data_resolver.dart'
    as _i949;
import '../features/onboarding/domain/usecases/complete_onboarding_usecase.dart'
    as _i874;
import '../features/onboarding/domain/usecases/get_sectors_usecase.dart'
    as _i920;
import '../features/onboarding/domain/usecases/get_sp500_history_usecase.dart'
    as _i953;
import '../features/onboarding/domain/usecases/persist_notification_grant_usecase.dart'
    as _i518;
import '../features/onboarding/domain/usecases/resolve_onboarding_user_usecase.dart'
    as _i223;
import '../features/onboarding/domain/usecases/save_onboarding_progress_usecase.dart'
    as _i105;
import '../features/onboarding/domain/usecases/skip_onboarding_usecase.dart'
    as _i115;
import '../features/onboarding/domain/usecases/subscribe_to_notification_topics_usecase.dart'
    as _i461;
import '../features/onboarding/presentation/analytics/onboarding_analytics.dart'
    as _i178;
import '../features/onboarding/presentation/bloc/onboarding_bloc.dart' as _i593;
import '../features/onboarding/select_brands/data/datasources/select_brands_remote_datasource.dart'
    as _i7;
import '../features/onboarding/select_brands/data/repositories/select_brands_repository_impl.dart'
    as _i432;
import '../features/onboarding/select_brands/domain/interfaces/i_select_brands_repository.dart'
    as _i990;
import '../features/onboarding/select_brands/domain/usecases/get_daily_brands_usecase.dart'
    as _i422;
import '../features/onboarding/select_brands/presentation/bloc/select_brands_bloc.dart'
    as _i712;
import '../features/profile/domain/usecases/change_password_usecase.dart'
    as _i797;
import '../features/profile/domain/usecases/delete_account_usecase.dart' as _i5;
import '../features/profile/domain/usecases/get_profile_display_data_usecase.dart'
    as _i690;
import '../features/profile/domain/usecases/update_profile_usecase.dart'
    as _i586;
import '../features/profile/presentation/analytics/profile_tracker.dart'
    as _i963;
import '../features/profile/presentation/bloc/change_password_bloc.dart'
    as _i980;
import '../features/profile/presentation/bloc/edit_profile_bloc.dart' as _i875;
import '../features/profile/presentation/bloc/profile_bloc.dart' as _i571;
import '../features/reports/data/datasources/reports_remote_datasource.dart'
    as _i532;
import '../features/reports/data/interfaces/i_reports_remote_datasource.dart'
    as _i832;
import '../features/reports/data/repositories/company_filings_repository_impl.dart'
    as _i519;
import '../features/reports/data/repositories/reports_repository_impl.dart'
    as _i1028;
import '../features/reports/domain/interfaces/i_reports_repository.dart'
    as _i882;
import '../features/reports/domain/usecases/get_dashboard_reports_usecase.dart'
    as _i273;
import '../features/reports/domain/usecases/get_user_activity_use_case.dart'
    as _i1015;
import '../features/reports/domain/usecases/mark_reports_viewed_use_case.dart'
    as _i261;
import '../features/reports/presentation/analytics/reports_tracker.dart'
    as _i471;
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
import '../features/search/presentation/analytics/search_tracker.dart' as _i687;
import '../features/search/presentation/bloc/search_bloc.dart' as _i349;
import '../features/security/presentation/analytics/security_tracker.dart'
    as _i227;
import '../features/security/presentation/bloc/security_bloc.dart' as _i458;
import '../features/settings/domain/usecases/get_settings_display_data_usecase.dart'
    as _i594;
import '../features/settings/domain/usecases/launch_url_usecase.dart' as _i936;
import '../features/settings/domain/usecases/open_app_settings_usecase.dart'
    as _i579;
import '../features/settings/domain/usecases/sign_out_usecase.dart' as _i83;
import '../features/settings/domain/usecases/toggle_notifications_usecase.dart'
    as _i597;
import '../features/settings/domain/usecases/update_favorite_sector_usecase.dart'
    as _i926;
import '../features/settings/domain/usecases/update_profile_usecase.dart'
    as _i242;
import '../features/settings/presentation/analytics/settings_tracker.dart'
    as _i310;
import '../features/settings/presentation/bloc/select_sector_bloc.dart'
    as _i503;
import '../features/settings/presentation/bloc/settings_bloc.dart' as _i420;
import '../features/subscription/data/datasources/subscription_remote_data_source.dart'
    as _i1061;
import '../features/subscription/data/interfaces/i_subscription_remote_data_source.dart'
    as _i592;
import '../features/subscription/data/repositories/subscription_repository_impl.dart'
    as _i221;
import '../features/subscription/di/subscription_module.dart' as _i365;
import '../features/subscription/domain/interfaces/i_subscription_repository.dart'
    as _i659;
import '../features/subscription/domain/usecases/get_offerings_use_case.dart'
    as _i344;
import '../features/subscription/domain/usecases/get_subscription_status_use_case.dart'
    as _i217;
import '../features/subscription/domain/usecases/purchase_subscription_use_case.dart'
    as _i803;
import '../features/subscription/domain/usecases/refresh_subscription_status_use_case.dart'
    as _i425;
import '../features/subscription/domain/usecases/restore_purchases_use_case.dart'
    as _i566;
import '../features/subscription/domain/usecases/sync_identity_use_case.dart'
    as _i15;
import '../features/subscription/domain/usecases/sync_subscription_use_case.dart'
    as _i25;
import '../features/subscription/domain/usecases/watch_subscription_status_use_case.dart'
    as _i632;
import '../features/subscription/presentation/analytics/paywall_analytics.dart'
    as _i780;
import '../features/subscription/presentation/analytics/subscription_tracker.dart'
    as _i94;
import '../features/subscription/presentation/bloc/subscription_bloc.dart'
    as _i1067;
import '../features/user/data/datasources/user_local_datasource.dart' as _i147;
import '../features/user/data/datasources/user_remote_datasource.dart' as _i481;
import '../features/user/data/interfaces/i_user_local_datasource.dart' as _i957;
import '../features/user/data/interfaces/i_user_remote_datasource.dart'
    as _i938;
import '../features/user/data/repositories/user_repository_impl.dart' as _i272;
import '../features/user/domain/interfaces/i_user_repository.dart' as _i11;
import '../features/user/domain/usecases/get_user_usecase.dart' as _i561;
import '../features/user/domain/usecases/watch_current_user_usecase.dart'
    as _i204;
import '../features/user/domain/usecases/watch_user_usecase.dart' as _i838;
import '../features/user/presentation/bloc/user_bloc.dart' as _i200;
import '../features/watchlist/data/datasources/watchlist_events_local_datasource_impl.dart'
    as _i525;
import '../features/watchlist/data/datasources/watchlist_events_remote_datasource_impl.dart'
    as _i361;
import '../features/watchlist/data/datasources/watchlist_local_datasource.dart'
    as _i114;
import '../features/watchlist/data/datasources/watchlist_remote_datasource.dart'
    as _i444;
import '../features/watchlist/data/interfaces/i_watchlist_events_local_datasource.dart'
    as _i885;
import '../features/watchlist/data/interfaces/i_watchlist_events_remote_datasource.dart'
    as _i827;
import '../features/watchlist/data/interfaces/i_watchlist_local_datasource.dart'
    as _i192;
import '../features/watchlist/data/interfaces/i_watchlist_remote_datasource.dart'
    as _i255;
import '../features/watchlist/data/repositories/watchlist_events_repository_impl.dart'
    as _i587;
import '../features/watchlist/data/repositories/watchlist_repository_impl.dart'
    as _i259;
import '../features/watchlist/domain/interfaces/i_watchlist_events_repository.dart'
    as _i880;
import '../features/watchlist/domain/interfaces/watchlist_repository.dart'
    as _i1039;
import '../features/watchlist/domain/services/watchlist_event_evaluator.dart'
    as _i807;
import '../features/watchlist/domain/usecases/add_to_watchlist_usecase.dart'
    as _i260;
import '../features/watchlist/domain/usecases/get_enriched_watchlist_usecase.dart'
    as _i856;
import '../features/watchlist/domain/usecases/get_watchlist_events_usecase.dart'
    as _i212;
import '../features/watchlist/domain/usecases/get_watchlist_usecase.dart'
    as _i759;
import '../features/watchlist/domain/usecases/remove_from_watchlist_usecase.dart'
    as _i320;
import '../features/watchlist/domain/usecases/sync_watchlist_usecase.dart'
    as _i1004;
import '../features/watchlist/presentation/analytics/watchlist_analytics.dart'
    as _i831;
import '../features/watchlist/presentation/bloc/watchlist_bloc.dart' as _i63;
import '../features/watchlist_ytd/data/datasources/watchlist_ytd_remote_datasource.dart'
    as _i944;
import '../features/watchlist_ytd/data/interfaces/i_watchlist_ytd_remote_datasource.dart'
    as _i302;
import '../features/watchlist_ytd/data/repositories/watchlist_ytd_repository_impl.dart'
    as _i658;
import '../features/watchlist_ytd/domain/interfaces/i_watchlist_ytd_repository.dart'
    as _i983;
import '../features/watchlist_ytd/domain/usecases/get_watchlist_ytd_usecase.dart'
    as _i150;
import '../features/watchlist_ytd/presentation/bloc/watchlist_ytd/watchlist_ytd_bloc.dart'
    as _i1030;
import '../services/analytics_service.dart' as _i222;
import '../services/config_service.dart' as _i216;
import '../services/firebase_functions_service.dart' as _i382;
import '../services/firestore_service.dart' as _i52;
import '../services/in_app_review_service.dart' as _i286;
import '../services/lifecycle_service.dart' as _i1007;
import '../services/notification_service.dart' as _i941;
import '../services/permission_service.dart' as _i165;
import '../services/sector_service.dart' as _i155;
import '../services/security_service.dart' as _i337;
import 'register_module.dart' as _i293;

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
    gh.lazySingleton<_i450.AnalyticsContext>(() => _i450.AnalyticsContext());
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
    gh.lazySingleton<_i398.FirebaseAnalytics>(
      () => registerModule.firebaseAnalytics,
    );
    gh.lazySingleton<_i398.FirebaseAnalyticsObserver>(
      () => registerModule.firebaseAnalyticsObserver,
    );
    gh.lazySingleton<_i833.DeviceInfoPlugin>(() => registerModule.deviceInfo);
    gh.lazySingleton<_i304.PeRatioMetricsService>(
      () => _i304.PeRatioMetricsService(),
    );
    gh.lazySingleton<_i878.PfcfRatioStatsService>(
      () => _i878.PfcfRatioStatsService(),
    );
    gh.lazySingleton<_i1046.RoeStatsService>(() => _i1046.RoeStatsService());
    gh.lazySingleton<_i889.SharesSummaryService>(
      () => _i889.SharesSummaryService(),
    );
    gh.lazySingleton<_i700.ParseNotificationPayloadUseCase>(
      () => _i700.ParseNotificationPayloadUseCase(),
    );
    gh.lazySingleton<_i492.GuestUsernameGenerator>(
      () => _i492.GuestUsernameGenerator(),
    );
    gh.lazySingleton<_i709.InitialCompanyResolver>(
      () => _i709.InitialCompanyResolver(),
    );
    gh.lazySingleton<_i335.OnboardingProfileBuilder>(
      () => _i335.OnboardingProfileBuilder(),
    );
    gh.lazySingleton<_i110.OnboardingWatchlistResolver>(
      () => _i110.OnboardingWatchlistResolver(),
    );
    gh.lazySingleton<_i936.LaunchUrlUseCase>(() => _i936.LaunchUrlUseCase());
    gh.lazySingleton<_i807.WatchlistEventEvaluator>(
      () => _i807.WatchlistEventEvaluator(),
    );
    gh.singleton<_i28.IConnectivityService>(() => _i332.ConnectivityService());
    gh.factory<_i501.IVertexAIProvider>(() => _i501.VertexAIProvider());
    gh.singleton<_i961.ILifecycleService>(
      () => _i1007.LifecycleService(),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i879.ITimeProvider>(() => _i157.TimeProviderImpl());
    gh.lazySingleton<_i6.NetworkInfo>(() => _i6.NetworkInfoImpl());
    await gh.singletonAsync<_i982.LocalNotificationDataSource>(() {
      final i = _i982.LocalNotificationDataSource(
        gh<_i163.FlutterLocalNotificationsPlugin>(),
      );
      return i.init().then((_) => i);
    }, preResolve: true);
    gh.singleton<_i915.AppEnv>(() => _i343.QaEnvImpl(), registerFor: {_qa});
    gh.lazySingleton<_i42.IAppInfoService>(() => _i248.AppInfoServiceImpl());
    gh.lazySingleton<_i202.IPermissionService>(
      () => _i165.PermissionServiceImpl(),
    );
    gh.singleton<_i915.AppEnv>(() => _i343.DevEnvImpl(), registerFor: {_dev});
    gh.lazySingleton<_i65.IInAppReviewService>(
      () => _i286.InAppReviewService(),
    );
    gh.lazySingleton<_i895.ITabActivationService>(
      () => _i618.TabActivationService(),
    );
    gh.lazySingleton<_i781.IDeviceLocaleService>(
      () => _i894.DeviceLocaleServiceImpl(),
    );
    gh.lazySingleton<_i347.IFirebaseFunctionsService>(
      () => _i382.FirebaseFunctionsService(gh<_i809.FirebaseFunctions>()),
    );
    gh.lazySingleton<_i949.SkippedOnboardingDataResolver>(
      () => _i949.SkippedOnboardingDataResolver(
        gh<_i492.GuestUsernameGenerator>(),
      ),
    );
    gh.factory<_i191.IStockLocalDataSource>(
      () => _i191.StockLocalDataSource(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i529.IAnalyticsService>(
      () => _i222.AnalyticsService(gh<_i398.FirebaseAnalytics>()),
    );
    gh.lazySingleton<_i918.MarketHoursFreshnessService>(
      () => _i918.MarketHoursFreshnessService(gh<_i879.ITimeProvider>()),
    );
    gh.lazySingleton<_i830.TabContentFreshnessService>(
      () => _i830.TabContentFreshnessService(gh<_i879.ITimeProvider>()),
    );
    gh.factory<_i640.FcmRemoteDataSource>(
      () => _i640.FcmRemoteDataSource(gh<_i892.FirebaseMessaging>()),
    );
    gh.factory<_i384.ILocalAppStatusDataSource>(
      () => _i788.LocalAppStatusDataSource(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i885.IWatchlistEventsLocalDataSource>(
      () => _i525.WatchlistEventsLocalDataSourceImpl(
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i705.IAppRatingsLocalDataSource>(
      () => _i488.AppRatingsLocalDataSource(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i291.IFeedbackRemoteDataSource>(
      () => _i291.FeedbackRemoteDataSource(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i107.IAuthRemoteDataSource>(
      () => _i877.RemoteAuthDataSourceImpl(
        gh<_i59.FirebaseAuth>(),
        gh<_i116.GoogleSignIn>(),
      ),
    );
    gh.singleton<_i915.AppEnv>(() => _i343.ProdEnvImpl(), registerFor: {_prod});
    gh.lazySingleton<_i52.FirestoreService>(
      () => _i52.FirestoreService(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i792.IRecommendedBrandsRemoteDataSource>(
      () => _i792.RecommendedBrandsRemoteDataSource(
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.factory<_i192.IWatchlistLocalDataSource>(
      () => _i114.WatchlistLocalDataSource(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i745.IWatchlistNewsRemoteDataSource>(
      () => _i166.WatchlistNewsRemoteDataSource(
        gh<_i52.FirestoreService>(),
        gh<_i879.ITimeProvider>(),
      ),
    );
    gh.factory<_i60.IStockRemoteDataSource>(
      () => _i60.StockRemoteDataSource(gh<_i457.FirebaseStorage>()),
    );
    gh.lazySingleton<_i583.ILocalStorageService>(
      () => _i1003.LocalStorageService(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i826.IFeedbackRepository>(
      () => _i326.FeedbackRepositoryImpl(gh<_i291.IFeedbackRemoteDataSource>()),
    );
    gh.factory<_i963.ProfileTracker>(
      () => _i963.ProfileTracker(
        gh<_i529.IAnalyticsService>(),
        gh<_i450.AnalyticsContext>(),
      ),
    );
    gh.lazySingleton<_i1009.MarketLocalDataSource>(
      () => _i1009.MarketLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i832.IReportsRemoteDataSource>(
      () => _i532.ReportsRemoteDataSource(gh<_i52.FirestoreService>()),
    );
    gh.lazySingleton<_i713.SetActiveTabUseCase>(
      () => _i713.SetActiveTabUseCase(gh<_i895.ITabActivationService>()),
    );
    gh.lazySingleton<_i836.WatchActiveTabUseCase>(
      () => _i836.WatchActiveTabUseCase(gh<_i895.ITabActivationService>()),
    );
    gh.factory<_i117.IDividendsFirestoreDataSource>(
      () => _i584.DividendsFirestoreDataSourceImpl(
        gh<_i52.FirestoreService>(),
        gh<_i879.ITimeProvider>(),
      ),
    );
    gh.factory<_i938.IUserRemoteDataSource>(
      () => _i481.UserRemoteDataSource(gh<_i52.FirestoreService>()),
    );
    gh.lazySingleton<_i827.IWatchlistEventsRemoteDataSource>(
      () => _i361.WatchlistEventsRemoteDataSourceImpl(
        gh<_i52.FirestoreService>(),
      ),
    );
    gh.factory<_i626.IBusinessFirestoreDataSource>(
      () => _i379.BusinessFirestoreDataSourceImpl(
        gh<_i52.FirestoreService>(),
        gh<_i879.ITimeProvider>(),
      ),
    );
    gh.lazySingleton<_i579.OpenAppSettingsUseCase>(
      () => _i579.OpenAppSettingsUseCase(gh<_i202.IPermissionService>()),
    );
    gh.factory<_i415.ITabOrderLocalDataSource>(
      () => _i726.TabOrderLocalDataSource(gh<_i583.ILocalStorageService>()),
    );
    await gh.singletonAsync<_i937.IConfigService>(
      () => _i216.ConfigService.init(
        gh<_i915.AppEnv>(),
        gh<_i627.FirebaseRemoteConfig>(),
      ),
      preResolve: true,
    );
    gh.lazySingleton<_i507.IAppRatingsRepository>(
      () => _i437.AppRatingsRepositoryImpl(
        gh<_i705.IAppRatingsLocalDataSource>(),
      ),
    );
    gh.factory<_i837.AppRatingsTracker>(
      () => _i837.AppRatingsTracker(gh<_i529.IAnalyticsService>()),
    );
    gh.factory<_i4.AppStatusTracker>(
      () => _i4.AppStatusTracker(gh<_i529.IAnalyticsService>()),
    );
    gh.factory<_i591.FeedbackTracker>(
      () => _i591.FeedbackTracker(gh<_i529.IAnalyticsService>()),
    );
    gh.factory<_i1014.NotificationTracker>(
      () => _i1014.NotificationTracker(gh<_i529.IAnalyticsService>()),
    );
    gh.factory<_i227.SecurityTracker>(
      () => _i227.SecurityTracker(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i701.AuthTracker>(
      () => _i701.AuthTracker(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i168.AiReportsTabAnalytics>(
      () => _i168.AiReportsTabAnalytics(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i292.BusinessTabAnalytics>(
      () => _i292.BusinessTabAnalytics(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i228.CompanyProfileAnalytics>(
      () => _i228.CompanyProfileAnalytics(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i252.DividendTabAnalytics>(
      () => _i252.DividendTabAnalytics(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i667.EpsTabAnalytics>(
      () => _i667.EpsTabAnalytics(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i648.FcpsTabAnalytics>(
      () => _i648.FcpsTabAnalytics(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i498.BalStmtTabAnalytics>(
      () => _i498.BalStmtTabAnalytics(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i746.CashStmtTabAnalytics>(
      () => _i746.CashStmtTabAnalytics(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i906.IncStmtTabAnalytics>(
      () => _i906.IncStmtTabAnalytics(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i167.FreeCashFlowTabAnalytics>(
      () => _i167.FreeCashFlowTabAnalytics(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i631.NetIncomeTabAnalytics>(
      () => _i631.NetIncomeTabAnalytics(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i1021.NewsTabAnalytics>(
      () => _i1021.NewsTabAnalytics(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i1027.PeRatioTabAnalytics>(
      () => _i1027.PeRatioTabAnalytics(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i559.PfcfRatioTabAnalytics>(
      () => _i559.PfcfRatioTabAnalytics(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i151.RevenueTabAnalytics>(
      () => _i151.RevenueTabAnalytics(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i765.RoeTabAnalytics>(
      () => _i765.RoeTabAnalytics(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i258.SecurityTabAnalytics>(
      () => _i258.SecurityTabAnalytics(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i799.SegmentsTabAnalytics>(
      () => _i799.SegmentsTabAnalytics(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i454.SharesTabAnalytics>(
      () => _i454.SharesTabAnalytics(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i32.HomeAnalytics>(
      () => _i32.HomeAnalytics(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i471.ReportsTracker>(
      () => _i471.ReportsTracker(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i687.SearchTracker>(
      () => _i687.SearchTracker(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i310.SettingsTracker>(
      () => _i310.SettingsTracker(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i780.PaywallAnalytics>(
      () => _i780.PaywallAnalytics(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i94.SubscriptionTracker>(
      () => _i94.SubscriptionTracker(gh<_i529.IAnalyticsService>()),
    );
    gh.lazySingleton<_i831.WatchlistAnalytics>(
      () => _i831.WatchlistAnalytics(gh<_i529.IAnalyticsService>()),
    );
    gh.factory<_i486.ISecurityFirestoreDataSource>(
      () => _i595.SecurityFirestoreDataSourceImpl(
        gh<_i52.FirestoreService>(),
        gh<_i879.ITimeProvider>(),
      ),
    );
    gh.factory<_i302.IWatchlistYtdRemoteDataSource>(
      () => _i944.WatchlistYtdRemoteDataSource(gh<_i52.FirestoreService>()),
    );
    gh.factory<_i784.IWatchlistPricesRemoteDataSource>(
      () => _i834.WatchlistPricesRemoteDataSource(gh<_i52.FirestoreService>()),
    );
    gh.factory<_i1025.IAuthLocalDataSource>(
      () => _i182.AuthLocalDataSource(gh<_i583.ILocalStorageService>()),
    );
    gh.lazySingleton<_i851.IWatchlistNewsRepository>(
      () => _i564.WatchlistNewsRepositoryImpl(
        gh<_i745.IWatchlistNewsRemoteDataSource>(),
      ),
    );
    gh.factory<_i758.IChatRatingRemoteDataSource>(
      () => _i750.ChatRatingRemoteDataSource(gh<_i52.FirestoreService>()),
    );
    gh.factory<_i957.IUserLocalDataSource>(
      () => _i147.UserLocalDataSource(gh<_i583.ILocalStorageService>()),
    );
    gh.factory<_i7.ISelectBrandsRemoteDataSource>(
      () => _i7.SelectBrandsRemoteDataSource(gh<_i52.FirestoreService>()),
    );
    gh.factory<_i405.INewsFirestoreDataSource>(
      () => _i634.NewsFirestoreDataSourceImpl(
        gh<_i52.FirestoreService>(),
        gh<_i879.ITimeProvider>(),
      ),
    );
    gh.factory<_i255.IWatchlistRemoteDataSource>(
      () => _i444.WatchlistRemoteDataSource(gh<_i52.FirestoreService>()),
    );
    gh.singleton<_i362.Dio>(
      () =>
          networkModule.fmpDio(gh<_i937.IConfigService>(), gh<_i915.AppEnv>()),
      instanceName: 'FmpDio',
    );
    gh.lazySingleton<_i1039.IWatchlistRepository>(
      () => _i259.WatchlistRepositoryImpl(
        gh<_i255.IWatchlistRemoteDataSource>(),
        gh<_i192.IWatchlistLocalDataSource>(),
        gh<_i892.FirebaseMessaging>(),
      ),
    );
    gh.factory<_i922.ICompanyFirestoreDataSource>(
      () => _i741.CompanyFirestoreDataSourceImpl(
        gh<_i52.FirestoreService>(),
        gh<_i879.ITimeProvider>(),
      ),
    );
    gh.factory<_i710.IRatiosFirestoreDataSource>(
      () => _i958.RatiosFirestoreDataSourceImpl(
        gh<_i52.FirestoreService>(),
        gh<_i879.ITimeProvider>(),
      ),
    );
    gh.factory<_i198.IFinancialStatementsFirestoreDataSource>(
      () => _i806.FinancialStatementsFirestoreDataSourceImpl(
        gh<_i52.FirestoreService>(),
        gh<_i879.ITimeProvider>(),
      ),
    );
    gh.lazySingleton<_i456.IStockRepository>(
      () => _i392.StockRepository(
        gh<_i60.IStockRemoteDataSource>(),
        gh<_i191.IStockLocalDataSource>(),
      ),
    );
    gh.factory<_i638.ISegmentsFirestoreDataSource>(
      () => _i1066.SegmentsFirestoreDataSourceImpl(
        gh<_i52.FirestoreService>(),
        gh<_i879.ITimeProvider>(),
      ),
    );
    gh.factory<_i424.ISecurityQuoteRemoteDataSource>(
      () => _i440.SecurityQuoteRemoteDataSource(gh<_i52.FirestoreService>()),
    );
    gh.lazySingleton<_i622.INotificationRepository>(
      () => _i649.NotificationRepositoryImpl(gh<_i640.FcmRemoteDataSource>()),
    );
    gh.lazySingleton<_i766.ITabOrderRepository>(
      () => _i925.TabOrderRepositoryImpl(
        gh<_i415.ITabOrderLocalDataSource>(),
        gh<_i937.IConfigService>(),
      ),
    );
    gh.lazySingleton<_i178.OnboardingAnalytics>(
      () => _i178.OnboardingAnalytics(gh<_i529.IAnalyticsService>()),
    );
    gh.factory<_i849.TrackRatingConditionsUseCase>(
      () => _i849.TrackRatingConditionsUseCase(
        gh<_i507.IAppRatingsRepository>(),
        gh<_i937.IConfigService>(),
      ),
    );
    gh.lazySingleton<_i759.GetWatchlistUseCase>(
      () => _i759.GetWatchlistUseCase(gh<_i1039.IWatchlistRepository>()),
    );
    gh.factory<_i260.AddToWatchlistUseCase>(
      () => _i260.AddToWatchlistUseCase(gh<_i1039.IWatchlistRepository>()),
    );
    gh.factory<_i320.RemoveFromWatchlistUseCase>(
      () => _i320.RemoveFromWatchlistUseCase(gh<_i1039.IWatchlistRepository>()),
    );
    gh.factory<_i1004.SyncWatchlistUseCase>(
      () => _i1004.SyncWatchlistUseCase(gh<_i1039.IWatchlistRepository>()),
    );
    gh.lazySingleton<_i592.ISubscriptionRemoteDataSource>(
      () => _i1061.SubscriptionRemoteDataSource(gh<_i915.AppEnv>()),
      registerFor: {_prod, _qa, _dev},
    );
    gh.factory<_i176.CompanyProfileBloc>(
      () => _i176.CompanyProfileBloc(
        gh<_i228.CompanyProfileAnalytics>(),
        gh<_i961.ILifecycleService>(),
      ),
    );
    gh.lazySingleton<_i473.DividendsRemoteDataSource>(
      () => _i473.DividendsRemoteDataSourceImpl(
        gh<_i362.Dio>(instanceName: 'FmpDio'),
        gh<_i937.IConfigService>(),
      ),
    );
    gh.factory<_i30.ICompanyRemoteDataSource>(
      () => _i287.CompanyRemoteDataSourceImpl(
        gh<_i362.Dio>(instanceName: 'FmpDio'),
        gh<_i937.IConfigService>(),
      ),
    );
    gh.lazySingleton<_i423.RatiosRemoteDataSource>(
      () => _i423.RatiosRemoteDataSourceImpl(
        gh<_i362.Dio>(instanceName: 'FmpDio'),
        gh<_i937.IConfigService>(),
      ),
    );
    gh.singleton<_i977.AiProductSearchService>(
      () => _i977.AiProductSearchService(
        gh<_i937.IConfigService>(),
        gh<_i501.IVertexAIProvider>(),
      ),
    );
    gh.lazySingleton<_i657.ICompanyFilingsRepository>(
      () => _i519.CompanyFilingsRepositoryImpl(
        gh<_i832.IReportsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i659.ISubscriptionRepository>(
      () => _i221.SubscriptionRepositoryImpl(
        gh<_i592.ISubscriptionRemoteDataSource>(),
        gh<_i347.IFirebaseFunctionsService>(),
      ),
    );
    gh.lazySingleton<_i455.MarketRemoteDataSource>(
      () => _i455.MarketRemoteDataSourceImpl(
        gh<_i362.Dio>(instanceName: 'FmpDio'),
        gh<_i937.IConfigService>(),
      ),
    );
    gh.lazySingleton<_i685.IAuthRepository>(
      () => _i570.AuthRepositoryImpl(
        gh<_i107.IAuthRemoteDataSource>(),
        gh<_i1025.IAuthLocalDataSource>(),
      ),
    );
    gh.factory<_i31.IOnboardingRemoteDataSource>(
      () => _i1016.OnboardingRemoteDataSource(
        gh<_i52.FirestoreService>(),
        gh<_i937.IConfigService>(),
      ),
    );
    gh.lazySingleton<_i629.GetCompanyFilingsUseCase>(
      () =>
          _i629.GetCompanyFilingsUseCase(gh<_i657.ICompanyFilingsRepository>()),
    );
    gh.lazySingleton<_i11.IUserRepository>(
      () => _i272.UserRepositoryImpl(
        gh<_i938.IUserRemoteDataSource>(),
        gh<_i957.IUserLocalDataSource>(),
        gh<_i685.IAuthRepository>(),
      ),
    );
    gh.singleton<_i362.Dio>(
      () => networkModule.bizzieDio(gh<_i937.IConfigService>()),
      instanceName: 'BizzieDio',
    );
    gh.lazySingleton<_i926.UpdateFavoriteSectorUseCase>(
      () => _i926.UpdateFavoriteSectorUseCase(
        gh<_i11.IUserRepository>(),
        gh<_i685.IAuthRepository>(),
      ),
    );
    gh.factory<_i586.UpdateProfileUseCase>(
      () => _i586.UpdateProfileUseCase(
        gh<_i11.IUserRepository>(),
        gh<_i685.IAuthRepository>(),
      ),
    );
    gh.factory<_i333.ISegmentsRemoteDataSource>(
      () => _i574.SegmentsRemoteDataSourceImpl(
        gh<_i362.Dio>(instanceName: 'FmpDio'),
        gh<_i937.IConfigService>(),
      ),
    );
    gh.lazySingleton<_i269.StockSearchService>(
      () => _i269.StockSearchService(gh<_i456.IStockRepository>()),
    );
    gh.lazySingleton<_i688.Stream<bool>>(
      () => subscriptionModule.isSubscribedStream(gh<_i11.IUserRepository>()),
      instanceName: 'isSubscribedStream',
    );
    gh.lazySingleton<_i348.FinancialStatementsRemoteDataSource>(
      () => _i348.FinancialStatementsRemoteDataSourceImpl(
        gh<_i362.Dio>(instanceName: 'FmpDio'),
        gh<_i937.IConfigService>(),
      ),
    );
    gh.lazySingleton<_i466.IChatRatingRepository>(
      () => _i747.ChatRatingRepositoryImpl(
        gh<_i758.IChatRatingRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i1012.IRecommendedBrandsRepository>(
      () => _i230.RecommendedBrandsRepository(
        gh<_i792.IRecommendedBrandsRemoteDataSource>(),
      ),
    );
    gh.factory<_i601.IMarketNewsRemoteDataSource>(
      () => _i996.MarketNewsRemoteDataSource(
        gh<_i52.FirestoreService>(),
        gh<_i879.ITimeProvider>(),
      ),
    );
    gh.singleton<_i1050.ISectorService>(
      () => _i155.SectorService(gh<_i937.IConfigService>()),
    );
    await gh.singletonAsync<_i337.SecurityService>(
      () => _i337.SecurityService.create(
        gh<_i915.AppEnv>(),
        gh<_i937.IConfigService>(),
        gh<_i685.IAuthRepository>(),
      ),
      preResolve: true,
    );
    gh.factory<_i458.SecurityBloc>(
      () => _i458.SecurityBloc(
        gh<_i337.SecurityService>(),
        gh<_i227.SecurityTracker>(),
      ),
    );
    gh.singleton<_i362.Dio>(
      () => networkModule.frankfurterDio(gh<_i937.IConfigService>()),
      instanceName: 'FrankfurterDio',
    );
    gh.factory<_i824.HomeBloc>(() => _i824.HomeBloc(gh<_i32.HomeAnalytics>()));
    gh.lazySingleton<_i482.SecurityRemoteDataSource>(
      () => _i482.SecurityRemoteDataSourceImpl(
        gh<_i362.Dio>(instanceName: 'FmpDio'),
        gh<_i937.IConfigService>(),
      ),
    );
    gh.lazySingleton<_i390.CheckNotificationPermissionUseCase>(
      () => _i390.CheckNotificationPermissionUseCase(
        gh<_i622.INotificationRepository>(),
      ),
    );
    gh.lazySingleton<_i311.GetFcmTokenUseCase>(
      () => _i311.GetFcmTokenUseCase(gh<_i622.INotificationRepository>()),
    );
    gh.lazySingleton<_i615.ListenToMessagesUseCase>(
      () => _i615.ListenToMessagesUseCase(gh<_i622.INotificationRepository>()),
    );
    gh.lazySingleton<_i939.RequestNotificationPermissionUseCase>(
      () => _i939.RequestNotificationPermissionUseCase(
        gh<_i622.INotificationRepository>(),
      ),
    );
    gh.lazySingleton<_i1043.NewsRemoteDataSource>(
      () => _i1043.NewsRemoteDataSourceImpl(
        gh<_i362.Dio>(instanceName: 'FmpDio'),
        gh<_i937.IConfigService>(),
      ),
    );
    gh.lazySingleton<_i983.IWatchlistYtdRepository>(
      () => _i658.WatchlistYtdRepositoryImpl(
        gh<_i302.IWatchlistYtdRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i594.GetSettingsDisplayDataUseCase>(
      () => _i594.GetSettingsDisplayDataUseCase(
        gh<_i685.IAuthRepository>(),
        gh<_i11.IUserRepository>(),
        gh<_i659.ISubscriptionRepository>(),
        gh<_i42.IAppInfoService>(),
        gh<_i622.INotificationRepository>(),
        gh<_i937.IConfigService>(),
      ),
    );
    gh.factory<_i364.IBizzieChatRemoteDataSource>(
      () => _i48.BizzieChatRemoteDataSource(
        gh<_i362.Dio>(instanceName: 'BizzieDio'),
        gh<_i52.FirestoreService>(),
      ),
    );
    gh.lazySingleton<_i242.UpdateProfileUseCase>(
      () => _i242.UpdateProfileUseCase(gh<_i11.IUserRepository>()),
    );
    gh.lazySingleton<_i204.WatchCurrentUserUseCase>(
      () => _i204.WatchCurrentUserUseCase(gh<_i11.IUserRepository>()),
    );
    gh.lazySingleton<_i838.WatchUserUseCase>(
      () => _i838.WatchUserUseCase(gh<_i11.IUserRepository>()),
    );
    gh.lazySingleton<_i1019.IPfcfRatioRepository>(
      () => _i399.PfcfRatioRepositoryImpl(
        gh<_i423.RatiosRemoteDataSource>(),
        gh<_i710.IRatiosFirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i882.IReportsRepository>(
      () => _i1028.ReportsRepositoryImpl(
        gh<_i832.IReportsRemoteDataSource>(),
        gh<_i456.IStockRepository>(),
      ),
    );
    gh.lazySingleton<_i150.GetWatchlistYtdUseCase>(
      () => _i150.GetWatchlistYtdUseCase(gh<_i983.IWatchlistYtdRepository>()),
    );
    gh.lazySingleton<_i510.WatchWatchlistNewsUseCase>(
      () =>
          _i510.WatchWatchlistNewsUseCase(gh<_i851.IWatchlistNewsRepository>()),
    );
    gh.lazySingleton<_i880.IWatchlistEventsRepository>(
      () => _i587.WatchlistEventsRepositoryImpl(
        gh<_i885.IWatchlistEventsLocalDataSource>(),
        gh<_i827.IWatchlistEventsRemoteDataSource>(),
        gh<_i807.WatchlistEventEvaluator>(),
      ),
    );
    gh.lazySingleton<_i502.DeleteAccountUseCase>(
      () => _i502.DeleteAccountUseCase(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i596.LinkWithAppleUseCase>(
      () => _i596.LinkWithAppleUseCase(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i171.LinkWithEmailUseCase>(
      () => _i171.LinkWithEmailUseCase(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i79.LinkWithGoogleUseCase>(
      () => _i79.LinkWithGoogleUseCase(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i686.ResetPasswordUseCase>(
      () => _i686.ResetPasswordUseCase(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i509.SignInAnonymouslyUseCase>(
      () => _i509.SignInAnonymouslyUseCase(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i598.SignInWithAppleUseCase>(
      () => _i598.SignInWithAppleUseCase(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i356.SignInWithEmailUseCase>(
      () => _i356.SignInWithEmailUseCase(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i635.SignInWithGoogleUseCase>(
      () => _i635.SignInWithGoogleUseCase(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i190.SignOutUseCase>(
      () => _i190.SignOutUseCase(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i1018.SignUpWithEmailUseCase>(
      () => _i1018.SignUpWithEmailUseCase(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i1047.IWatchlistPricesRepository>(
      () => _i434.WatchlistPricesRepositoryImpl(
        gh<_i784.IWatchlistPricesRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i83.SignOutUseCase>(
      () => _i83.SignOutUseCase(
        gh<_i685.IAuthRepository>(),
        gh<_i659.ISubscriptionRepository>(),
      ),
    );
    gh.lazySingleton<_i1026.IRoeRepository>(
      () => _i218.RoeRepositoryImpl(
        gh<_i423.RatiosRemoteDataSource>(),
        gh<_i710.IRatiosFirestoreDataSource>(),
      ),
    );
    gh.factory<_i308.IAppStatusRepository>(
      () => _i1044.AppStatusRepositoryImpl(
        gh<_i937.IConfigService>(),
        gh<_i384.ILocalAppStatusDataSource>(),
        gh<_i28.IConnectivityService>(),
        gh<_i42.IAppInfoService>(),
        gh<_i961.ILifecycleService>(),
      ),
    );
    gh.lazySingleton<_i964.GetTabLayoutUseCase>(
      () => _i964.GetTabLayoutUseCase(gh<_i766.ITabOrderRepository>()),
    );
    gh.lazySingleton<_i630.SaveTabLayoutUseCase>(
      () => _i630.SaveTabLayoutUseCase(gh<_i766.ITabOrderRepository>()),
    );
    gh.lazySingleton<_i376.ICompanyRepository>(
      () => _i568.CompanyRepositoryImpl(
        gh<_i30.ICompanyRemoteDataSource>(),
        gh<_i922.ICompanyFirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i990.ISelectBrandsRepository>(
      () => _i432.SelectBrandsRepositoryImpl(
        gh<_i7.ISelectBrandsRemoteDataSource>(),
        gh<_i1050.ISectorService>(),
      ),
    );
    gh.lazySingleton<_i344.GetOfferingsUseCase>(
      () => _i344.GetOfferingsUseCase(gh<_i659.ISubscriptionRepository>()),
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
    gh.lazySingleton<_i425.RefreshSubscriptionStatusUseCase>(
      () => _i425.RefreshSubscriptionStatusUseCase(
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
    gh.lazySingleton<_i632.WatchSubscriptionStatusUseCase>(
      () => _i632.WatchSubscriptionStatusUseCase(
        gh<_i659.ISubscriptionRepository>(),
      ),
    );
    gh.lazySingleton<_i231.GetRoeUseCase>(
      () => _i231.GetRoeUseCase(
        gh<_i1026.IRoeRepository>(),
        gh<_i1046.RoeStatsService>(),
      ),
    );
    gh.lazySingleton<_i620.ISecurityQuoteRepository>(
      () => _i755.SecurityQuoteRepositoryImpl(
        gh<_i424.ISecurityQuoteRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i273.GetDashboardReportsUseCase>(
      () => _i273.GetDashboardReportsUseCase(gh<_i882.IReportsRepository>()),
    );
    gh.factory<_i1015.GetUserActivityUseCase>(
      () => _i1015.GetUserActivityUseCase(gh<_i882.IReportsRepository>()),
    );
    gh.factory<_i261.MarkReportsViewedUseCase>(
      () => _i261.MarkReportsViewedUseCase(gh<_i882.IReportsRepository>()),
    );
    gh.lazySingleton<_i786.ISharesRepository>(
      () => _i274.SharesRepositoryImpl(
        gh<_i376.ICompanyRepository>(),
        gh<_i348.FinancialStatementsRemoteDataSource>(),
        gh<_i198.IFinancialStatementsFirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i329.IOnboardingRepository>(
      () => _i380.OnboardingRepositoryImpl(
        gh<_i31.IOnboardingRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i711.IBizzieChatRepository>(
      () => _i495.BizzieChatRepositoryImpl(
        gh<_i364.IBizzieChatRemoteDataSource>(),
      ),
    );
    gh.factoryParam<_i503.SelectSectorBloc, _i162.Sector?, dynamic>(
      (initialSector, _) => _i503.SelectSectorBloc(
        initialSector,
        gh<_i926.UpdateFavoriteSectorUseCase>(),
        gh<_i1050.ISectorService>(),
        gh<_i310.SettingsTracker>(),
      ),
    );
    gh.lazySingleton<_i693.GetRecommendedBrandsUseCase>(
      () => _i693.GetRecommendedBrandsUseCase(
        gh<_i1012.IRecommendedBrandsRepository>(),
      ),
    );
    gh.lazySingleton<_i1031.IExchangeRateRemoteDataSource>(
      () => _i77.FrankfurterRemoteDataSourceImpl(
        gh<_i362.Dio>(instanceName: 'FrankfurterDio'),
      ),
    );
    gh.lazySingleton<_i943.IPeRatioRepository>(
      () => _i262.PeRatioRepositoryImpl(
        gh<_i423.RatiosRemoteDataSource>(),
        gh<_i710.IRatiosFirestoreDataSource>(),
      ),
    );
    await gh.lazySingletonAsync<_i430.INotificationService>(() {
      final i = _i941.NotificationService(
        gh<_i622.INotificationRepository>(),
        gh<_i982.LocalNotificationDataSource>(),
        gh<_i833.DeviceInfoPlugin>(),
        gh<_i892.FirebaseMessaging>(),
        gh<_i583.ILocalStorageService>(),
        gh<_i11.IUserRepository>(),
        gh<_i1014.NotificationTracker>(),
      );
      return i.initialize().then((_) => i);
    }, preResolve: true);
    gh.factory<_i205.ReauthenticateUseCase>(
      () => _i205.ReauthenticateUseCase(gh<_i685.IAuthRepository>()),
    );
    gh.factory<_i797.ChangePasswordUseCase>(
      () => _i797.ChangePasswordUseCase(gh<_i685.IAuthRepository>()),
    );
    gh.factory<_i5.DeleteAccountUseCase>(
      () => _i5.DeleteAccountUseCase(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i164.GetAuthStreamUseCase>(
      () => _i164.GetAuthStreamUseCase(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i636.GetCurrentUserUseCase>(
      () => _i636.GetCurrentUserUseCase(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i223.ResolveOnboardingUserUseCase>(
      () => _i223.ResolveOnboardingUserUseCase(gh<_i685.IAuthRepository>()),
    );
    gh.lazySingleton<_i461.SubscribeToNotificationTopicsUseCase>(
      () => _i461.SubscribeToNotificationTopicsUseCase(
        gh<_i622.INotificationRepository>(),
      ),
    );
    gh.lazySingleton<_i940.ClearCachedTokenUseCase>(
      () => _i940.ClearCachedTokenUseCase(gh<_i430.INotificationService>()),
    );
    gh.lazySingleton<_i866.ListenToNotificationInteractionsUseCase>(
      () => _i866.ListenToNotificationInteractionsUseCase(
        gh<_i430.INotificationService>(),
      ),
    );
    gh.lazySingleton<_i377.SetupNotificationInteractionsUseCase>(
      () => _i377.SetupNotificationInteractionsUseCase(
        gh<_i430.INotificationService>(),
      ),
    );
    gh.factory<_i130.SearchStocksUseCase>(
      () => _i130.SearchStocksUseCase(gh<_i269.StockSearchService>()),
    );
    gh.lazySingleton<_i608.IAiProductSearchRepository>(
      () =>
          _i1008.AiProductSearchRepository(gh<_i977.AiProductSearchService>()),
    );
    gh.lazySingleton<_i468.IDividendRepository>(
      () => _i418.DividendRepositoryImpl(
        gh<_i473.DividendsRemoteDataSource>(),
        gh<_i117.IDividendsFirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i876.IPriceRepository>(
      () => _i952.PriceRepositoryImpl(
        gh<_i482.SecurityRemoteDataSource>(),
        gh<_i486.ISecurityFirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i995.SubmitChatRatingUseCase>(
      () => _i995.SubmitChatRatingUseCase(gh<_i466.IChatRatingRepository>()),
    );
    gh.lazySingleton<_i82.SubmitFeedbackUseCase>(
      () => _i82.SubmitFeedbackUseCase(
        gh<_i826.IFeedbackRepository>(),
        gh<_i685.IAuthRepository>(),
        gh<_i430.INotificationService>(),
        gh<_i11.IUserRepository>(),
      ),
    );
    gh.factory<_i920.GetSectorsUseCase>(
      () => _i920.GetSectorsUseCase(gh<_i329.IOnboardingRepository>()),
    );
    gh.factory<_i953.GetSp500HistoryUseCase>(
      () => _i953.GetSp500HistoryUseCase(gh<_i329.IOnboardingRepository>()),
    );
    gh.factory<_i1067.SubscriptionBloc>(
      () => _i1067.SubscriptionBloc(
        gh<_i632.WatchSubscriptionStatusUseCase>(),
        gh<_i425.RefreshSubscriptionStatusUseCase>(),
        gh<_i15.SyncIdentityUseCase>(),
        gh<_i803.PurchaseSubscriptionUseCase>(),
        gh<_i566.RestorePurchasesUseCase>(),
        gh<_i344.GetOfferingsUseCase>(),
        gh<_i164.GetAuthStreamUseCase>(),
        gh<_i636.GetCurrentUserUseCase>(),
        gh<_i25.SyncSubscriptionUseCase>(),
        gh<_i688.Stream<bool>>(instanceName: 'isSubscribedStream'),
        gh<_i780.PaywallAnalytics>(),
        gh<_i94.SubscriptionTracker>(),
        gh<_i937.IConfigService>(),
      ),
    );
    gh.lazySingleton<_i912.GetPfcfRatioUseCase>(
      () => _i912.GetPfcfRatioUseCase(
        gh<_i1019.IPfcfRatioRepository>(),
        gh<_i878.PfcfRatioStatsService>(),
      ),
    );
    gh.lazySingleton<_i607.IMarketRepository>(
      () => _i27.MarketRepositoryImpl(
        gh<_i455.MarketRemoteDataSource>(),
        gh<_i1009.MarketLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i561.GetUserUseCase>(
      () => _i561.GetUserUseCase(gh<_i11.IUserRepository>()),
    );
    gh.lazySingleton<_i240.GetSharesUseCase>(
      () => _i240.GetSharesUseCase(gh<_i786.ISharesRepository>()),
    );
    gh.factory<_i770.WatchlistNewsBloc>(
      () => _i770.WatchlistNewsBloc(
        gh<_i510.WatchWatchlistNewsUseCase>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    gh.lazySingleton<_i930.IMarketNewsRepository>(
      () => _i419.MarketNewsRepositoryImpl(
        gh<_i601.IMarketNewsRemoteDataSource>(),
      ),
    );
    gh.factory<_i691.FindStockForProductUseCase>(
      () => _i691.FindStockForProductUseCase(
        gh<_i608.IAiProductSearchRepository>(),
      ),
    );
    gh.lazySingleton<_i16.INewsRepository>(
      () => _i368.NewsRepositoryImpl(
        gh<_i1043.NewsRemoteDataSource>(),
        gh<_i405.INewsFirestoreDataSource>(),
      ),
    );
    gh.factory<_i673.FeedbackBloc>(
      () => _i673.FeedbackBloc(
        gh<_i82.SubmitFeedbackUseCase>(),
        gh<_i591.FeedbackTracker>(),
      ),
    );
    gh.lazySingleton<_i212.GetWatchlistEventsUseCase>(
      () => _i212.GetWatchlistEventsUseCase(
        gh<_i880.IWatchlistEventsRepository>(),
      ),
    );
    gh.factory<_i555.GetSearchDashboardDataUseCase>(
      () => _i555.GetSearchDashboardDataUseCase(
        gh<_i685.IAuthRepository>(),
        gh<_i561.GetUserUseCase>(),
        gh<_i693.GetRecommendedBrandsUseCase>(),
      ),
    );
    gh.factory<_i1023.ReportsBloc>(
      () => _i1023.ReportsBloc(
        gh<_i273.GetDashboardReportsUseCase>(),
        gh<_i1039.IWatchlistRepository>(),
        gh<_i685.IAuthRepository>(),
        gh<_i1015.GetUserActivityUseCase>(),
        gh<_i261.MarkReportsViewedUseCase>(),
        gh<_i204.WatchCurrentUserUseCase>(),
        gh<_i583.ILocalStorageService>(),
        gh<_i471.ReportsTracker>(),
      ),
    );
    gh.lazySingleton<_i954.WatchMarketNewsUseCase>(
      () => _i954.WatchMarketNewsUseCase(gh<_i930.IMarketNewsRepository>()),
    );
    gh.factory<_i984.AppStatusBloc>(
      () => _i984.AppStatusBloc(
        gh<_i308.IAppStatusRepository>(),
        gh<_i4.AppStatusTracker>(),
      ),
    );
    gh.factory<_i808.CompanySharesBloc>(
      () => _i808.CompanySharesBloc(
        gh<_i240.GetSharesUseCase>(),
        gh<_i937.IConfigService>(),
        gh<_i454.SharesTabAnalytics>(),
        gh<_i836.WatchActiveTabUseCase>(),
        gh<_i879.ITimeProvider>(),
        gh<_i889.SharesSummaryService>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    gh.lazySingleton<_i727.WatchSecurityQuoteUseCase>(
      () =>
          _i727.WatchSecurityQuoteUseCase(gh<_i620.ISecurityQuoteRepository>()),
    );
    gh.lazySingleton<_i158.ISecurityRepository>(
      () => _i504.SecurityRepositoryImpl(
        gh<_i376.ICompanyRepository>(),
        gh<_i482.SecurityRemoteDataSource>(),
        gh<_i486.ISecurityFirestoreDataSource>(),
        gh<_i423.RatiosRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i99.WatchWatchlistPricesUseCase>(
      () => _i99.WatchWatchlistPricesUseCase(
        gh<_i1047.IWatchlistPricesRepository>(),
      ),
    );
    gh.lazySingleton<_i927.GetHistoricalEodPricesUseCase>(
      () => _i927.GetHistoricalEodPricesUseCase(gh<_i876.IPriceRepository>()),
    );
    gh.lazySingleton<_i605.GetPriceHistoryUseCase>(
      () => _i605.GetPriceHistoryUseCase(gh<_i876.IPriceRepository>()),
    );
    gh.factory<_i61.AuthBloc>(
      () => _i61.AuthBloc(
        gh<_i701.AuthTracker>(),
        gh<_i164.GetAuthStreamUseCase>(),
        gh<_i636.GetCurrentUserUseCase>(),
        gh<_i635.SignInWithGoogleUseCase>(),
        gh<_i598.SignInWithAppleUseCase>(),
        gh<_i356.SignInWithEmailUseCase>(),
        gh<_i1018.SignUpWithEmailUseCase>(),
        gh<_i171.LinkWithEmailUseCase>(),
        gh<_i79.LinkWithGoogleUseCase>(),
        gh<_i596.LinkWithAppleUseCase>(),
        gh<_i190.SignOutUseCase>(),
        gh<_i686.ResetPasswordUseCase>(),
        gh<_i502.DeleteAccountUseCase>(),
        gh<_i936.LaunchUrlUseCase>(),
      ),
    );
    gh.lazySingleton<_i660.GetPeRatioUseCase>(
      () => _i660.GetPeRatioUseCase(gh<_i943.IPeRatioRepository>()),
    );
    gh.lazySingleton<_i872.IBusinessRepository>(
      () => _i606.BusinessRepositoryImpl(
        gh<_i376.ICompanyRepository>(),
        gh<_i626.IBusinessFirestoreDataSource>(),
        gh<_i348.FinancialStatementsRemoteDataSource>(),
        gh<_i198.IFinancialStatementsFirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i654.GetCompanyNewsUseCase>(
      () => _i654.GetCompanyNewsUseCase(gh<_i16.INewsRepository>()),
    );
    gh.factory<_i170.EditTabsBloc>(
      () => _i170.EditTabsBloc(gh<_i630.SaveTabLayoutUseCase>()),
    );
    gh.lazySingleton<_i597.ToggleNotificationsUseCase>(
      () => _i597.ToggleNotificationsUseCase(
        gh<_i685.IAuthRepository>(),
        gh<_i11.IUserRepository>(),
        gh<_i430.INotificationService>(),
      ),
    );
    gh.factory<_i307.WatchlistPricesBloc>(
      () => _i307.WatchlistPricesBloc(
        gh<_i99.WatchWatchlistPricesUseCase>(),
        gh<_i759.GetWatchlistUseCase>(),
        gh<_i937.IConfigService>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    gh.lazySingleton<_i563.GetMessagesStreamUseCase>(
      () => _i563.GetMessagesStreamUseCase(gh<_i711.IBizzieChatRepository>()),
    );
    gh.lazySingleton<_i907.GetSessionsStreamUseCase>(
      () => _i907.GetSessionsStreamUseCase(gh<_i711.IBizzieChatRepository>()),
    );
    gh.factory<_i714.SendMessageStreamUseCase>(
      () => _i714.SendMessageStreamUseCase(gh<_i711.IBizzieChatRepository>()),
    );
    gh.factory<_i1062.SendMessageUseCase>(
      () => _i1062.SendMessageUseCase(gh<_i711.IBizzieChatRepository>()),
    );
    gh.factory<_i62.CompanyPfcfRatioBloc>(
      () => _i62.CompanyPfcfRatioBloc(
        gh<_i912.GetPfcfRatioUseCase>(),
        gh<_i937.IConfigService>(),
        gh<_i559.PfcfRatioTabAnalytics>(),
        gh<_i830.TabContentFreshnessService>(),
        gh<_i879.ITimeProvider>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    gh.lazySingleton<_i582.GetBusinessProfileUseCase>(
      () => _i582.GetBusinessProfileUseCase(gh<_i872.IBusinessRepository>()),
    );
    gh.factory<_i689.NotificationBloc>(
      () => _i689.NotificationBloc(
        gh<_i939.RequestNotificationPermissionUseCase>(),
        gh<_i311.GetFcmTokenUseCase>(),
        gh<_i615.ListenToMessagesUseCase>(),
        gh<_i940.ClearCachedTokenUseCase>(),
        gh<_i1014.NotificationTracker>(),
        gh<_i700.ParseNotificationPayloadUseCase>(),
        gh<_i390.CheckNotificationPermissionUseCase>(),
        gh<_i377.SetupNotificationInteractionsUseCase>(),
        gh<_i866.ListenToNotificationInteractionsUseCase>(),
      ),
    );
    gh.factory<_i422.GetDailyBrandsUseCase>(
      () => _i422.GetDailyBrandsUseCase(gh<_i990.ISelectBrandsRepository>()),
    );
    gh.factory<_i420.SettingsBloc>(
      () => _i420.SettingsBloc(
        gh<_i594.GetSettingsDisplayDataUseCase>(),
        gh<_i597.ToggleNotificationsUseCase>(),
        gh<_i936.LaunchUrlUseCase>(),
        gh<_i83.SignOutUseCase>(),
        gh<_i579.OpenAppSettingsUseCase>(),
        gh<_i310.SettingsTracker>(),
      ),
    );
    gh.factory<_i896.AppRatingsBloc>(
      () => _i896.AppRatingsBloc(
        gh<_i849.TrackRatingConditionsUseCase>(),
        gh<_i65.IInAppReviewService>(),
        gh<_i837.AppRatingsTracker>(),
        gh<_i636.GetCurrentUserUseCase>(),
        gh<_i561.GetUserUseCase>(),
        gh<_i937.IConfigService>(),
      ),
    );
    gh.factory<_i875.EditProfileBloc>(
      () => _i875.EditProfileBloc(
        gh<_i636.GetCurrentUserUseCase>(),
        gh<_i561.GetUserUseCase>(),
        gh<_i586.UpdateProfileUseCase>(),
        gh<_i5.DeleteAccountUseCase>(),
        gh<_i205.ReauthenticateUseCase>(),
        gh<_i963.ProfileTracker>(),
      ),
    );
    gh.factory<_i256.CompanyProfileTabsBloc>(
      () => _i256.CompanyProfileTabsBloc(
        gh<_i964.GetTabLayoutUseCase>(),
        gh<_i713.SetActiveTabUseCase>(),
        gh<_i937.IConfigService>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    gh.factory<_i17.CompanyAiReportsBloc>(
      () => _i17.CompanyAiReportsBloc(
        gh<_i629.GetCompanyFilingsUseCase>(),
        gh<_i937.IConfigService>(),
        gh<_i168.AiReportsTabAnalytics>(),
        gh<_i879.ITimeProvider>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    gh.lazySingleton<_i70.IExchangeRateRepository>(
      () => _i112.ExchangeRateRepositoryImpl(
        gh<_i781.IDeviceLocaleService>(),
        gh<_i879.ITimeProvider>(),
        gh<_i1031.IExchangeRateRemoteDataSource>(),
        gh<_i198.IFinancialStatementsFirestoreDataSource>(),
      ),
    );
    gh.factory<_i426.CompanyPeRatioBloc>(
      () => _i426.CompanyPeRatioBloc(
        gh<_i660.GetPeRatioUseCase>(),
        gh<_i937.IConfigService>(),
        gh<_i1027.PeRatioTabAnalytics>(),
        gh<_i304.PeRatioMetricsService>(),
        gh<_i879.ITimeProvider>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    gh.factory<_i712.SelectBrandsBloc>(
      () => _i712.SelectBrandsBloc(
        gh<_i422.GetDailyBrandsUseCase>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    gh.factory<_i1030.WatchlistYtdBloc>(
      () => _i1030.WatchlistYtdBloc(
        gh<_i150.GetWatchlistYtdUseCase>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    gh.factory<_i551.CompanyProfileTourBloc>(
      () => _i551.CompanyProfileTourBloc(
        gh<_i228.CompanyProfileAnalytics>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    gh.factory<_i771.MarketNewsBloc>(
      () => _i771.MarketNewsBloc(gh<_i954.WatchMarketNewsUseCase>()),
    );
    gh.lazySingleton<_i874.CompleteOnboardingUseCase>(
      () => _i874.CompleteOnboardingUseCase(
        gh<_i329.IOnboardingRepository>(),
        gh<_i11.IUserRepository>(),
        gh<_i430.INotificationService>(),
        gh<_i461.SubscribeToNotificationTopicsUseCase>(),
        gh<_i335.OnboardingProfileBuilder>(),
        gh<_i110.OnboardingWatchlistResolver>(),
      ),
    );
    gh.factory<_i1033.CompanyRoeBloc>(
      () => _i1033.CompanyRoeBloc(
        gh<_i231.GetRoeUseCase>(),
        gh<_i937.IConfigService>(),
        gh<_i765.RoeTabAnalytics>(),
        gh<_i879.ITimeProvider>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    gh.lazySingleton<_i193.GetSecurityDetailsUseCase>(
      () => _i193.GetSecurityDetailsUseCase(gh<_i158.ISecurityRepository>()),
    );
    gh.lazySingleton<_i1055.GetUpcomingEarningsUseCase>(
      () => _i1055.GetUpcomingEarningsUseCase(gh<_i158.ISecurityRepository>()),
    );
    gh.factory<_i744.BizzieChatSessionsBloc>(
      () => _i744.BizzieChatSessionsBloc(
        gh<_i907.GetSessionsStreamUseCase>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    gh.lazySingleton<_i856.GetEnrichedWatchlistUseCase>(
      () => _i856.GetEnrichedWatchlistUseCase(
        gh<_i759.GetWatchlistUseCase>(),
        gh<_i212.GetWatchlistEventsUseCase>(),
      ),
    );
    gh.factory<_i200.UserBloc>(
      () => _i200.UserBloc(
        gh<_i561.GetUserUseCase>(),
        gh<_i838.WatchUserUseCase>(),
      ),
    );
    gh.factory<_i980.ChangePasswordBloc>(
      () => _i980.ChangePasswordBloc(
        gh<_i797.ChangePasswordUseCase>(),
        gh<_i963.ProfileTracker>(),
      ),
    );
    gh.factory<_i505.CompanyNewsBloc>(
      () => _i505.CompanyNewsBloc(
        gh<_i654.GetCompanyNewsUseCase>(),
        gh<_i1021.NewsTabAnalytics>(),
        gh<_i836.WatchActiveTabUseCase>(),
        gh<_i879.ITimeProvider>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    gh.factory<_i213.SecurityQuoteBloc>(
      () => _i213.SecurityQuoteBloc(
        gh<_i727.WatchSecurityQuoteUseCase>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    gh.factory<_i754.GetDividendInfoUseCase>(
      () => _i754.GetDividendInfoUseCase(gh<_i468.IDividendRepository>()),
    );
    gh.factory<_i63.WatchlistBloc>(
      () => _i63.WatchlistBloc(
        gh<_i759.GetWatchlistUseCase>(),
        gh<_i856.GetEnrichedWatchlistUseCase>(),
        gh<_i212.GetWatchlistEventsUseCase>(),
        gh<_i260.AddToWatchlistUseCase>(),
        gh<_i320.RemoveFromWatchlistUseCase>(),
        gh<_i1004.SyncWatchlistUseCase>(),
        gh<_i685.IAuthRepository>(),
        gh<_i831.WatchlistAnalytics>(),
      ),
    );
    gh.factory<_i73.UpcomingEarningsBloc>(
      () => _i73.UpcomingEarningsBloc(
        gh<_i1055.GetUpcomingEarningsUseCase>(),
        gh<_i836.WatchActiveTabUseCase>(),
        gh<_i879.ITimeProvider>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    gh.lazySingleton<_i690.GetProfileDisplayDataUseCase>(
      () => _i690.GetProfileDisplayDataUseCase(
        gh<_i685.IAuthRepository>(),
        gh<_i11.IUserRepository>(),
        gh<_i607.IMarketRepository>(),
        gh<_i1050.ISectorService>(),
      ),
    );
    gh.lazySingleton<_i115.SkipOnboardingUseCase>(
      () => _i115.SkipOnboardingUseCase(
        gh<_i223.ResolveOnboardingUserUseCase>(),
        gh<_i329.IOnboardingRepository>(),
        gh<_i949.SkippedOnboardingDataResolver>(),
        gh<_i874.CompleteOnboardingUseCase>(),
        gh<_i709.InitialCompanyResolver>(),
      ),
    );
    gh.factory<_i506.CompanyBusinessBloc>(
      () => _i506.CompanyBusinessBloc(
        gh<_i582.GetBusinessProfileUseCase>(),
        gh<_i937.IConfigService>(),
        gh<_i292.BusinessTabAnalytics>(),
        gh<_i836.WatchActiveTabUseCase>(),
        gh<_i830.TabContentFreshnessService>(),
        gh<_i879.ITimeProvider>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    gh.factory<_i342.HistoricalPriceEodBloc>(
      () => _i342.HistoricalPriceEodBloc(
        gh<_i927.GetHistoricalEodPricesUseCase>(),
        gh<_i918.MarketHoursFreshnessService>(),
        gh<_i879.ITimeProvider>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    gh.lazySingleton<_i369.IFcpsRepository>(
      () => _i724.FcpsRepositoryImpl(
        gh<_i348.FinancialStatementsRemoteDataSource>(),
        gh<_i198.IFinancialStatementsFirestoreDataSource>(),
        gh<_i70.IExchangeRateRepository>(),
      ),
    );
    gh.lazySingleton<_i203.IRevenueRepository>(
      () => _i517.RevenueRepositoryImpl(
        gh<_i348.FinancialStatementsRemoteDataSource>(),
        gh<_i198.IFinancialStatementsFirestoreDataSource>(),
        gh<_i70.IExchangeRateRepository>(),
      ),
    );
    gh.factory<_i349.SearchBloc>(
      () => _i349.SearchBloc(
        gh<_i130.SearchStocksUseCase>(),
        gh<_i555.GetSearchDashboardDataUseCase>(),
        gh<_i691.FindStockForProductUseCase>(),
        gh<_i687.SearchTracker>(),
        gh<_i583.ILocalStorageService>(),
      ),
    );
    gh.lazySingleton<_i865.IFinancialStatementsRepository>(
      () => _i742.FinancialStatementsRepositoryImpl(
        gh<_i348.FinancialStatementsRemoteDataSource>(),
        gh<_i198.IFinancialStatementsFirestoreDataSource>(),
        gh<_i70.IExchangeRateRepository>(),
      ),
    );
    gh.lazySingleton<_i695.IEpsRepository>(
      () => _i391.EpsRepositoryImpl(
        gh<_i348.FinancialStatementsRemoteDataSource>(),
        gh<_i198.IFinancialStatementsFirestoreDataSource>(),
        gh<_i70.IExchangeRateRepository>(),
      ),
    );
    gh.lazySingleton<_i581.IFreeCashFlowRepository>(
      () => _i270.FreeCashFlowRepositoryImpl(
        gh<_i348.FinancialStatementsRemoteDataSource>(),
        gh<_i198.IFinancialStatementsFirestoreDataSource>(),
        gh<_i70.IExchangeRateRepository>(),
      ),
    );
    gh.factory<_i723.CompanyDividendsBloc>(
      () => _i723.CompanyDividendsBloc(
        gh<_i754.GetDividendInfoUseCase>(),
        gh<_i937.IConfigService>(),
        gh<_i252.DividendTabAnalytics>(),
        gh<_i836.WatchActiveTabUseCase>(),
        gh<_i879.ITimeProvider>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    gh.factory<_i993.BizzieChatBloc>(
      () => _i993.BizzieChatBloc(
        gh<_i563.GetMessagesStreamUseCase>(),
        gh<_i714.SendMessageStreamUseCase>(),
        gh<_i995.SubmitChatRatingUseCase>(),
      ),
    );
    gh.lazySingleton<_i108.GetEpsStatsUseCase>(
      () => _i108.GetEpsStatsUseCase(gh<_i695.IEpsRepository>()),
    );
    gh.lazySingleton<_i814.INetIncomeRepository>(
      () => _i13.NetIncomeRepositoryImpl(
        gh<_i348.FinancialStatementsRemoteDataSource>(),
        gh<_i198.IFinancialStatementsFirestoreDataSource>(),
        gh<_i70.IExchangeRateRepository>(),
      ),
    );
    gh.factory<_i410.CompanySecurityBloc>(
      () => _i410.CompanySecurityBloc(
        gh<_i193.GetSecurityDetailsUseCase>(),
        gh<_i258.SecurityTabAnalytics>(),
        gh<_i836.WatchActiveTabUseCase>(),
        gh<_i918.MarketHoursFreshnessService>(),
        gh<_i879.ITimeProvider>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    gh.lazySingleton<_i518.PersistNotificationGrantUseCase>(
      () => _i518.PersistNotificationGrantUseCase(
        gh<_i685.IAuthRepository>(),
        gh<_i11.IUserRepository>(),
        gh<_i390.CheckNotificationPermissionUseCase>(),
        gh<_i597.ToggleNotificationsUseCase>(),
        gh<_i461.SubscribeToNotificationTopicsUseCase>(),
      ),
    );
    gh.lazySingleton<_i215.ISegmentsRepository>(
      () => _i90.SegmentsRepositoryImpl(
        gh<_i333.ISegmentsRemoteDataSource>(),
        gh<_i638.ISegmentsFirestoreDataSource>(),
        gh<_i70.IExchangeRateRepository>(),
      ),
    );
    gh.lazySingleton<_i105.SaveOnboardingProgressUseCase>(
      () => _i105.SaveOnboardingProgressUseCase(
        gh<_i223.ResolveOnboardingUserUseCase>(),
        gh<_i492.GuestUsernameGenerator>(),
        gh<_i874.CompleteOnboardingUseCase>(),
      ),
    );
    gh.lazySingleton<_i585.GetRevenueStatsUseCase>(
      () => _i585.GetRevenueStatsUseCase(gh<_i203.IRevenueRepository>()),
    );
    gh.factory<_i571.ProfileBloc>(
      () => _i571.ProfileBloc(
        gh<_i690.GetProfileDisplayDataUseCase>(),
        gh<_i204.WatchCurrentUserUseCase>(),
        gh<_i963.ProfileTracker>(),
      ),
    );
    gh.lazySingleton<_i775.GetNetIncomeStatsUseCase>(
      () => _i775.GetNetIncomeStatsUseCase(gh<_i814.INetIncomeRepository>()),
    );
    gh.lazySingleton<_i805.GetFcpsStatsUseCase>(
      () => _i805.GetFcpsStatsUseCase(gh<_i369.IFcpsRepository>()),
    );
    gh.lazySingleton<_i773.GetRevenueGeographicSegmentsUseCase>(
      () => _i773.GetRevenueGeographicSegmentsUseCase(
        gh<_i215.ISegmentsRepository>(),
      ),
    );
    gh.lazySingleton<_i734.GetRevenueProductSegmentsUseCase>(
      () => _i734.GetRevenueProductSegmentsUseCase(
        gh<_i215.ISegmentsRepository>(),
      ),
    );
    gh.factory<_i683.CompanyEpsBloc>(
      () => _i683.CompanyEpsBloc(
        gh<_i108.GetEpsStatsUseCase>(),
        gh<_i937.IConfigService>(),
        gh<_i667.EpsTabAnalytics>(),
        gh<_i836.WatchActiveTabUseCase>(),
        gh<_i879.ITimeProvider>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
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
    gh.lazySingleton<_i609.GetFullFinancialsUseCase>(
      () => _i609.GetFullFinancialsUseCase(
        gh<_i865.IFinancialStatementsRepository>(),
      ),
    );
    gh.lazySingleton<_i206.GetIncomeStatementsUseCase>(
      () => _i206.GetIncomeStatementsUseCase(
        gh<_i865.IFinancialStatementsRepository>(),
      ),
    );
    gh.factory<_i614.CompanyNetIncomeBloc>(
      () => _i614.CompanyNetIncomeBloc(
        gh<_i775.GetNetIncomeStatsUseCase>(),
        gh<_i937.IConfigService>(),
        gh<_i631.NetIncomeTabAnalytics>(),
        gh<_i836.WatchActiveTabUseCase>(),
        gh<_i879.ITimeProvider>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    gh.factory<_i756.CompanySegmentsBloc>(
      () => _i756.CompanySegmentsBloc(
        gh<_i734.GetRevenueProductSegmentsUseCase>(),
        gh<_i773.GetRevenueGeographicSegmentsUseCase>(),
        gh<_i937.IConfigService>(),
        gh<_i799.SegmentsTabAnalytics>(),
        gh<_i836.WatchActiveTabUseCase>(),
        gh<_i879.ITimeProvider>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    gh.factory<_i593.OnboardingBloc>(
      () => _i593.OnboardingBloc(
        gh<_i636.GetCurrentUserUseCase>(),
        gh<_i164.GetAuthStreamUseCase>(),
        gh<_i874.CompleteOnboardingUseCase>(),
        gh<_i115.SkipOnboardingUseCase>(),
        gh<_i105.SaveOnboardingProgressUseCase>(),
        gh<_i509.SignInAnonymouslyUseCase>(),
        gh<_i518.PersistNotificationGrantUseCase>(),
        gh<_i920.GetSectorsUseCase>(),
        gh<_i953.GetSp500HistoryUseCase>(),
        gh<_i422.GetDailyBrandsUseCase>(),
        gh<_i1050.ISectorService>(),
        gh<_i178.OnboardingAnalytics>(),
      ),
    );
    gh.lazySingleton<_i106.GetFreeCashFlowStatsUseCase>(
      () => _i106.GetFreeCashFlowStatsUseCase(
        gh<_i581.IFreeCashFlowRepository>(),
      ),
    );
    gh.factory<_i194.FinancialStatementsBloc>(
      () => _i194.FinancialStatementsBloc(
        gh<_i206.GetIncomeStatementsUseCase>(),
        gh<_i1054.GetBalanceSheetsUseCase>(),
        gh<_i64.GetCashFlowStatementsUseCase>(),
        gh<_i906.IncStmtTabAnalytics>(),
        gh<_i498.BalStmtTabAnalytics>(),
        gh<_i746.CashStmtTabAnalytics>(),
        gh<_i937.IConfigService>(),
        gh<_i836.WatchActiveTabUseCase>(),
        gh<_i879.ITimeProvider>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    gh.factory<_i179.CompanyFcpsBloc>(
      () => _i179.CompanyFcpsBloc(
        gh<_i805.GetFcpsStatsUseCase>(),
        gh<_i937.IConfigService>(),
        gh<_i648.FcpsTabAnalytics>(),
        gh<_i836.WatchActiveTabUseCase>(),
        gh<_i830.TabContentFreshnessService>(),
        gh<_i879.ITimeProvider>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    gh.factory<_i991.CompanyFreeCashFlowBloc>(
      () => _i991.CompanyFreeCashFlowBloc(
        gh<_i106.GetFreeCashFlowStatsUseCase>(),
        gh<_i937.IConfigService>(),
        gh<_i167.FreeCashFlowTabAnalytics>(),
        gh<_i836.WatchActiveTabUseCase>(),
        gh<_i830.TabContentFreshnessService>(),
        gh<_i879.ITimeProvider>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    gh.factory<_i810.CompanyRevenueBloc>(
      () => _i810.CompanyRevenueBloc(
        gh<_i585.GetRevenueStatsUseCase>(),
        gh<_i937.IConfigService>(),
        gh<_i151.RevenueTabAnalytics>(),
        gh<_i836.WatchActiveTabUseCase>(),
        gh<_i879.ITimeProvider>(),
        gh<_i164.GetAuthStreamUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i293.RegisterModule {}

class _$NetworkModule extends _i421.NetworkModule {}

class _$SubscriptionModule extends _i365.SubscriptionModule {}

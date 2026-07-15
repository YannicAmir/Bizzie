class StorageConstants {
  static const String _globalPrefix = 'bz_v1_';

  // Feature: App Ratings
  static const String appRatingsInteractionCount =
      '${_globalPrefix}app_ratings_interaction_count';
  static const String appRatingsPromptAttempts =
      '${_globalPrefix}app_ratings_attempts';

  // Feature: User
  static const String userFavoriteSector =
      '${_globalPrefix}user_favorite_sector';

  // Feature: Watchlist
  static const String userSubscribedTickers =
      '${_globalPrefix}user_subscribed_tickers';
  static const String watchlistEventsCache =
      '${_globalPrefix}watchlist_events_cache';

  // Feature: Stocks (Search)
  static const String stockListLastUpdated =
      '${_globalPrefix}stock_list_last_updated';

  // Feature: Market
  static const String marketDataSnapshot =
      '${_globalPrefix}market_data_snapshot';

  // Feature: Company Profile (Tab layout)
  static const String companyProfileMainTabs = '${_globalPrefix}cp_main_tabs';
  static const String companyProfileMoreTabs = '${_globalPrefix}cp_more_tabs';

  // Feature: App Status (Update management)
  static const String cachedMinAppVersion =
      '${_globalPrefix}cached_min_app_version';
  static const String cachedAppStoreLink =
      '${_globalPrefix}cached_app_store_link';
  static const String cachedPlayStoreLink =
      '${_globalPrefix}cached_play_store_link';
}

import 'package:bizzie/core/domain/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_topics_params.freezed.dart';

@freezed
abstract class NotificationTopicsParams with _$NotificationTopicsParams {
  const factory NotificationTopicsParams({
    String? sectorName,
    @Default([]) List<String> tickers,
  }) = _NotificationTopicsParams;

  factory NotificationTopicsParams.fromUser(UserModel user) =>
      NotificationTopicsParams(
        sectorName: user.favoriteSector,
        tickers: user.watchlist.map((company) => company.ticker).toList(),
      );
}

import 'package:bizzie/features/watchlist_ytd/domain/models/ytd_price_change.dart';

extension YtdPriceChangePresentationX on YtdPriceChange {
  bool get isPositive => ytdChange >= 0;

  String get formattedYtdChangePercent =>
      '${_sign(ytdChangePercent)}${ytdChangePercent.abs().toStringAsFixed(2)}%';

  String _sign(double value) => value >= 0 ? '+' : '-';
}

extension YtdPriceChangeListPresentationX on List<YtdPriceChange> {
  List<List<YtdPriceChange>> chunkedIntoRows(int columns) => [
    for (var i = 0; i < length; i += columns)
      sublist(i, (i + columns).clamp(0, length)),
  ];
}

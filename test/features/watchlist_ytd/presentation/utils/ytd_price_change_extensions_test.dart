import 'package:bizzie/features/watchlist_ytd/domain/models/ytd_price_change.dart';
import 'package:bizzie/features/watchlist_ytd/presentation/utils/ytd_price_change_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

YtdPriceChange buildChange({
  required double ytdChange,
  required double ytdChangePercent,
}) {
  return YtdPriceChange(
    ticker: 'FTNT',
    companyName: 'Fortinet, Inc.',
    year: 2026,
    baselineDate: '2025-12-31',
    baselineClose: 79.41,
    latestDate: '2026-07-21',
    latestClose: 158.1,
    ytdChange: ytdChange,
    ytdChangePercent: ytdChangePercent,
  );
}

void main() {
  group('YtdPriceChangePresentationX', () {
    test('isPositive_gainAndBreakeven_isTrue', () {
      expect(
        buildChange(ytdChange: 78.69, ytdChangePercent: 99.09).isPositive,
        isTrue,
      );
      expect(
        buildChange(ytdChange: 0, ytdChangePercent: 0).isPositive,
        isTrue,
      );
    });

    test('isPositive_loss_isFalse', () {
      expect(
        buildChange(ytdChange: -12.4, ytdChangePercent: -4.21).isPositive,
        isFalse,
      );
    });

    test('formattedYtdChangePercent_gain_prefixesPlusSign', () {
      final change = buildChange(ytdChange: 78.69, ytdChangePercent: 99.09);
      expect(change.formattedYtdChangePercent, '+99.09%');
    });

    test('formattedYtdChangePercent_loss_prefixesMinusSignOnce', () {
      final change = buildChange(ytdChange: -12.4, ytdChangePercent: -4.21);
      expect(change.formattedYtdChangePercent, '-4.21%');
    });
  });
}

import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_load_guard_mixin.dart';
import 'package:flutter_test/flutter_test.dart';

class _TestLoadGuard with CompanyProfileLoadGuardMixin {
  _TestLoadGuard(this._loadedTicker);

  final String? _loadedTicker;

  @override
  String get featureName => 'Test Feature';

  @override
  String? get loadedTicker => _loadedTicker;
}

void main() {
  group('CompanyProfileLoadGuardMixin', () {
    test('shouldSkipLoad_loadedSameTickerNoForce_returnsTrue', () {
      final guard = _TestLoadGuard('AAPL');

      expect(guard.shouldSkipLoad('AAPL', forceRefresh: false), isTrue);
    });

    test('shouldSkipLoad_loadedSameTickerWithForce_returnsFalse', () {
      final guard = _TestLoadGuard('AAPL');

      expect(guard.shouldSkipLoad('AAPL', forceRefresh: true), isFalse);
    });

    test('shouldSkipLoad_loadedDifferentTicker_returnsFalse', () {
      final guard = _TestLoadGuard('AAPL');

      expect(guard.shouldSkipLoad('MSFT', forceRefresh: false), isFalse);
    });

    test('shouldSkipLoad_notLoaded_returnsFalse', () {
      final guard = _TestLoadGuard(null);

      expect(guard.shouldSkipLoad('AAPL', forceRefresh: false), isFalse);
    });
  });
}

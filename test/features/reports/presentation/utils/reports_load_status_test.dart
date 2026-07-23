import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/market_news/presentation/bloc/market_news/market_news_bloc.dart';
import 'package:bizzie/features/reports/domain/models/reports_feed.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_state.dart';
import 'package:bizzie/features/reports/presentation/utils/reports_load_status.dart';
import 'package:bizzie/features/watchlist_ytd/presentation/bloc/watchlist_ytd/watchlist_ytd_state.dart';
import 'package:flutter_test/flutter_test.dart';

const tReportsLoaded = ReportsState.loaded(ReportsFeed());
const tReportsLoading = ReportsState.loading();
final tReportsFailure = ReportsState.failure(Failure.server('error'));

const tMarketLoaded = MarketNewsState.loaded([]);
const tMarketLoading = MarketNewsState.loading();
final tMarketFailure = MarketNewsState.failure(Failure.server('error'));

const tYtdLoaded = WatchlistYtdState.loaded({});
const tYtdLoading = WatchlistYtdState.loading();
final tYtdFailure = WatchlistYtdState.failure(Failure.server('error'));

void main() {
  group('resolveReportsLoadStatus', () {
    test('resolveReportsLoadStatus_allLoaded_returnsReady', () {
      // arrange
      // act
      final status = resolveReportsLoadStatus(
        tReportsLoaded,
        tMarketLoaded,
        tYtdLoaded,
      );

      // assert
      expect(status, ReportsLoadStatus.ready);
    });

    group('failure — only the primary reports feed gates the page', () {
      test('resolveReportsLoadStatus_reportsFailure_returnsFailure', () {
        // arrange & act
        final status = resolveReportsLoadStatus(
          tReportsFailure,
          tMarketLoaded,
          tYtdLoaded,
        );

        // assert
        expect(status, ReportsLoadStatus.failure);
      });

      test('resolveReportsLoadStatus_reportsFailureWhileSecondariesFailed_returnsFailure', () {
        // arrange & act — the primary feed failing wins regardless of secondaries
        final status = resolveReportsLoadStatus(
          tReportsFailure,
          tMarketFailure,
          tYtdFailure,
        );

        // assert
        expect(status, ReportsLoadStatus.failure);
      });
    });

    group('ready — secondary feeds degrade, never gate the page', () {
      test('resolveReportsLoadStatus_marketNewsFailure_returnsReady', () {
        // arrange & act — a failed secondary feed is settled, not fatal
        final status = resolveReportsLoadStatus(
          tReportsLoaded,
          tMarketFailure,
          tYtdLoaded,
        );

        // assert
        expect(status, ReportsLoadStatus.ready);
      });

      test('resolveReportsLoadStatus_ytdFailure_returnsReady', () {
        // arrange & act — a failed secondary feed is settled, not fatal
        final status = resolveReportsLoadStatus(
          tReportsLoaded,
          tMarketLoaded,
          tYtdFailure,
        );

        // assert
        expect(status, ReportsLoadStatus.ready);
      });

      test('resolveReportsLoadStatus_allSecondariesFailed_returnsReady', () {
        // arrange & act — with reports loaded, both secondaries failing still degrades to ready
        final status = resolveReportsLoadStatus(
          tReportsLoaded,
          tMarketFailure,
          tYtdFailure,
        );

        // assert
        expect(status, ReportsLoadStatus.ready);
      });
    });

    group('loading — primary not loaded, or a secondary not yet settled', () {
      test('resolveReportsLoadStatus_secondaryFailsWhileReportsLoading_returnsLoading', () {
        // arrange & act — a secondary failure cannot short-circuit the primary gate
        final status = resolveReportsLoadStatus(
          tReportsLoading,
          tMarketFailure,
          tYtdLoading,
        );

        // assert
        expect(status, ReportsLoadStatus.loading);
      });

      test('resolveReportsLoadStatus_secondaryStillLoading_returnsLoading', () {
        // arrange & act
        final status = resolveReportsLoadStatus(
          tReportsLoaded,
          tMarketLoading,
          tYtdLoaded,
        );

        // assert
        expect(status, ReportsLoadStatus.loading);
      });

      test('resolveReportsLoadStatus_allInitial_returnsLoading', () {
        // arrange & act
        const status = ReportsState.initial();
        final result = resolveReportsLoadStatus(
          status,
          const MarketNewsState.initial(),
          const WatchlistYtdState.initial(),
        );

        // assert
        expect(result, ReportsLoadStatus.loading);
      });
    });
  });
}

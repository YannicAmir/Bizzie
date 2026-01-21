import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:injectable/injectable.dart';

import 'package:bizzie/features/company_profile/domain/usecases/get_ratios_usecase.dart';
import 'package:bizzie/features/company_profile/domain/usecases/get_key_metrics_usecase.dart';

import 'company_more_event.dart';
import 'company_more_state.dart';

@injectable
class CompanyMoreBloc extends Bloc<CompanyMoreEvent, CompanyMoreState> {
  final GetRatiosUseCase _getRatios;
  final GetKeyMetricsUseCase _getKeyMetrics;
  CompanyMoreBloc(this._getRatios, this._getKeyMetrics)
    : super(const CompanyMoreState()) {
    on<LoadRatios>(_onLoadRatios, transformer: droppable());
    on<LoadKeyMetrics>(_onLoadKeyMetrics, transformer: droppable());
    on<LoadAll>(_onLoadAll);
    on<StalenessCheckRequested>(_onStalenessCheckRequested);
  }

  Future<void> _onLoadAll(LoadAll event, Emitter<CompanyMoreState> emit) async {
    add(
      CompanyMoreEvent.loadRatios(
        event.ticker,
        forceRefresh: event.forceRefresh,
      ),
    );
    add(
      CompanyMoreEvent.loadKeyMetrics(
        event.ticker,
        forceRefresh: event.forceRefresh,
      ),
    );
  }

  Future<void> _onLoadRatios(
    LoadRatios event,
    Emitter<CompanyMoreState> emit,
  ) async {
    final ticker = event.ticker;
    final forceRefresh = event.forceRefresh;
    if (!forceRefresh) {
      if (state.ratiosStatus == MoreDataStatus.loading) return;
      if (state.ratiosStatus == MoreDataStatus.success &&
          state.ratios.isNotEmpty) {
        return;
      }
    }

    emit(state.copyWith(ratiosStatus: MoreDataStatus.loading));

    final failureOrRatios = await _getRatios(ticker);

    failureOrRatios.fold(
      (l) => emit(
        state.copyWith(ratiosStatus: MoreDataStatus.failure, ratiosError: l),
      ),
      (r) => emit(
        state.copyWith(
          ratiosStatus: MoreDataStatus.success,
          ratios: r,
          ratiosError: null,
          ratiosLastUpdated: DateTime.now(),
        ),
      ),
    );
  }

  Future<void> _onLoadKeyMetrics(
    LoadKeyMetrics event,
    Emitter<CompanyMoreState> emit,
  ) async {
    final ticker = event.ticker;
    final forceRefresh = event.forceRefresh;
    if (!forceRefresh) {
      if (state.keyMetricsStatus == MoreDataStatus.loading) return;
      if (state.keyMetricsStatus == MoreDataStatus.success &&
          state.keyMetrics.isNotEmpty) {
        return;
      }
    }

    emit(state.copyWith(keyMetricsStatus: MoreDataStatus.loading));

    final failureOrMetrics = await _getKeyMetrics(ticker);

    failureOrMetrics.fold(
      (l) => emit(
        state.copyWith(
          keyMetricsStatus: MoreDataStatus.failure,
          keyMetricsError: l,
        ),
      ),
      (r) => emit(
        state.copyWith(
          keyMetricsStatus: MoreDataStatus.success,
          keyMetrics: r,
          keyMetricsError: null,
          keyMetricsLastUpdated: DateTime.now(),
        ),
      ),
    );
  }

  Future<void> _onStalenessCheckRequested(
    StalenessCheckRequested event,
    Emitter<CompanyMoreState> emit,
  ) async {
    if (state.ratiosLastUpdated != null) {
      final diff = DateTime.now().difference(state.ratiosLastUpdated!);
      if (diff.inHours >= 24) {
        add(CompanyMoreEvent.loadRatios(event.ticker, forceRefresh: true));
      }
    } else {
      add(CompanyMoreEvent.loadRatios(event.ticker));
    }

    if (state.keyMetricsLastUpdated != null) {
      final diff = DateTime.now().difference(state.keyMetricsLastUpdated!);
      if (diff.inHours >= 24) {
        add(CompanyMoreEvent.loadKeyMetrics(event.ticker, forceRefresh: true));
      }
    } else {
      add(CompanyMoreEvent.loadKeyMetrics(event.ticker));
    }
  }
}

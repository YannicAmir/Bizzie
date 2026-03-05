import 'package:bizzie/features/app_status/domain/interfaces/i_app_status_repository.dart';
import 'package:bizzie/features/app_status/domain/models/app_status.dart';
import 'package:bizzie/features/app_status/presentation/analytics/app_status_tracker.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'app_status_event.dart';
part 'app_status_state.dart';
part 'app_status_bloc.freezed.dart';

final _logger = BizzieLogger('AppStatusBloc');

@injectable
class AppStatusBloc extends Bloc<AppStatusEvent, AppStatusState> {
  final IAppStatusRepository _repository;
  final AppStatusTracker _tracker;

  AppStatusBloc(this._repository, this._tracker)
    : super(const AppStatusState.initial()) {
    on<_Started>(_onStarted);
    on<_Refreshed>(_onRefreshed);
    on<_StatusChanged>(_onStatusChanged);
  }

  Future<void> _onStarted(_Started event, Emitter<AppStatusState> emit) async {
    _logger.info('Monitoring app status stream...');
    return emit.forEach<AppStatus>(
      _repository.watchStatus().distinct(),
      onData: (status) {
        _logger.info('App status updated from stream: $status');
        _trackStatus(status, isManualRefresh: false);
        return AppStatusState.checked(status);
      },
    );
  }

  Future<void> _onRefreshed(
    _Refreshed event,
    Emitter<AppStatusState> emit,
  ) async {
    _logger.info('Manual status refresh requested');

    state.whenOrNull(
      checked: (status, isRefreshing) {
        emit(AppStatusState.checked(status, isRefreshing: true));
      },
    );

    final status = await _repository.checkStatus();
    _logger.info('Manual check result: $status');
    add(AppStatusEvent.statusChanged(status, isManualRefresh: true));
  }

  void _onStatusChanged(_StatusChanged event, Emitter<AppStatusState> emit) {
    _logger.info('Status change event received: ${event.status}');
    _trackStatus(event.status, isManualRefresh: event.isManualRefresh);
    emit(AppStatusState.checked(event.status));
  }

  void _trackStatus(AppStatus status, {required bool isManualRefresh}) {
    _tracker.trackStatus(status);
  }
}

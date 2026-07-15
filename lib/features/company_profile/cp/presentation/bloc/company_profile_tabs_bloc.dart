import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_session_reset_mixin.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tabs_event.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tabs_state.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/get_tab_layout_params.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_activation.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_layout.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/get_tab_layout_usecase.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/set_active_tab_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('CompanyProfileTabsBloc');

@injectable
class CompanyProfileTabsBloc
    extends Bloc<CompanyProfileTabsEvent, CompanyProfileTabsState>
    with
        AuthSessionResetMixin<
          CompanyProfileTabsEvent,
          CompanyProfileTabsState
        > {
  final GetTabLayoutUseCase _getTabLayout;
  final SetActiveTabUseCase _setActiveTab;
  final IConfigService _configService;

  CompanyProfileTabsBloc(
    this._getTabLayout,
    this._setActiveTab,
    this._configService,
    GetAuthStream getAuthStream,
  ) : super(const CompanyProfileTabsState.initial()) {
    on<Started>(_onStarted, transformer: restartable());
    on<TabActivated>(_onTabActivated, transformer: sequential());
    on<MoreTabIndexChanged>(_onMoreTabIndexChanged, transformer: sequential());
    on<TabOrderChanged>(_onTabOrderChanged, transformer: restartable());
    on<Reset>(_onReset);
    resetOnSessionEnd(getAuthStream, const CompanyProfileTabsEvent.reset());
  }

  TabLayout _loadLayout({required bool isSubscribed}) =>
      _getTabLayout(GetTabLayoutParams(isSubscribed: isSubscribed)).fold((
        failure,
      ) {
        _logger.warning('Failed to load tab layout, using defaults: $failure');
        return TabLayout.defaults(isSubscribed: isSubscribed);
      }, (layout) => layout);

  void _onStarted(Started event, Emitter<CompanyProfileTabsState> emit) {
    emit(
      _loadLayout(isSubscribed: event.isSubscribed).toTabsState(
        isBizzieChatEnabled: _configService.bizzieChatEnabled,
        isSubscribed: event.isSubscribed,
      ),
    );
  }

  void _onTabActivated(
    TabActivated event,
    Emitter<CompanyProfileTabsState> emit,
  ) {
    _activate(event.tab, event.ticker);
  }

  void _onMoreTabIndexChanged(
    MoreTabIndexChanged event,
    Emitter<CompanyProfileTabsState> emit,
  ) {
    emit(state.copyWith(moreTabIndex: event.index));
    _activate(CompanyProfileTab.more, event.ticker);
  }

  void _onTabOrderChanged(
    TabOrderChanged event,
    Emitter<CompanyProfileTabsState> emit,
  ) {
    final layout = _loadLayout(isSubscribed: state.isSubscribed);
    emit(
      state.copyWith(
        mainTabs: layout.mainTabs,
        moreTabs: layout.moreTabs,
        bizziePlusTabs: layout.bizziePlusTabs,
      ),
    );
  }

  void _onReset(Reset event, Emitter<CompanyProfileTabsState> emit) {
    emit(const CompanyProfileTabsState.initial());
  }

  void _activate(CompanyProfileTab tab, String ticker) {
    var target = tab;
    if (tab == CompanyProfileTab.more) {
      if (state.moreTabs.isEmpty) return;
      final safeIdx = state.moreTabIndex.clamp(0, state.moreTabs.length - 1);
      target = state.moreTabs[safeIdx];
    }
    _setActiveTab(TabActivation(tab: target, ticker: ticker));
  }
}

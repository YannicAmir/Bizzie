import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_tab_activation_service.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_activation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WatchActiveTabUseCase implements StreamUseCase<TabActivation, NoParams> {
  final ITabActivationService _tabActivationService;

  WatchActiveTabUseCase(this._tabActivationService);

  @override
  Stream<TabActivation> call(NoParams params) =>
      _tabActivationService.activeTab;
}

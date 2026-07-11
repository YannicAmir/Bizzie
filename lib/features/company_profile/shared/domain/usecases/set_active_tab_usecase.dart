import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_tab_activation_service.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_activation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SetActiveTabUseCase implements SynchronousUseCase<void, TabActivation> {
  final ITabActivationService _tabActivationService;

  SetActiveTabUseCase(this._tabActivationService);

  @override
  void call(TabActivation params) =>
      _tabActivationService.setActiveTab(params);
}

import 'dart:async';

import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_tab_activation_service.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_activation.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('TabActivationService');

@LazySingleton(as: ITabActivationService)
class TabActivationService implements ITabActivationService {
  final StreamController<TabActivation> _controller =
      StreamController.broadcast();

  @override
  Stream<TabActivation> get activeTab => _controller.stream;

  @override
  void setActiveTab(TabActivation activation) {
    _logger.info(
      'Tab activated: ${activation.tab.name} for ${activation.ticker}',
    );
    _controller.add(activation);
  }
}

import 'package:bizzie/features/company_profile/shared/domain/models/tab_activation.dart';

abstract class ITabActivationService {
  Stream<TabActivation> get activeTab;
  void setActiveTab(TabActivation activation);
}

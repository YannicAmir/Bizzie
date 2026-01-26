import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_state.dart';

extension CompanySecurityStateX on CompanySecurityState {
  bool get isLoading =>
      maybeMap(loading: (_) => true, initial: (_) => true, orElse: () => false);
}

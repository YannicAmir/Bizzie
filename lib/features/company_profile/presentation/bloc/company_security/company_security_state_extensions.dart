import 'package:bizzie/features/company_profile/presentation/bloc/company_security/company_security_state.dart';

extension CompanySecurityStateX on CompanySecurityState {
  bool get isLoading =>
      maybeMap(initial: (_) => true, loading: (_) => true, orElse: () => false);
}

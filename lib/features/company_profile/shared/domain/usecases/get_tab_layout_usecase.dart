import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_tab_order_repository.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/get_tab_layout_params.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_layout.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetTabLayoutUseCase
    implements
        SynchronousUseCase<Either<Failure, TabLayout>, GetTabLayoutParams> {
  final ITabOrderRepository _tabOrderRepository;

  GetTabLayoutUseCase(this._tabOrderRepository);

  @override
  Either<Failure, TabLayout> call(GetTabLayoutParams params) =>
      _tabOrderRepository.getTabLayout(isSubscribed: params.isSubscribed);
}

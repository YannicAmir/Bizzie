import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_tab_order_repository.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_layout.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveTabLayoutUseCase
    implements UseCase<Either<Failure, void>, TabLayout> {
  final ITabOrderRepository _tabOrderRepository;

  SaveTabLayoutUseCase(this._tabOrderRepository);

  @override
  Future<Either<Failure, void>> call(TabLayout params) =>
      _tabOrderRepository.saveTabLayout(params);
}

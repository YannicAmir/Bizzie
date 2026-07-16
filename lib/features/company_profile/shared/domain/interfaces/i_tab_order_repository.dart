import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_layout.dart';
import 'package:dartz/dartz.dart';

abstract class ITabOrderRepository {
  Either<Failure, TabLayout> getTabLayout({required bool isSubscribed});
  Future<Either<Failure, void>> saveTabLayout(TabLayout layout);
}

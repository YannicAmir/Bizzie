import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/market/domain/entities/sector_pe.dart';
import 'package:bizzie/features/market/domain/entities/sector_performance.dart';
import 'package:dartz/dartz.dart';

abstract class IMarketRepository {
  Future<Either<Failure, List<SectorPe>>> getSectorPeList();
  Future<Either<Failure, List<SectorPerformance>>> getSectorPerformanceList();
}

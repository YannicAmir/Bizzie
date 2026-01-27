import 'package:bizzie/features/company_profile/security/domain/models/price_point.dart';
import 'package:equatable/equatable.dart';

class PriceHistory extends Equatable {
  final String symbol;
  final List<PricePoint> history;

  const PriceHistory({required this.symbol, required this.history});

  @override
  List<Object?> get props => [symbol, history];
}

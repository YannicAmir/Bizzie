import 'package:equatable/equatable.dart';

class SharesSummaryData extends Equatable {
  final double currentValue;
  final double growthPercentage;
  final double absoluteDelta;
  final bool isPositive;
  final String referenceLabel;

  const SharesSummaryData({
    required this.currentValue,
    required this.growthPercentage,
    required this.absoluteDelta,
    required this.isPositive,
    required this.referenceLabel,
  });

  @override
  List<Object?> get props => [
    currentValue,
    growthPercentage,
    absoluteDelta,
    isPositive,
    referenceLabel,
  ];
}

import 'package:equatable/equatable.dart';

class CompanyExecutive extends Equatable {
  final String name;
  final String title;
  final String? gender;
  final double? totalPay;
  final String? currencyPay;
  final int? yearBorn;

  const CompanyExecutive({
    required this.name,
    required this.title,
    this.gender,
    this.totalPay,
    this.currencyPay,
    this.yearBorn,
  });

  @override
  List<Object?> get props => [
    name,
    title,
    gender,
    totalPay,
    currencyPay,
    yearBorn,
  ];
}

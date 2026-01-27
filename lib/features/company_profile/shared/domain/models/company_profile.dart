import 'package:equatable/equatable.dart';

class CompanyProfile extends Equatable {
  final String symbol;
  final double? price;
  final double? changesPercentage;
  final double? change;
  final double? marketCap;
  final double? beta;
  final String? description;
  final String? sector;
  final String? industry;
  final String? exchange;
  final String? exchangeShortName;
  final String? currency;
  final bool? isEtf;
  final bool? isFund;
  final bool? isActivelyTrading;
  final String? companyName;
  final String? image;
  final String? ceo;
  final String? website;
  final String? address;
  final String? city;
  final String? state;
  final String? zip;
  final String? phone;
  final String? fullTimeEmployees;
  final String? ipoDate;
  final String? country;

  const CompanyProfile({
    required this.symbol,
    this.price,
    this.changesPercentage,
    this.change,
    this.marketCap,
    this.beta,
    this.description,
    this.sector,
    this.industry,
    this.exchange,
    this.exchangeShortName,
    this.currency,
    this.isEtf,
    this.isFund,
    this.isActivelyTrading,
    this.companyName,
    this.image,
    this.ceo,
    this.website,
    this.address,
    this.city,
    this.state,
    this.zip,
    this.phone,
    this.fullTimeEmployees,
    this.ipoDate,
    this.country,
  });

  @override
  List<Object?> get props => [
    symbol,
    price,
    changesPercentage,
    change,
    marketCap,
    beta,
    description,
    sector,
    industry,
    exchange,
    exchangeShortName,
    currency,
    isEtf,
    isFund,
    isActivelyTrading,
    companyName,
    image,
    ceo,
    website,
    address,
    city,
    state,
    zip,
    phone,
    fullTimeEmployees,
    ipoDate,
    country,
  ];
}

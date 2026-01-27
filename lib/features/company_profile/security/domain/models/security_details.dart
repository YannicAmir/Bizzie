import 'package:bizzie/features/company_profile/shared/domain/models/company_profile.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/stock_quote.dart';
import 'package:equatable/equatable.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/market_cap_category.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/ratio_category.dart';

class SecurityDetails extends Equatable {
  factory SecurityDetails.fromProfileAndQuote({
    required CompanyProfile profile,
    required StockQuote quote,
    double? peRatioTTM,
    double? pfcfTTM,
  }) {
    return SecurityDetails(
      ticker: profile.symbol,
      name: profile.companyName ?? profile.symbol,
      sector: profile.sector ?? 'N/A',
      industry: profile.industry ?? 'N/A',
      description: profile.description ?? '',
      currency: profile.currency ?? 'USD',
      isEtf: profile.isEtf ?? false,
      isFund: profile.isFund ?? false,
      isActivelyTrading: profile.isActivelyTrading ?? true,
      price: quote.price ?? 0.0,
      changesPercentage: quote.changesPercentage ?? 0.0,
      change: quote.change ?? 0.0,
      marketCap: quote.marketCap ?? 0.0,
      peRatioTTM: peRatioTTM ?? quote.pe,
      priceToFreeCashFlowTTM: pfcfTTM,
      beta: profile.beta,
      image: profile.image ?? '',
      exchangeShortName: _deriveExchange(profile),
      country: profile.country ?? '',
      ipoDate: profile.ipoDate ?? '',
      website: profile.website ?? '',
    );
  }

  static String _deriveExchange(CompanyProfile profile) {
    if (profile.exchangeShortName != null &&
        profile.exchangeShortName!.isNotEmpty) {
      return profile.exchangeShortName!;
    }
    if (profile.exchange != null) {
      if (profile.exchange!.contains('Nasdaq')) return 'NASDAQ';
      if (profile.exchange!.contains('New York')) return 'NYSE';
      return profile.exchange!;
    }
    return 'N/A';
  }

  MarketCapCategory get marketCapCategory {
    final cap = marketCap ?? 0;
    if (cap >= 200000000000) return MarketCapCategory.mega;
    if (cap >= 10000000000) return MarketCapCategory.large;
    if (cap >= 2000000000) return MarketCapCategory.mid;
    if (cap >= 250000000) return MarketCapCategory.small;
    if (cap >= 50000000) return MarketCapCategory.micro;
    return MarketCapCategory.nano;
  }

  RatioCategory get peRatioCategory {
    return _getRatioCategory(peRatioTTM);
  }

  RatioCategory get pfcfRatioCategory {
    return _getRatioCategory(priceToFreeCashFlowTTM);
  }

  RatioCategory _getRatioCategory(double? val) {
    if (val == null) return RatioCategory.none;
    if (val > 50.0) return RatioCategory.veryHigh;
    if (val > 25.0) return RatioCategory.high;
    if (val > 20.0) return RatioCategory.aboveAverage;
    if (val > 15.0) return RatioCategory.average;
    if (val > 10.0) return RatioCategory.low;
    if (val >= 0.0) return RatioCategory.veryLow;
    if (val < 0.0) return RatioCategory.negative;
    return RatioCategory.none;
  }

  final String ticker;
  final String name;
  final String sector;
  final String industry;
  final String description;
  final String currency;
  final bool isEtf;
  final bool isFund;
  final bool isActivelyTrading;
  final double? price;
  final double? changesPercentage;
  final double? change;
  final double? marketCap;
  final double? peRatioTTM;
  final double? priceToFreeCashFlowTTM;
  final double? beta;
  final String? image;
  final String? exchangeShortName;
  final String? country;
  final String? ipoDate;
  final String? website;

  const SecurityDetails({
    required this.ticker,
    required this.name,
    required this.sector,
    required this.industry,
    required this.description,
    required this.currency,
    required this.isEtf,
    required this.isFund,
    required this.isActivelyTrading,
    this.price,
    this.changesPercentage,
    this.change,
    this.marketCap,
    this.peRatioTTM,
    this.priceToFreeCashFlowTTM,
    this.beta,
    this.image,
    this.exchangeShortName,
    this.country,
    this.ipoDate,
    this.website,
  });

  @override
  List<Object?> get props => [
    ticker,
    name,
    sector,
    industry,
    description,
    currency,
    isEtf,
    isFund,
    isActivelyTrading,
    price,
    changesPercentage,
    change,
    marketCap,
    peRatioTTM,
    priceToFreeCashFlowTTM,
    beta,
    image,
    exchangeShortName,
    country,
    ipoDate,
    website,
  ];
}

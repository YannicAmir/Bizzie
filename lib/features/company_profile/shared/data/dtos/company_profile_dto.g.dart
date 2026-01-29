// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileDto _$ProfileDtoFromJson(Map<String, dynamic> json) => _ProfileDto(
  symbol: json['symbol'] as String?,
  price: (json['price'] as num?)?.toDouble(),
  changesPercentage: (json['changesPercentage'] as num?)?.toDouble(),
  change: (json['change'] as num?)?.toDouble(),
  marketCap: (json['marketCap'] as num?)?.toDouble(),
  beta: (json['beta'] as num?)?.toDouble(),
  description: json['description'] as String?,
  sector: json['sector'] as String?,
  industry: json['industry'] as String?,
  exchange: json['exchange'] as String?,
  exchangeShortName: json['exchangeShortName'] as String?,
  currency: json['currency'] as String?,
  isEtf: json['isEtf'] as bool?,
  isFund: json['isFund'] as bool?,
  isActivelyTrading: json['isActivelyTrading'] as bool?,
  companyName: json['companyName'] as String?,
  image: json['image'] as String?,
  ceo: json['ceo'] as String?,
  website: json['website'] as String?,
  address: json['address'] as String?,
  city: json['city'] as String?,
  state: json['state'] as String?,
  zip: json['zip'] as String?,
  phone: json['phone'] as String?,
  fullTimeEmployees: json['fullTimeEmployees'] as String?,
  ipoDate: json['ipoDate'] as String?,
  country: json['country'] as String?,
);

Map<String, dynamic> _$ProfileDtoToJson(_ProfileDto instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'price': instance.price,
      'changesPercentage': instance.changesPercentage,
      'change': instance.change,
      'marketCap': instance.marketCap,
      'beta': instance.beta,
      'description': instance.description,
      'sector': instance.sector,
      'industry': instance.industry,
      'exchange': instance.exchange,
      'exchangeShortName': instance.exchangeShortName,
      'currency': instance.currency,
      'isEtf': instance.isEtf,
      'isFund': instance.isFund,
      'isActivelyTrading': instance.isActivelyTrading,
      'companyName': instance.companyName,
      'image': instance.image,
      'ceo': instance.ceo,
      'website': instance.website,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'zip': instance.zip,
      'phone': instance.phone,
      'fullTimeEmployees': instance.fullTimeEmployees,
      'ipoDate': instance.ipoDate,
      'country': instance.country,
    };

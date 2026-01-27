import 'package:bizzie/features/company_profile/business/domain/models/company_executive.dart';
import 'package:bizzie/features/company_profile/business/domain/models/sec_filing.dart';
import 'package:equatable/equatable.dart';

class BusinessProfile extends Equatable {
  final String symbol;
  final String companyName;
  final String sector;
  final String industry;
  final String description;
  final String ceo;
  final String website;
  final String address;
  final String city;
  final String state;
  final String zip;
  final String phone;
  final String fullTimeEmployees;
  final List<CompanyExecutive> executives;
  final String? def14aUrl;
  final bool isForeignCompany;
  final String proxyFilingFormType;
  final List<SecFiling> annualFilings;
  final List<SecFiling> quarterlyFilings;

  const BusinessProfile({
    required this.symbol,
    required this.companyName,
    required this.sector,
    required this.industry,
    required this.description,
    required this.ceo,
    required this.website,
    required this.address,
    required this.city,
    required this.state,
    required this.zip,
    required this.phone,
    required this.fullTimeEmployees,
    required this.executives,
    this.def14aUrl,
    this.isForeignCompany = false,
    this.proxyFilingFormType = 'DEF 14A',
    this.annualFilings = const [],
    this.quarterlyFilings = const [],
  });

  @override
  List<Object?> get props => [
    symbol,
    description,
    ceo,
    website,
    address,
    city,
    state,
    zip,
    phone,
    fullTimeEmployees,
    executives,
    def14aUrl,
    isForeignCompany,
    proxyFilingFormType,
  ];
}

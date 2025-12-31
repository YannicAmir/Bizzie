import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand.freezed.dart';
part 'brand.g.dart';

@freezed
abstract class Brand with _$Brand {
  const factory Brand({
    required String name, // Product Name (e.g. "Mobil 1")
    required String company, // Company Name (e.g. "Exxon Mobil")
    required String ticker, // Ticker (e.g. "XOM")
    required String description, // Description
    String? sector, // Inferred from parent sector name in JSON
    String? imageUrl, // Kept optional if we add images later
  }) = _Brand;

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);
}

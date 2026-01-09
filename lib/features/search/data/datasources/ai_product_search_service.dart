import 'dart:convert';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/search/data/datasources/vertex_ai_provider.dart';
import 'package:bizzie/features/search/data/dtos/stock_symbol_dto.dart';
import 'package:bizzie/services/config_service.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('AiProductSearchService');

@singleton
class AiProductSearchService {
  final ConfigService _configService;
  final IVertexAIProvider _vertexAIProvider;

  AiProductSearchService(this._configService, this._vertexAIProvider);

  Future<StockSymbolDto?> findStockForProduct(String query) async {
    try {
      final modelName = _configService.geminiModelName;
      final model = _vertexAIProvider.getModel(
        modelName,
        GenerationConfig(
          responseMimeType: 'application/json',
          temperature: 0.1,
        ),
      );

      final prompt =
          '''
You are a financial entity resolver.
Identify the parent publicly traded company for the product or brand: "$query".

Rules:
1. If the product is owned by a company traded on a major US exchange (NYSE, NASDAQ), return a JSON object with:
   - "s": The stock ticker symbol (e.g., "AAPL").
   - "n": The company name (e.g., "Apple Inc.").
2. If the company is private, return a JSON object with:
   - "s": "Private"
   - "n": The company name.
   - "isPrivate": true
3. If the brand is not found, return the JSON literal: null.

Output must be valid JSON only.
''';

      final response = await model.generateContent([Content.text(prompt)]);

      final text = response.text;
      if (text == null || text.trim().isEmpty) {
        return null;
      }

      final cleanText = text
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();

      if (cleanText == 'null') {
        return null;
      }

      final json = jsonDecode(cleanText);
      if (json == null) return null;

      return StockSymbolDto.fromJson(json);
    } catch (e) {
      _logger.warning('AI Search failed for query: $query', e);
      return null;
    }
  }
}

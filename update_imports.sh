#!/bin/bash

# Define moves in format "filename|new_path_relative_to_company_profile"
moves=(
    "balance_sheet_dto.dart|financial_statements/data/dtos"
    "cash_flow_statement_dto.dart|financial_statements/data/dtos"
    "income_statement_dto.dart|financial_statements/data/dtos"
    "legacy_income_statement_dto.dart|financial_statements/data/dtos"
    "financial_dtos.dart|financial_statements/data/dtos"
    "fmp_sec_filing_dto.dart|financial_statements/data/dtos"
    "profile_dtos.dart|business/data/dtos"
    "governance_dtos.dart|business/data/dtos"
    "historical_price_eod_dto.dart|security/data/dtos"
    "earnings_report_dto.dart|security/data/dtos"
    "key_metrics_dto.dart|roe/data/dtos"
    "ratios_dto.dart|shared/data/dtos"
    "ratios_ttm_dto.dart|shared/data/dtos"
)

# Special handling for market_dtos decomposition
# We need to find imports of market_dtos.dart and replace them with specific new imports based on what class is used.
# This is hard to do safely with sed. We might need manual intervention or smarter grep.
# However, standard imports might be 'market_dtos.dart'.
# Let's replace 'market_dtos.dart' with all 3 new files for now, and let usage resolve (dart analyze will tell us unused imports).
# OR better, if we can search for usage of specific classes.

for move in "${moves[@]}"; do
    IFS="|" read -r file dir <<< "$move"
    old_path="package:bizzie/features/company_profile/data/dtos/$file"
    new_path="package:bizzie/features/company_profile/$dir/$file"
    
    echo "Updating $file..."
    LC_ALL=C find lib test -name "*.dart" -print0 | xargs -0 sed -i '' "s|$old_path|$new_path|g"
done

# Handle market_dtos.dart
# We will replace the import with 3 imports. Dart analyzer will warn about unused imports, which is safe to fix later.
# Actually, 'historical_price_dto.dart', 'dividend_dto.dart', 'news_dto.dart'
old_market="package:bizzie/features/company_profile/data/dtos/market_dtos.dart"
new_dividend="package:bizzie/features/company_profile/dividends/data/dtos/dividend_dto.dart"
new_news="package:bizzie/features/company_profile/news/data/dtos/news_dto.dart"
new_security="package:bizzie/features/company_profile/security/data/dtos/historical_price_dto.dart"

echo "Updating market_dtos.dart..."
LC_ALL=C find lib test -name "*.dart" -print0 | xargs -0 sed -i '' "s|$old_market|$new_dividend';\nimport '$new_news';\nimport '$new_security|g"

echo "Done."

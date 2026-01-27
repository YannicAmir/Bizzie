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
    "dividend_dto.dart|dividends/data/dtos"
    "news_dto.dart|news/data/dtos"
    "historical_price_dto.dart|security/data/dtos"
)

for move in "${moves[@]}"; do
    IFS="|" read -r file dir <<< "$move"
    # Match any relative import ending in the filename
    # We use restrictive regex to avoid matching things that are already correct if I mess up.
    # We essentially want to replace any string containing "data/dtos/$file" with full package path.
    
    target="data/dtos/$file"
    new_path="package:bizzie/features/company_profile/$dir/$file"
    
    echo "Fixing relative imports for $file..."
    # This sed matches: import '...data/dtos/file.dart';
    # It replaces the whole quote content with the new package path.
    LC_ALL=C find lib test -name "*.dart" -print0 | xargs -0 sed -i '' "s|import .*data/dtos/$file';|import '$new_path';|g"
done

echo "Done."

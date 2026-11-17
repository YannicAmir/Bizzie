import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:bizzie/shared/widgets/company_logo_avatar.dart';
import 'package:material_ui/material_ui.dart';
import 'package:intl/intl.dart';

const String _kDateUnknownLabel = 'Date Unknown';
const String _kDateFormat = 'MMM d, yyyy';
const EdgeInsets _kHeaderPadding = EdgeInsets.fromLTRB(
  0,
  16,
  FilingCardHeader.trailingInset,
  12,
);
const double _kLogoSpacingWidth = 12;
const SizedBox _kLogoSpacing = SizedBox(width: _kLogoSpacingWidth);
const SizedBox _kCompanyNameSpacing = SizedBox(height: 2);

class FilingCardHeader extends StatelessWidget {
  static const double contentInset =
      CompanyLogoAvatar.size + _kLogoSpacingWidth;
  static const double trailingInset = 16;

  final String ticker;
  final String companyName;
  final DateTime? filingDate;
  final DateTime? releasedAt;
  final String? logoUrl;
  final VoidCallback? onCompanyTapped;

  const FilingCardHeader({
    super.key,
    required this.ticker,
    required this.companyName,
    this.filingDate,
    this.releasedAt,
    this.logoUrl,
    this.onCompanyTapped,
  });

  String get _dateLabel {
    final released = releasedAt?.toLocal();
    if (released != null && DateUtils.isSameDay(released, DateTime.now())) {
      return BizzieDateFormatter.formatTimeAgo(released);
    }
    return switch (filingDate) {
      final date? => DateFormat(_kDateFormat).format(date),
      null => _kDateUnknownLabel,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: _kHeaderPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExcludeSemantics(
                child: GestureDetector(
                  onTap: onCompanyTapped,
                  child: CompanyLogoAvatar(ticker: ticker, logoUrl: logoUrl),
                ),
              ),
              _kLogoSpacing,
              Expanded(
                child: Semantics(
                  button: onCompanyTapped != null,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: onCompanyTapped,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ticker, style: theme.textTheme.headlineMedium),
                        _kCompanyNameSpacing,
                        Text(
                          companyName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AppConstants.subSectionHorizontalSpacing,
              Text(_dateLabel, style: theme.textTheme.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }
}

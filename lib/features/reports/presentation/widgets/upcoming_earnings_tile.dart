import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/shared/widgets/company_list_tile.dart';
import 'package:bizzie/features/watchlist/domain/models/watchlist_event_status.dart';
import 'package:bizzie/shared/widgets/badges/watchlist_event_badge.dart';
import 'package:bizzie/features/reports/domain/models/upcoming_earnings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UpcomingEarningsTile extends StatelessWidget {
  final UpcomingEarnings earnings;
  final bool isLast;

  const UpcomingEarningsTile({
    super.key,
    required this.earnings,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return CompanyListTile(
      symbol: earnings.symbol,
      name: earnings.companyName,
      showLeading: false,
      onTap: () {
        context.pushNamed(
          AppRoutes.companyProfileReports,
          pathParameters: {'ticker': earnings.symbol},
        );
      },
      trailing: WatchlistEventBadge(
        status: WatchlistEventStatus.fromUpcomingEarnings(earnings),
      ),
    );
  }
}

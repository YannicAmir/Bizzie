import 'package:bizzie/features/reports/domain/models/upcoming_earnings.dart';
import 'package:bizzie/features/reports/presentation/widgets/upcoming_earnings_tile.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:flutter/material.dart';

class UpcomingEarningsModal extends StatelessWidget {
  final List<UpcomingEarnings> earnings;

  const UpcomingEarningsModal({super.key, required this.earnings});

  @override
  Widget build(BuildContext context) {
    return AppBottomModal(
      title: 'Upcoming',
      builder: (context, scrollController) {
        return ListView.builder(
          controller: scrollController,
          itemCount: earnings.length,
          itemBuilder: (context, index) {
            return UpcomingEarningsTile(
              earnings: earnings[index],
              isLast: index == earnings.length - 1,
            );
          },
        );
      },
    );
  }
}

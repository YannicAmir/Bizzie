import 'package:bizzie/features/reports/domain/models/upcoming_earnings.dart';
import 'package:bizzie/features/reports/presentation/widgets/upcoming_earnings_tile.dart';
import 'package:bizzie/shared/widgets/modals/bottom_modal_header.dart';
import 'package:flutter/material.dart';

class UpcomingEarningsModal extends StatelessWidget {
  final List<UpcomingEarnings> earnings;

  const UpcomingEarningsModal({super.key, required this.earnings});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.875,
      minChildSize: 0.5,
      maxChildSize: 0.875,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            const BottomModalHeader(title: 'Upcoming Releases'),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: earnings.length,
                itemBuilder: (context, index) {
                  return UpcomingEarningsTile(
                    earnings: earnings[index],
                    isLast: index == earnings.length - 1,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

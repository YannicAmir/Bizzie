import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:flutter/material.dart';

class AppHistoryModal<T> extends StatelessWidget {
  final String title;
  final Widget header;
  final List<T> data;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  const AppHistoryModal({
    super.key,
    required this.title,
    required this.header,
    required this.data,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return AppBottomModal(
      title: title,
      builder: (context, scrollController) {
        return Padding(
          padding: AppConstants.bottomModalPadding,
          child: Column(
            children: [
              header,
              AppConstants.subSectionSpacing,
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: AppConstants.dataRowVerticalPadding,
                      child: itemBuilder(context, data[index], index),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

abstract class AppHistoryModalHelper {
  static void show<T>({
    required BuildContext context,
    required String title,
    required Widget header,
    required List<T> data,
    required Widget Function(BuildContext context, T item, int index)
    itemBuilder,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => AppHistoryModal<T>(
        title: title,
        header: header,
        data: data,
        itemBuilder: itemBuilder,
      ),
    );
  }
}

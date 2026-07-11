import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/subscription/presentation/utils/paywall_helper.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/shared/widgets/buttons/app_dropdown_button.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:bizzie/shared/widgets/modals/app_modal_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class FinancialStatementSelector<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final T selectedItem;
  final ValueChanged<T> onItemSelected;
  final String Function(T) dateStringExtractor;
  final String Function(T)? periodExtractor;
  final String dateFormat;
  final String modalTitle;
  final int historyLimit;

  const FinancialStatementSelector({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.onItemSelected,
    required this.dateStringExtractor,
    this.periodExtractor,
    this.dateFormat = 'MMM d, yyyy',
    required this.modalTitle,
    required this.historyLimit,
  });

  String _formatItemLabel(T item) {
    final dateStr = dateStringExtractor(item);
    final date = DateTime.tryParse(dateStr);
    String formatted = date != null
        ? DateFormat(dateFormat).format(date)
        : dateStr;

    if (periodExtractor != null) {
      final period = periodExtractor!(item);
      if (period.isNotEmpty && period.startsWith('Q')) {
        formatted += ' - $period';
      }
    }
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    final formattedLabel = _formatItemLabel(selectedItem);

    final separator = title == 'On' ? ' ' : ' - ';
    return AppDropdownButton(
      label: title.isNotEmpty
          ? '$title$separator$formattedLabel'
          : formattedLabel,
      onTap: () => _showSelectorModal(context),
    );
  }

  void _showSelectorModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AppBottomModal(
          title: modalTitle,
          builder: (context, scrollController) {
            return ListView.builder(
              controller: scrollController,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final label = _formatItemLabel(item);
                final isSelected = item == selectedItem;

                return BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    final isSubscribed = state.maybeMap(
                      loaded: (s) => s.user.isSubscribed,
                      orElse: () => false,
                    );

                    final isLocked = !isSubscribed && index >= historyLimit;

                    return AppModalListItem(
                      label: label,
                      isSelected: isSelected,
                      suffix: isLocked
                          ? SvgPicture.asset(
                              AppAssets.authLockIcon,
                              width: 18,
                              height: 18,
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).primaryColor,
                                BlendMode.srcIn,
                              ),
                            )
                          : null,
                      onTap: () {
                        if (isLocked) {
                          PaywallHelper.showPaywallSequence(
                            context,
                            source: PaywallSource.company_profile,
                          );
                        } else {
                          onItemSelected(item);
                          Navigator.pop(context);
                        }
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

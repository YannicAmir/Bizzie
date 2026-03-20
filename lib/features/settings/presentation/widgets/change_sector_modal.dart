import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/di/injection.dart';
import 'package:bizzie/features/settings/presentation/bloc/select_sector_bloc.dart';
import 'package:bizzie/features/settings/presentation/bloc/select_sector_event.dart';
import 'package:bizzie/features/settings/presentation/bloc/select_sector_state.dart';
import 'package:bizzie/features/settings/presentation/widgets/sector_card.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:bizzie/shared/widgets/modals/bizzie_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangeSectorModal extends StatelessWidget {
  final Sector currentSector;

  const ChangeSectorModal({super.key, required this.currentSector});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SelectSectorBloc>(param1: currentSector),
      child: BlocConsumer<SelectSectorBloc, SelectSectorState>(
        listener: (context, state) {
          state.maybeMap(
            success: (_) => context.pop(),
            failure: (f) {
              BizzieSnackBar.show(
                context,
                message: f.failure.errorMessage,
                type: BizzieSnackBarType.error,
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          final selectedSector = state.map(
            initial: (s) => s.selectedSector,
            loading: (s) => s.selectedSector,
            success: (s) => s.selectedSector,
            failure: (s) => s.selectedSector,
          );

          final isLoading = state.maybeMap(
            loading: (_) => true,
            orElse: () => false,
          );

          final hasChanged = state.map(
            initial: (s) => s.initialSector != s.selectedSector,
            loading: (s) => s.initialSector != s.selectedSector,
            success: (s) => false,
            failure: (s) => s.initialSector != s.selectedSector,
          );

          return AppBottomModal(
            title: 'Change Your Sector',
            minChildSize: 0.875,
            contentPadding: EdgeInsets.zero,
            builder: (context, scrollController) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.all(12),
                      itemCount: state.availableSectors.length,
                      itemBuilder: (context, index) {
                        final viewModel = state.availableSectors[index];
                        return SectorCard(
                          sector: viewModel,
                          isSelected: viewModel.sector == selectedSector.sector,
                          onTap: () => context.read<SelectSectorBloc>().add(
                            SelectSectorEvent.selectSector(viewModel.sector),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                      12,
                      8,
                      12,
                      MediaQuery.of(context).padding.bottom + 16,
                    ),
                    child: BizziePrimaryButton(
                      title: 'Save Changes',
                      onPressed: hasChanged
                          ? () => context.read<SelectSectorBloc>().add(
                              const SelectSectorEvent.saveChanges(),
                            )
                          : null,
                      isLoading: isLoading,
                      height: 50,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

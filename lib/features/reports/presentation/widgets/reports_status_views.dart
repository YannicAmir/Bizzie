import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/shared/widgets/error/bizzie_error.dart';
import 'package:bizzie/shared/widgets/loading/bizzie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportsLoadingView extends StatelessWidget {
  const ReportsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BizzieLoader(
      message: 'Loading reports...',
      mascotAssetPath: context.watch<UserBloc>().state.mascotAsset,
    );
  }
}

class ReportsErrorView extends StatelessWidget {
  const ReportsErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BizzieError(
      message: 'Error loading reports',
      mascotAssetPath: context.watch<UserBloc>().state.mascotAsset,
    );
  }
}

import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyProfileEmptyState extends StatelessWidget {
  final String message;

  const CompanyProfileEmptyState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserBloc, UserState, String>(
      selector: (state) => state.mascotAsset,
      builder: (context, mascot) {
        return BizzieEmptyState(mascotAsset: mascot, message: message);
      },
    );
  }
}

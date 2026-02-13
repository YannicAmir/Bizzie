import 'package:bizzie/di/injection.dart';
import 'package:bizzie/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:bizzie/features/profile/presentation/bloc/profile_event.dart';
import 'package:bizzie/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<ProfileBloc>()..add(const ProfileEvent.started()),
      child: const ProfileView(),
    );
  }
}

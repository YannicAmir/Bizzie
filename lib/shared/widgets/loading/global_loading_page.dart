import 'package:bizzie/shared/widgets/loading/bizzie_loader.dart';
import 'package:flutter/material.dart';

class GlobalLoadingPage extends StatelessWidget {
  final String? sectorName;

  const GlobalLoadingPage({super.key, this.sectorName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BizzieLoader(
        message: 'Setting things up for you',
        sectorName: sectorName,
      ),
    );
  }
}

import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/shared/widgets/inputs/bizzie_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BizzieSearchBar(
          readOnly: true,
          onTap: () {
            context.push(AppRoutes.search, extra: 'reports');
          },
        ),
      ),
      body: const Center(child: Text('Reports Feature Coming Soon')),
    );
  }
}

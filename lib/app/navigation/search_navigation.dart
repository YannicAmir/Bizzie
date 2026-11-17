import 'dart:async';

import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/core/constants/search_query_params.dart';
import 'package:bizzie/core/enums/search_source.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class SearchNavigation {
  SearchNavigation._();

  static void push(BuildContext context, {required SearchSource source}) {
    unawaited(
      context.pushNamed(
        AppRoutes.search,
        queryParameters: {SearchQueryParams.source: source.name},
      ),
    );
  }
}

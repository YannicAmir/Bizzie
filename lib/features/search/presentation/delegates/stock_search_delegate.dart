import 'package:flutter/material.dart';
import 'package:bizzie/features/search/presentation/bloc/search_bloc.dart';
import 'package:bizzie/features/search/presentation/views/search_page.dart';
import 'package:bizzie/app/themes/app_assets.dart';

class StockSearchDelegate extends SearchDelegate<String?> {
  final SearchBloc searchBloc;

  StockSearchDelegate(this.searchBloc);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Image.asset(AppAssets.clearTextfieldIcon, width: 24, height: 24),
        onPressed: () {
          query = '';
          searchBloc.add(const SearchEvent.cleared());
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Image.asset(AppAssets.backArrowIcon, width: 24, height: 24),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchBloc.add(SearchEvent.queryChanged(query));
    return SearchPage(searchBloc: searchBloc);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    searchBloc.add(SearchEvent.queryChanged(query));
    return SearchPage(searchBloc: searchBloc);
  }
}

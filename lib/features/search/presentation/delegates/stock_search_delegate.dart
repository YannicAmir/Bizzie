import 'package:flutter/material.dart';
import 'package:bizzie/features/search/presentation/bloc/search_bloc.dart';
import 'package:bizzie/features/search/presentation/views/search_page_placeholder.dart';

class StockSearchDelegate extends SearchDelegate<String?> {
  final SearchBloc searchBloc;

  StockSearchDelegate(this.searchBloc);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
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
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchBloc.add(SearchEvent.queryChanged(query));
    return SearchPagePlaceholder(searchBloc: searchBloc);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    searchBloc.add(SearchEvent.queryChanged(query));
    return SearchPagePlaceholder(searchBloc: searchBloc);
  }
}

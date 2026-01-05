import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bizzie/features/search/presentation/bloc/search_bloc.dart';

class SearchPagePlaceholder extends StatelessWidget {
  final SearchBloc searchBloc;
  const SearchPagePlaceholder({super.key, required this.searchBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      bloc: searchBloc,
      builder: (context, state) {
        return state.map(
          initial: (_) => const SizedBox.shrink(),
          loading: (_) => const Center(child: CircularProgressIndicator()),
          empty: (_) => const Center(child: Text("No stocks found")),
          failure: (f) => Center(child: Text("Error: ${f.message}")),
          loaded: (data) {
            final results = data.results;
            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final stock = results[index];
                return ListTile(
                  title: Text(stock.symbol),
                  subtitle: Text(stock.name),
                  onTap: () {
                    // TODO: Handle selection
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

import 'package:bizzie/shared/widgets/error/bizzie_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bizzie/features/search/presentation/bloc/search_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/features/search/presentation/widgets/search_app_bar.dart';
import 'package:bizzie/features/search/presentation/widgets/search_initial_view.dart';
import 'package:bizzie/features/search/presentation/widgets/search_results_view.dart';
import 'package:bizzie/features/search/presentation/widgets/ai_search_prompt_view.dart';
import 'package:bizzie/features/search/presentation/widgets/ai_match_success_view.dart';
import 'package:bizzie/features/search/presentation/widgets/ai_no_match_view.dart';
import 'package:bizzie/shared/widgets/loading/bizzie_loader.dart';
import 'package:bizzie/features/user/presentation/bloc/user_state_extensions.dart';

import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';

class SearchPage extends StatefulWidget {
  final String? sourceTab;

  const SearchPage({super.key, this.sourceTab});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    context.read<SearchBloc>().add(SearchEvent.queryChanged(query));
  }

  void _onClearTapped() {
    _searchController.clear();
    context.read<SearchBloc>().add(const SearchEvent.cleared());
  }

  void _onCancelTapped() {
    FocusScope.of(context).unfocus();

    if (context.canPop()) {
      context.pop();
    }
  }

  void _onRetryTapped() {
    _onClearTapped();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final mascotAsset = context.select(
      (UserBloc bloc) => bloc.state.mascotAsset,
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: SearchAppBar(
        controller: _searchController,
        focusNode: _focusNode,
        onChanged: _onSearchChanged,
        onClear: _onClearTapped,
        onCancel: _onCancelTapped,
        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'^\s+'))],
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return state.map(
            initial: (state) => SearchInitialView(
              favoriteSector: state.favoriteSector,
              recommendedBrands: state.recommendedBrands,
              sourceTab: widget.sourceTab,
            ),
            loading: (state) => BizzieLoader(
              message: 'Fetching stocks',
              mascotAssetPath: mascotAsset,
            ),
            loaded: (data) => SearchResultsView(
              results: data.results,
              query: data.query,
              sourceTab: widget.sourceTab,
            ),
            localEmpty: (state) => AiSearchPromptView(
              query: state.query,
              onSearchTap: () {
                context.read<SearchBloc>().add(
                  SearchEvent.aiSearchRequested(state.query),
                );
              },
            ),
            aiSearching: (state) => BizzieLoader(
              message: 'Searching for "${state.query}"',
              mascotAssetPath: mascotAsset,
            ),
            aiSuccess: (state) => AiMatchSuccessView(
              productName: state.productQuery,
              stock: state.stock,
              sourceTab: widget.sourceTab,
            ),
            aiEmpty: (state) => AiNoMatchView(
              productName: state.productQuery,
              onRetry: _onRetryTapped,
            ),
            failure: (f) => Center(
              child: BizzieError(
                message: 'Error loading search',
                mascotAssetPath: mascotAsset,
              ),
            ),
          );
        },
      ),
    );
  }
}

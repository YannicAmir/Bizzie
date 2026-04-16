import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_session.dart';
import 'package:bizzie/features/bizzie_chat/presentation/bloc/bizzie_chat_sessions/bizzie_chat_sessions_bloc.dart';
import 'package:bizzie/features/bizzie_chat/presentation/bloc/bizzie_chat_sessions/bizzie_chat_sessions_state.dart';
import 'package:bizzie/features/bizzie_chat/presentation/views/bizzie_chat_modal.dart';
import 'package:bizzie/features/bizzie_chat/presentation/widgets/chat_session_list_tile.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/tab_visibility_observer.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BizzieChatTab extends StatefulWidget {
  final String ticker;

  const BizzieChatTab({super.key, required this.ticker});

  @override
  State<BizzieChatTab> createState() => _BizzieChatTabState();
}

class _BizzieChatTabState extends State<BizzieChatTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return TabVisibilityObserver(
      tabName: CompanyProfileTab.chat.analyticsName,
      child: BlocBuilder<BizzieChatSessionsBloc, BizzieChatSessionsState>(
        builder: (context, state) {
          return state.maybeMap(
            loaded: (s) => s.sessions.isEmpty
                ? _ChatTabEmptyState(ticker: widget.ticker)
                : _ChatSessionList(ticker: widget.ticker, sessions: s.sessions),
            orElse: () => _ChatTabEmptyState(ticker: widget.ticker),
          );
        },
      ),
    );
  }
}

class _ChatSessionList extends StatelessWidget {
  final String ticker;
  final List<ChatSession> sessions;

  const _ChatSessionList({required this.ticker, required this.sessions});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanySecurityBloc, CompanySecurityState>(
      builder: (context, state) {
        final companyName = state.maybeMap(
          loaded: (s) => s.securityDetails.name,
          orElse: () => ticker,
        );

        return ListView.separated(
          padding: AppConstants.pagePadding,
          itemCount: sessions.length,
          separatorBuilder: (_, __) => AppConstants.subSectionSpacing,
          itemBuilder: (context, index) {
            final session = sessions[index];
            return ChatSessionListTile(
              session: session,
              onTap: () => BizzieChatModal.show(
                context,
                ticker: ticker,
                companyName: companyName,
                sessionId: session.id,
              ),
            );
          },
        );
      },
    );
  }
}

class _ChatTabEmptyState extends StatelessWidget {
  final String ticker;

  const _ChatTabEmptyState({required this.ticker});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserBloc, UserState, String>(
      selector: (state) => state.maybeMap(
        loaded: (u) => AppAssets.getMascotForSector(u.user.favoriteSector),
        orElse: () => AppAssets.defaultMascot,
      ),
      builder: (context, mascot) {
        return BlocSelector<CompanySecurityBloc, CompanySecurityState, String>(
          selector: (state) => state.maybeMap(
            loaded: (s) => s.securityDetails.name,
            orElse: () => ticker,
          ),
          builder: (context, companyName) {
            return LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: constraints.maxHeight,
                  child: _EmptyStateContent(
                    mascot: mascot,
                    companyName: companyName,
                    ticker: ticker,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _EmptyStateContent extends StatelessWidget {
  final String mascot;
  final String companyName;
  final String ticker;

  const _EmptyStateContent({
    required this.mascot,
    required this.companyName,
    required this.ticker,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BizzieEmptyState(
          mascotAsset: mascot,
          title: 'No conversations yet',
          message:
              'Tap the chat button to start asking Bizzie about $companyName.',
          isFullPage: true,
        ),
        _ConversationStarterHint(ticker: ticker, companyName: companyName),
      ],
    );
  }
}

class _ConversationStarterHint extends StatelessWidget {
  final String ticker;
  final String companyName;

  const _ConversationStarterHint({
    required this.ticker,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.chatTabHintOuterPaddingH),
      child: Column(
        children: [
          AppConstants.secondarySectionSpacing,
          _HintChip(
            label: 'What is this company\'s revenue trend?',
            ticker: ticker,
            companyName: companyName,
          ),
          AppConstants.subSectionSpacing,
          _HintChip(
            label: 'How has EPS grown over 5 years?',
            ticker: ticker,
            companyName: companyName,
          ),
          AppConstants.subSectionSpacing,
          _HintChip(
            label: 'Is this company profitable?',
            ticker: ticker,
            companyName: companyName,
          ),
          AppConstants.mainSectionSpacing,
        ],
      ),
    );
  }
}

class _HintChip extends StatelessWidget {
  final String label;
  final String ticker;
  final String companyName;

  const _HintChip({
    required this.label,
    required this.ticker,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => BizzieChatModal.show(
        context,
        ticker: ticker,
        companyName: companyName,
        initialQuery: label,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.chatHintChipPaddingH,
          vertical: AppConstants.chatHintChipPaddingV,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(AppConstants.chatHintChipRadius),
          border: Border.all(
            color: Theme.of(context).extension<MascotThemeExtension>()!.borderColor,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: Theme.of(context).extension<MascotThemeExtension>()!.subtitleColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

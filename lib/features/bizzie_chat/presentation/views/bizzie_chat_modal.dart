import 'package:bizzie/di/injection.dart';
import 'package:bizzie/features/bizzie_chat/domain/enums/chat_message_role.dart';
import 'package:bizzie/features/bizzie_chat/domain/enums/rating_type.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_message.dart';
import 'package:bizzie/features/bizzie_chat/presentation/bloc/bizzie_chat/bizzie_chat_bloc.dart';
import 'package:bizzie/features/bizzie_chat/presentation/bloc/bizzie_chat/bizzie_chat_event.dart';
import 'package:bizzie/features/bizzie_chat/presentation/bloc/bizzie_chat/bizzie_chat_state.dart';
import 'package:bizzie/features/bizzie_chat/presentation/widgets/chat_input_bar.dart';
import 'package:bizzie/features/bizzie_chat/presentation/widgets/chat_message_list.dart';
import 'package:bizzie/features/bizzie_chat/presentation/widgets/chat_scroll_to_bottom_button.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/modals/bottom_modal_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BizzieChatModal extends StatefulWidget {
  final String ticker;
  final String companyName;
  final String? sessionId;
  final String? initialQuery;

  const BizzieChatModal({
    super.key,
    required this.ticker,
    required this.companyName,
    this.sessionId,
    this.initialQuery,
  });

  static void show(
    BuildContext context, {
    required String ticker,
    required String companyName,
    String? sessionId,
    String? initialQuery,
  }) {
    final uid = context.read<UserBloc>().state.uidOrNull;
    if (uid == null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      scrollControlDisabledMaxHeightRatio: AppConstants.chatModalHeightFactor,
      builder: (_) => BlocProvider(
        create: (_) => getIt<BizzieChatBloc>()
          ..add(
            BizzieChatEvent.sessionStarted(
              uid: uid,
              ticker: ticker,
              companyName: companyName,
              sessionId: sessionId,
            ),
          ),
        child: BizzieChatModal(
          ticker: ticker,
          companyName: companyName,
          sessionId: sessionId,
          initialQuery: initialQuery,
        ),
      ),
    );
  }

  @override
  State<BizzieChatModal> createState() => _BizzieChatModalState();
}

class _BizzieChatModalState extends State<BizzieChatModal>
    with WidgetsBindingObserver {
  late final TextEditingController _textController;
  late final ScrollController _scrollController;
  final GlobalKey _lastUserMessageKey = GlobalKey();

  bool _isAtBottom = true;
  bool _hasJumpedToBottomOnLoad = false;
  double _keyboardHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _textController = TextEditingController();
    _scrollController = ScrollController()..addListener(_onScroll);

    if (widget.initialQuery != null && widget.initialQuery!.isNotEmpty) {
      _textController.text = widget.initialQuery!;
      WidgetsBinding.instance.addPostFrameCallback((_) => _handleSend());
    }
  }

  @override
  void didChangeMetrics() {
    final view = WidgetsBinding.instance.platformDispatcher.implicitView;
    if (view == null || !mounted) return;
    final newHeight = view.viewInsets.bottom / view.devicePixelRatio;
    if (newHeight != _keyboardHeight) {
      setState(() => _keyboardHeight = newHeight);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final pos = _scrollController.position;
    final atBottom =
        pos.pixels >=
        pos.maxScrollExtent - AppConstants.chatScrollAtBottomThreshold;
    if (atBottom != _isAtBottom) {
      setState(() => _isAtBottom = atBottom);
    }
  }

  void _handleSend() {
    final query = _textController.text.trim();
    if (query.isEmpty) return;
    context.read<BizzieChatBloc>().add(
      BizzieChatEvent.messageSent(query: query),
    );
    _textController.clear();
    _scrollToUserMessage();
  }

  void _handleFollowUpTap(String followUp) {
    _textController.text = followUp;
    _handleSend();
  }

  void _scrollToUserMessage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final ctx = _lastUserMessageKey.currentContext;
        if (ctx != null) {
          Scrollable.ensureVisible(
            ctx,
            alignment: 0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        } else if (_scrollController.hasClients) {
          final pos = _scrollController.position;
          _scrollController.animateTo(
            (pos.maxScrollExtent - pos.viewportDimension).clamp(
              0.0,
              pos.maxScrollExtent,
            ),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  void _jumpToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || !_scrollController.hasClients) return;
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    });
  }

  void _animateToBottom() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final mascotAsset = context.read<UserBloc>().state.mascotAsset;

    return BlocConsumer<BizzieChatBloc, BizzieChatState>(
      listenWhen: (prev, curr) {
        if (widget.sessionId != null && !_hasJumpedToBottomOnLoad) {
          final prevWasActive = prev.mapOrNull(active: (_) => true) ?? false;
          final currMessages =
              curr.mapOrNull(active: (s) => s.messages) ??
              const <ChatMessage>[];
          if (!prevWasActive && currMessages.isNotEmpty) return true;
        }

        final prevSseError = prev.mapOrNull(active: (s) => s.sseError);
        final currSseError = curr.mapOrNull(active: (s) => s.sseError);

        if (currSseError != null && currSseError != prevSseError) return true;

        final wasFailure = prev.mapOrNull(failure: (_) => true) ?? false;
        final isFailure = curr.mapOrNull(failure: (_) => true) ?? false;
        return !wasFailure && isFailure;
      },
      listener: (context, state) {
        state.mapOrNull(
          active: (s) {
            if (widget.sessionId != null &&
                !_hasJumpedToBottomOnLoad &&
                s.messages.isNotEmpty) {
              _hasJumpedToBottomOnLoad = true;
              _jumpToBottom();
            }
            if (s.sseError != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(s.sseError!)));
            }
          },
          failure: (s) => ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(s.failure.errorMessage))),
        );
      },
      builder: (context, chatState) {
        final messages =
            chatState.mapOrNull(active: (s) => s.messages) ??
            const <ChatMessage>[];
        final followUps =
            chatState.mapOrNull(active: (s) => s.followUps) ?? const <String>[];
        final isStreaming =
            chatState.mapOrNull(active: (s) => s.isStreaming) ?? false;
        final streamingContent = chatState.mapOrNull(
          active: (s) => s.streamingContent,
        );

        final currentRating = chatState.mapOrNull(active: (s) => s.rating);
        final lastUserContent = messages.fold<String>(
          '',
          (acc, m) => m.role == ChatMessageRole.user ? m.content : acc,
        );
        final lastAssistantContent = messages.fold<String>(
          '',
          (acc, m) => m.role == ChatMessageRole.assistant ? m.content : acc,
        );
        final lastAssistantId = messages.fold<String>(
          '',
          (acc, m) => m.role == ChatMessageRole.assistant ? m.id : acc,
        );

        void onRatingTapped(RatingType rating) {
          context.read<BizzieChatBloc>().add(
            BizzieChatEvent.messageRated(
              rating: rating,
              question: lastUserContent,
              aiResponse: lastAssistantContent,
              companyName: widget.companyName,
              companyTicker: widget.ticker,
              assistantMessageId: lastAssistantId,
            ),
          );
        }

        final hasAssistantResponse = messages.any(
          (m) => m.role == ChatMessageRole.assistant,
        );

        final userCount = messages
            .where((m) => m.role == ChatMessageRole.user)
            .length;
        final assistantCount = messages
            .where((m) => m.role == ChatMessageRole.assistant)
            .length;
        final showSpacer = isStreaming || (userCount > assistantCount);

        return SizedBox(
          height:
              screenHeight *
                  (_keyboardHeight > 0
                      ? AppConstants.chatModalHeightFactor
                      : AppConstants.chatModalHeightFactorKeyboard) -
              _keyboardHeight,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppConstants.chatModalTopRadius),
              ),
            ),
            child: Column(
              children: [
                BottomModalHeader(
                  title: widget.companyName,
                  onClose: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      ChatMessageList(
                        messages: messages,
                        isStreaming: isStreaming,
                        streamingContent: streamingContent,
                        showSpacer: showSpacer,
                        followUps: followUps,
                        onFollowUpTapped: _handleFollowUpTap,
                        scrollController: _scrollController,
                        mascotAsset: mascotAsset,
                        lastUserMessageKey: _lastUserMessageKey,
                        currentRating: currentRating,
                        aiResponse: lastAssistantContent,
                        onLike: () => onRatingTapped(RatingType.positive),
                        onDislike: () => onRatingTapped(RatingType.negative),
                      ),
                      Positioned(
                        bottom: AppConstants.chatFabBottomOffset,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            transitionBuilder: (child, animation) =>
                                ScaleTransition(
                                  scale: CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeOutBack,
                                    reverseCurve: Curves.easeIn,
                                  ),
                                  child: child,
                                ),
                            child:
                                (!_isAtBottom &&
                                    messages.isNotEmpty &&
                                    !isStreaming &&
                                    hasAssistantResponse)
                                ? ChatScrollToBottomButton(
                                    key: const ValueKey('scroll_btn'),
                                    onTap: _animateToBottom,
                                  )
                                : const SizedBox.shrink(key: ValueKey('empty')),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ChatInputBar(
                  controller: _textController,
                  onSend: _handleSend,
                  isEnabled: !isStreaming,
                  companyName: widget.companyName,
                ),
                const _BottomSafeArea(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BottomSafeArea extends StatelessWidget {
  const _BottomSafeArea();

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.paddingOf(context).bottom);
  }
}

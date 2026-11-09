import 'package:bizzie/core/domain/models/sec_filing.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/di/injection.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_event.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_state.dart';
import 'package:bizzie/features/reports/presentation/widgets/reports_filing_card.dart';
import 'package:bizzie/features/user/domain/enums/investing_experience.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/shared/widgets/cards/filing_card_header.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockReportsBloc extends MockBloc<ReportsEvent, ReportsState>
    implements ReportsBloc {}

class MockUserBloc extends MockBloc<UserEvent, UserState> implements UserBloc {}

class MockConfigService extends Mock implements IConfigService {}

const tLabel = 'Summarize';
const tFiling = SecFiling(
  id: 'f',
  symbol: 'AAPL',
  companyName: 'Apple Inc.',
  filingDate: null,
  formType: '10-K',
  link: '',
  summary: 'Summary',
  createdAt: null,
  analyzedAt: null,
);

void main() {
  late MockReportsBloc mockReportsBloc;
  late MockUserBloc mockUserBloc;
  late MockConfigService mockConfigService;

  setUpAll(() {
    registerFallbackValue(const ReportsEvent.refresh());
  });

  setUp(() {
    mockReportsBloc = MockReportsBloc();
    mockUserBloc = MockUserBloc();
    mockConfigService = MockConfigService();
    getIt.allowReassignment = true;
    getIt.registerLazySingleton<IConfigService>(() => mockConfigService);
    when(() => mockConfigService.aiSummaryButtonLabel).thenReturn(tLabel);
    when(() => mockUserBloc.state).thenReturn(
      UserState.loaded(
        UserModel(
          uid: 'uid',
          name: 'Tester',
          favoriteSector: 'Technology',
          watchlist: const [],
          investingExperience: InvestingExperience.intermediate,
          createdAt: DateTime(2026),
          isSubscribed: true,
          fcmTokens: const {},
        ),
      ),
    );
  });

  tearDown(() => getIt.unregister<IConfigService>());

  Widget host() => MultiBlocProvider(
    providers: [
      BlocProvider<ReportsBloc>.value(value: mockReportsBloc),
      BlocProvider<UserBloc>.value(value: mockUserBloc),
    ],
    child: const MaterialApp(
      home: Scaffold(body: ReportsFilingCard(filing: tFiling)),
    ),
  );

  group('ReportsFilingCard', () {
    testWidgets('build_default_companyIsTappable', (tester) async {
      // arrange
      final sut = host();

      // act
      await tester.pumpWidget(sut);

      // assert
      final header = tester.widget<FilingCardHeader>(
        find.byType(FilingCardHeader),
      );
      expect(header.onCompanyTapped, isNotNull);
    });

    testWidgets('tapViewReport_dispatchesLinkOpened', (tester) async {
      // arrange
      await tester.pumpWidget(host());

      // act
      await tester.tap(find.text('View Full Report'));

      // assert
      verify(
        () => mockReportsBloc.add(
          const ReportsEvent.linkOpened(ticker: 'AAPL', filingType: '10-K'),
        ),
      ).called(1);
    });

    testWidgets('tapSummary_subscribed_dispatchesSummaryRequested', (
      tester,
    ) async {
      // arrange
      await tester.pumpWidget(host());

      // act
      await tester.tap(find.text(tLabel));
      await tester.pumpAndSettle();

      // assert
      verify(
        () => mockReportsBloc.add(
          const ReportsEvent.summaryRequested(
            ticker: 'AAPL',
            filingType: '10-K',
            isReady: false,
          ),
        ),
      ).called(1);
    });
  });
}

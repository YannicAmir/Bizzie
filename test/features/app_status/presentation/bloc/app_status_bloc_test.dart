import 'package:bizzie/features/app_status/domain/interfaces/i_app_status_repository.dart';
import 'package:bizzie/features/app_status/domain/models/app_status.dart';
import 'package:bizzie/features/app_status/presentation/bloc/app_status_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAppStatusRepository extends Mock implements IAppStatusRepository {}

void main() {
  late AppStatusBloc bloc;
  late MockAppStatusRepository mockRepository;

  setUp(() {
    mockRepository = MockAppStatusRepository();
    bloc = AppStatusBloc(mockRepository);
  });

  tearDown(() {
    bloc.close();
  });

  group('AppStatusBloc', () {
    test('initialState_default_isInitial', () {
      // assert
      expect(bloc.state, const AppStatusState.initial());
    });

    blocTest<AppStatusBloc, AppStatusState>(
      'onStarted_streamEmits_emitsChecked',
      build: () {
        // arrange
        when(
          () => mockRepository.watchStatus(),
        ).thenAnswer((_) => Stream.fromIterable([const AppStatus.normal()]));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const AppStatusEvent.started());
      },
      expect: () => [
        // assert
        const AppStatusState.checked(AppStatus.normal()),
      ],
      verify: (_) {
        // assert
        verify(() => mockRepository.watchStatus()).called(1);
      },
    );

    blocTest<AppStatusBloc, AppStatusState>(
      'onRefreshed_manualRefresh_emitsRefreshingThenChecked',
      build: () {
        // arrange
        when(
          () => mockRepository.checkStatus(),
        ).thenAnswer((_) async => const AppStatus.normal());
        return bloc;
      },
      seed: () => const AppStatusState.checked(AppStatus.noInternet()),
      act: (bloc) {
        // act
        bloc.add(const AppStatusEvent.refreshed());
      },
      expect: () => [
        // assert
        const AppStatusState.checked(
          AppStatus.noInternet(),
          isRefreshing: true,
        ),
        const AppStatusState.checked(AppStatus.normal()),
      ],
      verify: (_) {
        // assert
        verify(() => mockRepository.checkStatus()).called(1);
      },
    );

    blocTest<AppStatusBloc, AppStatusState>(
      'onStatusChanged_newStatusReceived_emitsChecked',
      build: () => bloc,
      act: (bloc) {
        // act
        bloc.add(const AppStatusEvent.statusChanged(AppStatus.maintenance()));
      },
      expect: () => [
        // assert
        const AppStatusState.checked(AppStatus.maintenance()),
      ],
    );

    group('Real-time Updates', () {
      blocTest<AppStatusBloc, AppStatusState>(
        'onStarted_multipleUpdatesFromStream_emitsAllStates',
        build: () {
          // arrange
          when(() => mockRepository.watchStatus()).thenAnswer(
            (_) => Stream.fromIterable([
              const AppStatus.normal(),
              const AppStatus.noInternet(),
              const AppStatus.forceUpgrade(minVersion: '2.0.0', storeUrl: ''),
            ]),
          );
          return bloc;
        },
        act: (bloc) {
          // act
          bloc.add(const AppStatusEvent.started());
        },
        expect: () => [
          // assert
          const AppStatusState.checked(AppStatus.normal()),
          const AppStatusState.checked(AppStatus.noInternet()),
          const AppStatusState.checked(
            AppStatus.forceUpgrade(minVersion: '2.0.0', storeUrl: ''),
          ),
        ],
      );
    });
  });
}

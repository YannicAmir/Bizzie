import 'package:bizzie/shared/utils/url_launcher_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class MockUrlLauncherPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements UrlLauncherPlatform {}

void main() {
  late MockUrlLauncherPlatform mockPlatform;
  late List<String> errors;

  void onError(String message) => errors.add(message);

  setUpAll(() {
    registerFallbackValue(const LaunchOptions());
  });

  setUp(() {
    mockPlatform = MockUrlLauncherPlatform();
    UrlLauncherPlatform.instance = mockPlatform;
    errors = [];

    when(() => mockPlatform.canLaunch(any())).thenAnswer((_) async => true);
    when(
      () => mockPlatform.launchUrl(any(), any()),
    ).thenAnswer((_) async => true);
  });

  String capturedLaunchUrl() =>
      verify(() => mockPlatform.launchUrl(captureAny(), any())).captured.single
          as String;

  group('UrlLauncherUtils.launch', () {
    group('input validation', () {
      test('reportsErrorAndDoesNotLaunchWhenUrlIsEmpty', () async {
        await UrlLauncherUtils.launch('', onError: onError);

        expect(errors, ['Link not available.']);
        verifyNever(() => mockPlatform.launchUrl(any(), any()));
      });

      test('reportsErrorAndDoesNotLaunchWhenUrlIsWhitespaceOnly', () async {
        await UrlLauncherUtils.launch('   ', onError: onError);

        expect(errors, ['Link not available.']);
        verifyNever(() => mockPlatform.launchUrl(any(), any()));
      });

      test('trimsSurroundingWhitespaceBeforeLaunching', () async {
        await UrlLauncherUtils.launch('  https://example.com  ');

        expect(capturedLaunchUrl(), 'https://example.com');
      });
    });

    group('scheme handling', () {
      test('launchesValidHttpsUrlUnchanged', () async {
        await UrlLauncherUtils.launch('https://example.com');

        expect(capturedLaunchUrl(), 'https://example.com');
      });

      test('launchesValidHttpUrlUnchanged', () async {
        await UrlLauncherUtils.launch('http://example.com');

        expect(capturedLaunchUrl(), 'http://example.com');
      });

      test('prependsHttpsWhenSchemeIsMissing', () async {
        await UrlLauncherUtils.launch('example.com');

        expect(capturedLaunchUrl(), 'https://example.com');
      });

      test('preservesNonHttpSchemesSuchAsMailto', () async {
        await UrlLauncherUtils.launch('mailto:test@example.com');

        expect(capturedLaunchUrl(), 'mailto:test@example.com');
      });

      test('unwrapsSchemeWrappedInHttpsPrefix', () async {
        await UrlLauncherUtils.launch('https://mailto://test@example.com');

        expect(capturedLaunchUrl(), 'mailto://test@example.com');
      });

      test('unwrapsSchemeWrappedInHttpPrefix', () async {
        await UrlLauncherUtils.launch('http://tel://12345');

        expect(capturedLaunchUrl(), 'tel://12345');
      });
    });

    group('launch behaviour', () {
      test('attemptsLaunchEvenWhenCanLaunchReturnsFalse', () async {
        when(() => mockPlatform.canLaunch(any())).thenAnswer((_) async => false);

        await UrlLauncherUtils.launch('https://example.com', onError: onError);

        verify(() => mockPlatform.launchUrl(any(), any())).called(1);
        expect(errors, isEmpty);
      });

      test('doesNotReportErrorOnSuccessfulLaunch', () async {
        await UrlLauncherUtils.launch('https://example.com', onError: onError);

        expect(errors, isEmpty);
      });

      test('forwardsLaunchModeToPlatform', () async {
        await UrlLauncherUtils.launch(
          'https://example.com',
          mode: LaunchMode.inAppWebView,
        );

        final options = verify(
          () => mockPlatform.launchUrl(any(), captureAny()),
        ).captured.single as LaunchOptions;
        expect(options.mode, PreferredLaunchMode.inAppWebView);
      });

      test('defaultsToExternalApplicationLaunchMode', () async {
        await UrlLauncherUtils.launch('https://example.com');

        final options = verify(
          () => mockPlatform.launchUrl(any(), captureAny()),
        ).captured.single as LaunchOptions;
        expect(options.mode, PreferredLaunchMode.externalApplication);
      });
    });

    group('failure handling', () {
      test('reportsErrorWhenLaunchReturnsFalse', () async {
        when(
          () => mockPlatform.launchUrl(any(), any()),
        ).thenAnswer((_) async => false);

        await UrlLauncherUtils.launch('https://example.com', onError: onError);

        expect(errors, ['Could not open the link.']);
      });

      test('reportsErrorWhenLaunchThrows', () async {
        when(
          () => mockPlatform.launchUrl(any(), any()),
        ).thenThrow(Exception('platform failure'));

        await UrlLauncherUtils.launch('https://example.com', onError: onError);

        expect(errors, ['Could not open the link.']);
      });

      test('reportsErrorWhenCanLaunchThrows', () async {
        when(
          () => mockPlatform.canLaunch(any()),
        ).thenThrow(Exception('platform failure'));

        await UrlLauncherUtils.launch('https://example.com', onError: onError);

        expect(errors, ['Could not open the link.']);
      });

      test('doesNotThrowWhenOnErrorCallbackIsNull', () async {
        when(
          () => mockPlatform.launchUrl(any(), any()),
        ).thenAnswer((_) async => false);

        await expectLater(
          UrlLauncherUtils.launch('https://example.com'),
          completes,
        );
      });
    });
  });
}

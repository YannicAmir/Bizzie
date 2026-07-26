import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bizzie/shared/widgets/brightness_aware_logo_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _tSurfaceColor = Color(0xFF101820);
const _tTertiaryColor = Color(0xFF00E5A0);
const _tSize = 64.0;
const _tBorderRadius = 12.0;
const _tSourceExtent = 40;

/// Encodes a solid-colour square as PNG bytes so a [MemoryImage] can decode to
/// a deterministic, known luminance during the test.
Future<Uint8List> _solidColorPng(Color color) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  canvas.drawRect(
    Rect.fromLTWH(0, 0, _tSourceExtent.toDouble(), _tSourceExtent.toDouble()),
    Paint()..color = color,
  );
  final image = await recorder.endRecording().toImage(
        _tSourceExtent,
        _tSourceExtent,
      );
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  image.dispose();
  return byteData!.buffer.asUint8List();
}

ThemeData _buildTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2196F3)).copyWith(
      surface: _tSurfaceColor,
      tertiary: _tTertiaryColor,
    ),
  );
}

Widget _wrap(ImageProvider imageProvider) {
  return MaterialApp(
    theme: _buildTheme(),
    home: Scaffold(
      body: Center(
        child: BrightnessAwareLogoTile(
          imageProvider: imageProvider,
          size: _tSize,
          borderRadius: _tBorderRadius,
        ),
      ),
    ),
  );
}

/// Drives real image decoding + the asynchronous luminance sampling to
/// completion. Both rely on real async work, so the pumps run inside
/// [WidgetTester.runAsync] with real delays between frames.
Future<void> _settleLuminance(WidgetTester tester) async {
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 20));
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
}

Color _tileBackgroundColor(WidgetTester tester) {
  final container = tester.widget<Container>(
    find.descendant(
      of: find.byType(BrightnessAwareLogoTile),
      matching: find.byType(Container),
    ),
  );
  return (container.decoration! as BoxDecoration).color!;
}

void main() {
  group('BrightnessAwareLogoTile', () {
    testWidgets(
      'build_nearWhiteLogo_usesTertiaryBackground',
      (tester) async {
        await tester.runAsync(() async {
          // arrange
          final whiteLogo = MemoryImage(
            await _solidColorPng(const Color(0xFFFFFFFF)),
          );

          // act
          await tester.pumpWidget(_wrap(whiteLogo));
          await _settleLuminance(tester);

          // assert
          expect(_tileBackgroundColor(tester), _tTertiaryColor);
        });
      },
    );

    testWidgets(
      'build_darkLogo_usesSurfaceBackground',
      (tester) async {
        await tester.runAsync(() async {
          // arrange
          final blackLogo = MemoryImage(
            await _solidColorPng(const Color(0xFF000000)),
          );

          // act
          await tester.pumpWidget(_wrap(blackLogo));
          await _settleLuminance(tester);

          // assert
          expect(_tileBackgroundColor(tester), _tSurfaceColor);
        });
      },
    );

    testWidgets(
      'didUpdateWidget_providerSwappedFromNearWhite_appliesNewLogoBackground',
      (tester) async {
        await tester.runAsync(() async {
          // arrange
          final whiteLogo = MemoryImage(
            await _solidColorPng(const Color(0xFFFFFFFF)),
          );
          final blackLogo = MemoryImage(
            await _solidColorPng(const Color(0xFF000000)),
          );
          await tester.pumpWidget(_wrap(whiteLogo));
          await _settleLuminance(tester);
          expect(_tileBackgroundColor(tester), _tTertiaryColor);

          // act
          await tester.pumpWidget(_wrap(blackLogo));
          await _settleLuminance(tester);

          // assert
          // The near-white result from the previous provider must not persist;
          // the generation guard discards it and the dark logo wins.
          expect(_tileBackgroundColor(tester), _tSurfaceColor);
        });
      },
    );
  });
}

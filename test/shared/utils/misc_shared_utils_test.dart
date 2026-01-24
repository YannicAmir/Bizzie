import 'dart:async';
import 'package:bizzie/shared/utils/go_router_refresh_stream.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GoRouterRefreshStream', () {
    test('notifiesListenersOnStreamEvent', () async {
      final controller = StreamController<int>();

      int notifyCount = 0;
      final refreshStream = GoRouterRefreshStream(controller.stream);
      refreshStream.addListener(() {
        notifyCount++;
      });

      expect(notifyCount, 0);

      controller.add(1);
      await Future.delayed(Duration.zero);
      expect(notifyCount, 1);

      refreshStream.dispose();
      controller.close();
    });
  });
}

import 'package:bizzie/core/interfaces/i_in_app_review_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('InAppReviewService');

@LazySingleton(as: IInAppReviewService)
class InAppReviewService implements IInAppReviewService {
  final InAppReview _inAppReview;

  InAppReviewService() : _inAppReview = InAppReview.instance;

  @visibleForTesting
  InAppReviewService.test(this._inAppReview);

  @override
  Future<bool> isAvailable() async {
    return await _inAppReview.isAvailable();
  }

  @override
  Future<void> requestReview() async {
    if (await isAvailable()) {
      _logger.info('Prompting for in-app review.');
      await _inAppReview.requestReview();
    } else {
      _logger.warning('In-app review requested but service is unavailable.');
    }
  }
}

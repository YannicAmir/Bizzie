abstract class IInAppReviewService {
  Future<bool> isAvailable();
  Future<void> requestReview();
}

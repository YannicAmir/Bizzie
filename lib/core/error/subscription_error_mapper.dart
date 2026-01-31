import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/subscription/domain/constants/subscription_constants.dart';

class SubscriptionErrorMapper {
  static Failure map(dynamic error) {
    if (error is PlatformException) {
      try {
        final errorCode = PurchasesErrorHelper.getErrorCode(error);

        switch (errorCode) {
          case PurchasesErrorCode.purchaseCancelledError:
            return const Failure.cancel(SubscriptionConstants.errorCancelled);
          case PurchasesErrorCode.networkError:
          case PurchasesErrorCode.offlineConnectionError:
            return const Failure.server(SubscriptionConstants.errorNetwork);
          case PurchasesErrorCode.paymentPendingError:
            return const Failure.payment(
              'Payment is pending. Please check your store account.',
            );
          default:
            final message = error.message?.toLowerCase() ?? '';
            if (message.contains('insufficient') || message.contains('funds')) {
              return const Failure.payment(
                'Insufficient funds. Please check your account.',
              );
            }
            return Failure.server(
              error.message ?? SubscriptionConstants.errorGeneric,
            );
        }
      } catch (_) {
        return Failure.server(error.toString());
      }
    }

    if (error is PurchasesError) {
      if (error.code == PurchasesErrorCode.purchaseCancelledError) {
        return const Failure.cancel(SubscriptionConstants.errorCancelled);
      }
      return Failure.server(error.message);
    }

    return Failure.server(error.toString());
  }
}

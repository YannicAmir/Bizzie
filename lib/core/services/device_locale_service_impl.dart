import 'dart:io';
import 'package:bizzie/core/interfaces/i_device_locale_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IDeviceLocaleService)
class DeviceLocaleServiceImpl implements IDeviceLocaleService {
  @override
  String get preferredCurrency {
    final locale = Platform.localeName;
    if (locale.contains('_CA')) {
      return 'CAD';
    }
    return 'USD';
  }
}
